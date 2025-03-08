import 'package:adhikar3_o/features/auth/controller/auth_controller.dart';
import 'package:adhikar3_o/features/profile/views/add_education.dart';
import 'package:adhikar3_o/features/profile/views/add_experience.dart';
import 'package:adhikar3_o/models/user_model.dart';
import 'package:adhikar3_o/theme/pallete_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileView extends ConsumerStatefulWidget {
  final UserModel userModel;
  const ProfileView({super.key, required this.userModel});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDataProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile on Adhikar'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: Pallete.primaryColor,
                        child: CircleAvatar(
                          radius: 42,
                          backgroundImage: widget.userModel.profileImage == ''
                              ? NetworkImage(
                                  'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=600')
                              : NetworkImage(widget.userModel.profileImage),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                widget.userModel.firstName +
                                    ' ' +
                                    widget.userModel.lastName,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            SizedBox(height: 5),
                            Text(
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                widget.userModel.bio == ''
                                    ? 'Adhikar user'
                                    : widget.userModel.bio,
                                style: TextStyle(fontSize: 15)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                widget.userModel.uid == currentUser.value!.uid
                    ? Image.asset(
                        'assets/icons/ic_post.png',
                        height: 25,
                        color: Pallete.primaryColor,
                      )
                    : SizedBox(),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Image.asset(
                  'assets/icons/ic_location.png',
                  height: 25,
                  color: Pallete.greyColor,
                ),
                SizedBox(width: 5),
                Text(
                    widget.userModel.location == ''
                        ? 'India, India'
                        : widget.userModel.location,
                    style: TextStyle(
                      color: Pallete.greyColor,
                    )),
                SizedBox(width: 20),
                Image.asset(
                  'assets/icons/ic_calender.png',
                  height: 25,
                  color: Pallete.greyColor,
                ),
                SizedBox(width: 5),
                Text('Joined on ${widget.userModel.createdAt}',
                    style: TextStyle(
                      color: Pallete.greyColor,
                    )),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Image.asset(
                  'assets/icons/ic_linkedin.png',
                  height: 40,
                ),
                SizedBox(width: 9),
                Image.asset(
                  'assets/icons/ic_instagram.png',
                  height: 40,
                ),
                SizedBox(width: 9),
                Image.asset(
                  'assets/icons/ic_x.png',
                  height: 40,
                ),
                SizedBox(width: 9),
                Image.asset(
                  'assets/icons/ic_facebook.png',
                  height: 40,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Pallete.primaryColor,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 9.0),
                        child: Text(
                          //condition if user follows or not will come here
                          widget.userModel.uid == currentUser.value!.uid
                              ? '18 Followers'
                              : 'Follow',
                          style: TextStyle(
                            color: Pallete.whiteColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Pallete.primaryColor),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/ic_message.png',
                              height: 25,
                              color: Pallete.primaryColor,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Messages',
                              style: TextStyle(
                                color: Pallete.primaryColor,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TabBar(
              controller: _tabController,
              labelColor: Pallete.primaryColor,
              unselectedLabelColor: Pallete.greyColor,
              tabs: [
                Tab(child: Text('About', style: TextStyle(fontSize: 17))),
                Tab(child: Text('Posts', style: TextStyle(fontSize: 17))),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text('Summary',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text(
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        widget.userModel.summary == ''
                            ? 'Adhikar user'
                            : widget.userModel.summary,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Experience',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          widget.userModel.uid == currentUser.value!.uid
                              ? GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AddExperience())),
                                  child: Image.asset(
                                    'assets/icons/ic_add.png',
                                    height: 25,
                                    color: Pallete.primaryColor,
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Education',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          widget.userModel.uid == currentUser.value!.uid
                              ? GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AddEducation())),
                                  child: Image.asset(
                                    'assets/icons/ic_add.png',
                                    height: 25,
                                    color: Pallete.primaryColor,
                                  ),
                                )
                              : SizedBox(),
                        ],
                      )
                    ],
                  ),
                  Center(child: Text('Posts')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
