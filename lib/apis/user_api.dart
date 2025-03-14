import 'package:adhikar3_o/common/failure.dart';
import 'package:adhikar3_o/common/providers/providers.dart';
import 'package:adhikar3_o/common/type_def.dart';
import 'package:adhikar3_o/constants/appwrite_constants.dart';
import 'package:adhikar3_o/models/lawyer_model.dart';
import 'package:adhikar3_o/models/user_model.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final userAPIProvider = Provider((ref) {
  return UserAPI(
      db: ref.watch(appwriteDatabaseProvider),
      realtime: ref.watch(appwriteRealTimeProvider));
});

abstract class IUserAPI {
  FutureEitherVoid saveUserData(UserModel userModel);
  Future<Document> getUserData(String uid);
  Future<List<Document>> searchUser(String name);
  FutureEitherVoid updateUser(UserModel userModel);
  Stream<RealtimeMessage> getLatestUserProfileData();
  FutureEitherVoid addToFollowers(UserModel userModel);
  FutureEitherVoid applyForLawyer(UserModel userModel, LawyerModel lawyerModel);
  FutureEitherVoid addToFollowing(UserModel userModel);
}

class UserAPI implements IUserAPI {
  final Databases _db;
  final Realtime _realtime;
  UserAPI({required Databases db, required Realtime realtime})
      : _db = db,
        _realtime = realtime;
  @override
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try {
      await _db.createDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.usersCollectionId,
          documentId: userModel.uid,
          data: userModel.toMap());
      return right(null);
    } catch (err, stackTrace) {
      return left(Failure(err.toString(), stackTrace));
    }
  }

  @override
  Future<Document> getUserData(String uid) {
    print('get suer data ${uid}');
    return _db.getDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.usersCollectionId,
        documentId: uid);
  }

  @override
  Future<List<Document>> searchUser(String name) async {
    final documents = await _db.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.usersCollectionId,
        queries: [
          Query.search('firstName', name),
        ]);

    return documents.documents;
  }

  @override
  FutureEitherVoid updateUser(UserModel userModel) async {
    try {
      await _db.updateDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.usersCollectionId,
          documentId: userModel.uid,
          data: userModel.toMap());
      return right(null);
    } catch (err, stackTrace) {
      return left(Failure(err.toString(), stackTrace));
    }
  }

  @override
  Stream<RealtimeMessage> getLatestUserProfileData() {
    return _realtime.subscribe([
      'databases.${AppwriteConstants.databaseId}.collections.${AppwriteConstants.usersCollectionId}.documents'
    ]).stream;
  }

  @override
  FutureEitherVoid addToFollowers(UserModel userModel) async {
    try {
      await _db.updateDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.usersCollectionId,
          documentId: userModel.uid,
          data: {'followers': userModel.followers});
      return right(null);
    } catch (err, stackTrace) {
      return left(Failure(err.toString(), stackTrace));
    }
  }

  @override
  FutureEitherVoid addToFollowing(UserModel userModel) async {
    try {
      await _db.updateDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.usersCollectionId,
          documentId: userModel.uid,
          data: {'following': userModel.following});
      return right(null);
    } catch (err, stackTrace) {
      return left(Failure(err.toString(), stackTrace));
    }
  }

  @override
  FutureEitherVoid applyForLawyer(
      UserModel userModel, LawyerModel lawyerModel) async {
    try {
      //update usertype in usermodel
      await _db.updateDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.usersCollectionId,
          documentId: userModel.uid,
          data: {'userType': userModel.userType});

      //create lawyermodel
      await _db.createDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.lawyersCollectionId,
          documentId: userModel.uid,
          data: lawyerModel.toMap());
      return right(null);
    } catch (err, stackTrace) {
      return left(Failure(err.toString(), stackTrace));
    }
  }

  @override
  Future<List<Document>> getLawyers() async {
    final documents = await _db.listDocuments(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.lawyersCollectionId,
    );

    return documents.documents;
  }
}
