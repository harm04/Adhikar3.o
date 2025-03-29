import 'package:adhikar3_o/features/nyaysahayak/widgets/answer_section.dart';
import 'package:adhikar3_o/features/nyaysahayak/widgets/side_bar.dart';
import 'package:adhikar3_o/features/nyaysahayak/widgets/sources_section.dart';
import 'package:adhikar3_o/theme/pallete_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class ChatPage extends StatelessWidget {
  final String question;
  const ChatPage({
    super.key,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          kIsWeb ? SideBar() : SizedBox(),
          kIsWeb ? const SizedBox(width: 100) : SizedBox(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 24),
                    SourcesSection(),
                    SizedBox(height: 24),
                    AnswerSection(),
                  ],
                ),
              ),
            ),
          ),
          kIsWeb
              ? Placeholder(
                  strokeWidth: 0,
                  color: AppColors.background,
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
