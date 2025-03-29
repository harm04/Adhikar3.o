
// import 'package:adhikar3_o/theme/pallete_theme.dart';
// import 'package:dash_chat_2/dash_chat_2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_gemini/flutter_gemini.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:speech_to_text/speech_to_text.dart';
// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final SpeechToText _speechToText = SpeechToText();
//   bool islistening = false;
//   String wordsSpoken = "";

//   void checkMic() async {
//     bool micAvailable = await _speechToText.initialize();
//     if (micAvailable) {
//       print("Mic is ready");
//     }
//     print("mic not ready");
//   }

//   @override
//   void initState() {
//     super.initState();
//     checkMic();
//   }

//   final Gemini gemini = Gemini.instance;
//   List<ChatMessage> messages = [];
//   bool isLoading = false;
//   String partialResponse = '';

//   final ChatUser currentUser = ChatUser(id: "0", firstName: "User");
//   final ChatUser geminiUser = ChatUser(
//     id: "1",
//     firstName: "NyaySahayak",
//     profileImage:
//         "https://image.cdn2.seaart.me/2024-02-11/cn47s2de878c73f76sig/9ec34ac1dd435fbe18a06c1d833daa1bd60ba809_high.webp",
//   );
//   String cleanResponse(String response) {
//     return response.replaceAll(RegExp(r'\*'), '');
//   }

//   Future<void> _handleMessage(ChatMessage message) async {
    
//     setState(() {
//       messages.insert(0, message);
//       isLoading = true;
//       partialResponse = '';
//     });

//     try {
//       String prompt = '''
//       Please provide a clear and concise response (preferably under 200 words).
//       Context: ${message.text}
//       ''';

//       await for (final event in gemini.streamGenerateContent(prompt)) {
//         final rawText = event.content?.parts?.firstOrNull ?? '';
//         final text = cleanResponse(rawText.toString());
//         if (text.isNotEmpty) {
//           setState(() {
//             partialResponse += text;

//             if (messages.length > 1 && messages[0].user.id == geminiUser.id) {
//               messages[0] = ChatMessage(
//                 user: geminiUser,
//                 createdAt: DateTime.now(),
//                 text: partialResponse.trim(),
//               );
//             } else {
//               messages.insert(
//                   0,
//                   ChatMessage(
//                     user: geminiUser,
//                     createdAt: DateTime.now(),
//                     text: partialResponse.trim(),
//                   ));
//             }
//           });
//         }
//       }

    
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: ${e.toString()}')),
//       );
//     } finally {
//       setState(() {
//         isLoading = false;
//         partialResponse = '';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Pallete.primaryColor,
//         systemOverlayStyle: const SystemUiOverlayStyle(
//             statusBarColor: Pallete.primaryColor,
//             statusBarIconBrightness: Brightness.light),
//         iconTheme: const IconThemeData(color: Colors.white),
//         title: const Text(
//           'NyaySahayak',
//           style: TextStyle(color: Colors.white),
//         ),
       
//       ),
//       body: Stack(
//         children: [
//           DashChat(
//             inputOptions: InputOptions(
//               trailing: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: GestureDetector(
//                       onTap: () async {
//                         if (!islistening) {
//                           bool micAvailable = await _speechToText.initialize();
//                           if (micAvailable) {
//                             setState(() {
//                               islistening = true;
//                             });
//                             _speechToText.listen(onResult: (result) {
//                               setState(() {
//                                 wordsSpoken = result.recognizedWords;
//                                 islistening = false;
//                                 if (result.finalResult) {
//                                   islistening = false;

//                                   ChatMessage voiceMessage = ChatMessage(
//                                     user: currentUser,
//                                     createdAt: DateTime.now(),
//                                     text: wordsSpoken,
//                                   );

//                                   _handleMessage(voiceMessage);

//                                   wordsSpoken = "";
//                                 }
//                               });
//                             });
//                           }
//                         } else {
//                           setState(() {
//                             _speechToText.stop();

//                             islistening = false;
//                           });
//                         }
//                       },
//                       child: islistening
//                           ? CircleAvatar(
//                               radius: 25,
//                               backgroundColor: Colors.red[400],
//                               child: Image.asset(
//                                 'assets/icons/ic_mic_off.png',
//                                 height: 30,
//                               ),
//                             )
//                           : CircleAvatar(
//                               radius: 25,
//                               backgroundColor: Pallete.primaryColor,
//                               child: Image.asset(
//                                 'assets/icons/ic_mic_on.png',
//                                 height: 30,
//                                 color: Colors.white,
//                               ),
//                             )),
//                 ),
//               ],
//               sendOnEnter: true,
//               textInputAction: TextInputAction.send,
//               inputTextStyle: const TextStyle(
//                 color: Colors.black,
//                 fontSize: 16,
//               ),
//               inputDecoration: InputDecoration(
//                 hintText: 'Ask me anything...',
//                 hintStyle: TextStyle(
//                   color: Colors.grey[600],
//                   fontSize: 16,
//                 ),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                     borderSide: const BorderSide(color: Pallete.primaryColor)),
//                 focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                     borderSide: const BorderSide(
//                       color: Pallete.primaryColor,
//                     )),
//                 filled: true,
//                 fillColor: Colors.grey[100],
//               ),
//             ),
//             messageOptions: const MessageOptions(
//                 showTime: true,
//                 textColor: Colors.black,
//                 currentUserContainerColor: Pallete.primaryColor),
//             currentUser: currentUser,
//             onSend: _handleMessage,
//             messages: messages,
//           ),
//           isLoading
//               ? Positioned(
//                   bottom: 70,
//                   left: 10,
//                   child: Center(
//                     child: LoadingAnimationWidget.staggeredDotsWave(
//                       color: Pallete.primaryColor,
//                       size: 40,
//                     ),
//                   ),
//                 )
//               : const SizedBox(),
//           messages.isEmpty
//               ? Positioned(
//                   top: 70,
//                   left: 20,
//                   right: 20,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'Hey There 👋',
//                         style:
//                             const TextStyle(color: Pallete.primaryColor, fontSize: 20),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       const Text(
//                         'Welcome to our NyaySahayak-Bot. Ask any question without any hesitation',
//                         style: TextStyle(color: Pallete.primaryColor, fontSize: 16),
//                       ),
//                       const SizedBox(
//                         height: 40,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           ChatMessage clickMessage = ChatMessage(
//                               user: currentUser,
//                               createdAt: DateTime.now(),
//                               text: 'Give me some information over civil laws');
//                           _handleMessage(clickMessage);
//                         },
//                         child: SizedBox(
//                           height: 50,
//                           child: Card(
//                             elevation: 20,
//                             child: Center(
//                                 child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Image.asset(
//                                   'assets/images/img_ellipse.png',
//                                   height: 20,
//                                 ),
//                                 const SizedBox(
//                                   width: 10,
//                                 ),
//                                 const Text(
//                                   'Give information over civil laws',
//                                   style: TextStyle(fontSize: 18),
//                                 ),
//                               ],
//                             )),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           ChatMessage clickMessage = ChatMessage(
//                               user: currentUser,
//                               createdAt: DateTime.now(),
//                               text: 'What is Section 390?');
//                           _handleMessage(clickMessage);
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                           child: SizedBox(
//                             height: 50,
//                             child: Card(
//                               elevation: 20,
//                               child: Center(
//                                   child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Image.asset(
//                                     'assets/images/img_ellipse.png',
//                                     height: 20,
//                                   ),
//                                   const SizedBox(
//                                     width: 10,
//                                   ),
//                                   const Text(
//                                     'What is Section 390?',
//                                     style: TextStyle(fontSize: 18),
//                                   ),
//                                 ],
//                               )),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           ChatMessage clickMessage = ChatMessage(
//                               user: currentUser,
//                               createdAt: DateTime.now(),
//                               text: 'How do I file a case ?');
//                           _handleMessage(clickMessage);
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                           child: SizedBox(
//                             height: 50,
//                             width: MediaQuery.of(context).size.width,
//                             child: Card(
//                               elevation: 20,
//                               child: Center(
//                                   child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Image.asset(
//                                     'assets/images/img_ellipse.png',
//                                     height: 20,
//                                   ),
//                                   const SizedBox(
//                                     width: 10,
//                                   ),
//                                   const Text(
//                                     'How do I file a case ?',
//                                     style: TextStyle(fontSize: 18),
//                                   ),
//                                 ],
//                               )),
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ))
//               : const SizedBox(),
//           Center(
//             child: Text(
//               wordsSpoken.toString(),
//               style: const TextStyle(color: Colors.black),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
