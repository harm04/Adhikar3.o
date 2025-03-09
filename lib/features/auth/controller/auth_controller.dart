import 'package:adhikar3_o/apis/auth_api.dart';
import 'package:adhikar3_o/apis/storage_api.dart';
import 'package:adhikar3_o/apis/user_api.dart';
import 'package:adhikar3_o/common/widgets/bottom_nav_bar.dart';
import 'package:adhikar3_o/common/widgets/snackbar.dart';
import 'package:adhikar3_o/features/auth/views/login_view.dart';
import 'package:adhikar3_o/models/user_model.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'dart:io';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authAPI: ref.watch(authAPIProvider),
    userAPI: ref.watch(userAPIProvider),
    storageApi: ref.watch(storageAPIProvider),
  );
});

final currentUserDataProvider = FutureProvider((ref) async {
  final currentUserId = ref.watch(currentUserAccountProvider).value!.$id;
  final userData = ref.watch(userDataProvider(currentUserId));
  return userData.value;
});

final userDataProvider = FutureProvider.family((ref, String uid) async {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

final getlatestUserDataProvider = StreamProvider((ref) {
  final userApi = ref.watch(userAPIProvider);
  return userApi.getLatestUserProfileData();
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final UserAPI _userAPI;
  final StorageApi _storageApi;
  AuthController(
      {required AuthAPI authAPI,
      required UserAPI userAPI,
      required StorageApi storageApi})
      : _authAPI = authAPI,
        _userAPI = userAPI,
        _storageApi = storageApi,
        super(false);

  void signUp(
      {required String email,
      required String firstName,
      required String lastName,
      required String password,
      required BuildContext context}) async {
    state = true;
    final res = await _authAPI.signUp(email: email, password: password);
    state = false;
    res.fold((l) => ShowSnackbar(context, l.message), (r) async {
      UserModel userModel = UserModel(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          profileImage: '',
          bio: '',
          createdAt: DateFormat("MMM dd").format(DateTime.now()),
          summary: '',
          following: [],
          followers: [],
          bookmarked: [],
          isVerified: false,
          uid: r.$id,
          location: '',
          linkedin: '',
          twitter: '',
          instagram: '',
          facebook: '',
          experienceTitle: '',
          experienceSummary: '',
          experienceOrganization: '',
          eduStream: '',
          eduDegree: '',
          eduUniversity: '',
          userType: 'User');

      final res2 = await _userAPI.saveUserData(userModel);
      res2.fold((l) => ShowSnackbar(context, l.message), (r) {
        null;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
      ShowSnackbar(context, 'Welcome ${r.email}. Please login to continue');
    });
  }

  void login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final res = await _authAPI.login(email: email, password: password);
    state = false;
    res.fold((l) => ShowSnackbar(context, l.message), (r) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BottomNavBar()));
      ShowSnackbar(context, 'Welcome $email. You are successfully logged in');
    });
  }

  Future<models.User?> currentUser() => _authAPI.currentUserAccount();

  void signout(BuildContext context) async {
    state = true;
    await _authAPI.signout();

    state = false;
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return LoginScreen();
    }), (Route) => false);
  }

  Future<UserModel> getUserData(String uid) async {
    final document = await _userAPI.getUserData(uid);
    final updatedUser = UserModel.fromMap(document.data);
    return updatedUser;
  }

  void updateUser({
    required UserModel userModel,
    required BuildContext context,
    required File? profileImage,
    required String firstName,
    required String lastName,
    required String bio,
    required String location,
    required String linkedin,
    required String twitter,
    required String instagram,
    required String facebook,
    required String summary,
  }) async {
    state = true;
    if (profileImage != null) {
      final profileUrl = await _storageApi.uploadFiles([profileImage]);
      userModel = userModel.copyWith(profileImage: profileUrl[0]);
    }
    if (firstName != userModel.firstName) {
      userModel = userModel.copyWith(firstName: firstName);
    }
    if (lastName != userModel.lastName) {
      userModel = userModel.copyWith(lastName: lastName);
    }
    if (bio.isNotEmpty && bio != 'Adhikar user' && bio != userModel.bio) {
      userModel = userModel.copyWith(bio: bio);
    }
    if (location.isNotEmpty && location != userModel.location) {
      userModel = userModel.copyWith(location: location);
    }
    if (linkedin.isNotEmpty && linkedin != userModel.linkedin) {
      userModel = userModel.copyWith(linkedin: linkedin);
    }
    if (twitter.isNotEmpty && twitter != userModel.twitter) {
      userModel = userModel.copyWith(twitter: twitter);
    }
    if (instagram.isNotEmpty && instagram != userModel.instagram) {
      userModel = userModel.copyWith(instagram: instagram);
    }
    if (facebook.isNotEmpty && facebook != userModel.facebook) {
      userModel = userModel.copyWith(facebook: facebook);
    }
    if (summary.isNotEmpty &&
        summary != 'Adhikar user' &&
        summary != userModel.summary) {
      userModel = userModel.copyWith(summary: summary);
    }

    final res = await _userAPI.updateUser(userModel);
    state = false;
    res.fold((l) => ShowSnackbar(context, l.message), (r) {
      ShowSnackbar(context, 'Profile updated successfully');
      Navigator.pop(context);
    });
  }

  void followUser({
    required UserModel userModel,
    required UserModel currentUser,
    required BuildContext context,
  }) async {
    state = true;
    if (currentUser.following.contains(userModel.uid)) {
      currentUser.following.remove(userModel.uid);
      userModel.followers.remove(currentUser.uid);
    } else {
      currentUser.following.add(userModel.uid);
      userModel.followers.add(currentUser.uid);
    }
    userModel = userModel.copyWith(followers: userModel.followers);
    currentUser = currentUser.copyWith(following: currentUser.following);
    final res = await _userAPI.addToFollowers(userModel);
   
    res.fold((l) => ShowSnackbar(context, l.message), (r) async {
      final res2 = await _userAPI.addToFollowing(currentUser);
      res2.fold((l) => ShowSnackbar(context, l.message), (r) {
        null;
      });
      null;
    });
     state = false;
  }
}
