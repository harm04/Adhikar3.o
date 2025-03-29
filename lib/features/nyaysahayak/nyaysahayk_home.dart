
// import 'package:adhikar3_o/features/nyaysahayak/chat.dart';
// import 'package:adhikar3_o/features/nyaysahayak/doc_scanning.dart';
// import 'package:adhikar3_o/theme/pallete_theme.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class AIServices extends StatefulWidget {
//   const AIServices({super.key});

//   @override
//   State<AIServices> createState() => _AIServicesState();
// }

// class _AIServicesState extends State<AIServices> {
//   @override
//   Widget build(BuildContext context) {
   

//     return Scaffold(
//             appBar: AppBar(
//               backgroundColor: Pallete.primaryColor,
//               systemOverlayStyle: const SystemUiOverlayStyle(
//                   statusBarColor: Pallete.primaryColor,
//                   statusBarIconBrightness: Brightness.light),
//               iconTheme: const IconThemeData(color: Colors.white),
//               title: const Text(
//                 'NyaySahayak',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//             body: Padding(
//               padding: const EdgeInsets.all(18.0),
//               child: Column(
//                 children: [
//                   const SizedBox(
//                     height: 50,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) {
//                         return const DocumentScanning();
//                       }));
//                     },
//                     child: SizedBox(
//                         height: 70,
//                         width: MediaQuery.of(context).size.width,
//                         child: Card(
//                           elevation: 20,
//                           child: Row(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(10.0),
//                                 child: DottedBorder(
//                                     color: Colors.red,
//                                     strokeCap: StrokeCap.round,
//                                     strokeWidth: 1.3,
//                                     borderType: BorderType.RRect,
//                                     radius: const Radius.circular(100),
//                                     dashPattern: const [3, 5],
//                                     child: const SizedBox(
//                                       height: 40,
//                                       width: 40,
//                                       child: const Center(
//                                           child: Text(
//                                         '01',
//                                         style: TextStyle(
//                                             color: Colors.red,
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.bold),
//                                       )),
//                                     )),
//                               ),
//                               const Expanded(
//                                 child: const Text(
//                                   'Document Scanning',
//                                   style: TextStyle(
//                                       color: Pallete.primaryColor, fontSize: 18),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(right: 18.0),
//                                 child: Image.asset(
//                                   'assets/icons/ic_forward.png',
//                                   height: 15,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) {
//                         return const ChatScreen();
//                       }));
//                     },
//                     child: SizedBox(
//                         height: 70,
//                         width: MediaQuery.of(context).size.width,
//                         child: Card(
//                           elevation: 20,
//                           child: Row(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(10.0),
//                                 child: DottedBorder(
//                                     color: Colors.blue,
//                                     strokeCap: StrokeCap.round,
//                                     strokeWidth: 1.3,
//                                     borderType: BorderType.RRect,
//                                     radius: const Radius.circular(100),
//                                     dashPattern: const [3, 5],
//                                     child: const SizedBox(
//                                       height: 40,
//                                       width: 40,
//                                       child: const Center(
//                                           child: Text(
//                                         '02',
//                                         style: TextStyle(
//                                             color: Colors.blue,
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.bold),
//                                       )),
//                                     )),
//                               ),
//                               const Expanded(
//                                 child: const Text(
//                                   'ChatBot',
//                                   style: TextStyle(
//                                       color: Pallete.primaryColor, fontSize: 18),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(right: 18.0),
//                                 child: Image.asset(
//                                   'assets/icons/ic_forward.png',
//                                   height: 15,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )),
//                   ),
//                 ],
//               ),
//             ),
//           );
//   }
// }


import 'package:adhikar3_o/features/nyaysahayak/services/chat_web_service.dart';
import 'package:adhikar3_o/features/nyaysahayak/widgets/search_section.dart';
import 'package:adhikar3_o/features/nyaysahayak/widgets/side_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class NyaysahayakHomePage extends StatefulWidget {
  const NyaysahayakHomePage({super.key});

  @override
  State<NyaysahayakHomePage> createState() => _NyaysahayakHomePageState();
}

class _NyaysahayakHomePageState extends State<NyaysahayakHomePage> {
  @override
  void initState() {
    super.initState();
    ChatWebService().connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        kIsWeb ? SideBar() : SizedBox(),
        Expanded(
          child: Padding(
            padding: !kIsWeb ? const EdgeInsets.all(8.0) : EdgeInsets.zero,
            child: Column(
              children: [
                Expanded(
                  child: SearchSection(),
                ),
                // footer
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Pro",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Enterprise",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Store",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Blog",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Careers",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "English (English)",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}

