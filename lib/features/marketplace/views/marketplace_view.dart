import 'package:adhikar3_o/common/widgets/error_text.dart';
import 'package:adhikar3_o/common/widgets/loader.dart';
import 'package:adhikar3_o/features/auth/controller/auth_controller.dart';
import 'package:adhikar3_o/features/marketplace/views/lawyer_profile_view.dart';
import 'package:adhikar3_o/features/marketplace/widgets/lawyer_card.dart';
import 'package:adhikar3_o/theme/pallete_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MarketPlaceScreen extends ConsumerStatefulWidget {
  const MarketPlaceScreen({super.key});

  @override
  ConsumerState<MarketPlaceScreen> createState() => _MarketPlaceScreenState();
}

class _MarketPlaceScreenState extends ConsumerState<MarketPlaceScreen> {
  final List<String> categories = [
    'All',
    'Criminal',
    'Civil',
    'Tax',
    'Home',
    'Divorce',
    'Finance'
  ];
  void navigateToSearchScreen(String query) {
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return SearchScreen(query: query.toString());
    // }));
  }

  String isActive = 'All';

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ref.watch(getLawyersListProvider).when(
            data: (lawyer) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  color: Pallete.primaryColor),
                              height: 200,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 30),
                                  const Text(
                                    'Hi User, 👋',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Find lawyer’s to get your case resolved',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    onFieldSubmitted: navigateToSearchScreen,
                                    cursorColor: Colors.white,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300),
                                    decoration: InputDecoration(
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          'assets/icons/search.png',
                                          height: 10,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.grey)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.white)),
                                      hintText: 'Search for Lawyers, Category',
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'By Category',
                            style: TextStyle(
                                color: Pallete.primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 3.0, bottom: 10),
                      child: SizedBox(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  isActive = categories[index];
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Card(
                                  elevation: 3,
                                  color: isActive == categories[index]
                                      ? Pallete.primaryColor
                                      : Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 10),
                                    child: Center(
                                      child: Text(
                                        categories[index],
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: isActive == categories[index]
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return LawyerProfileScreen(
                                caseWon: lawyer[index].casesWon,
                                desccription: lawyer[index].description,
                                fees: '1999',
                                firstName: 'Adv. ${lawyer[index].firstName}',
                                lastName: lawyer[index].lastName,
                                uid: lawyer[index].uid,
                                location: '${lawyer[index].city}, ${lawyer[index].state}',
                                email: lawyer[index].email,
                                ratings: '2',
                                experience: lawyer[index].experience,
                                profImage: lawyer[index].profImage,
                              );
                            }));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 5),
                            child: LawyerCard(
                              caseWon: lawyer[index].casesWon,
                              fees: '1999',
                              lawyerName:
                                  'Adv. ${lawyer[index].firstName} ${lawyer[index].lastName}',
                              location:
                                  '${lawyer[index].city}, ${lawyer[index].state}',
                              profilePic: lawyer[index].profImage,
                              ratings: '2',
                              experience: lawyer[index].experience,
                            ),
                          ),
                        );
                      },
                      childCount: lawyer.length,
                    ),
                  ),
                ],
              );
            },
            error: (error, st) => ErrorText(error: error.toString()),
            loading: () => LoadingPage()));
  }
}
