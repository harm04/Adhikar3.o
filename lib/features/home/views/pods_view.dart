import 'package:adhikar3_o/theme/pallete_theme.dart';
import 'package:flutter/material.dart';

class PodsView extends StatefulWidget {
  final String podimage;
  final String podTitle;
  final String podDescription;
  final String podBanner;
  const PodsView(
      {super.key,
      required this.podimage,
      required this.podTitle,
      required this.podDescription,
      required this.podBanner});

  @override
  State<PodsView> createState() => _PodsViewState();
}

class _PodsViewState extends State<PodsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(widget.podBanner, fit: BoxFit.cover),
                  Positioned(
                      bottom: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(1),
                              spreadRadius: 70,
                              blurRadius: 100,
                              blurStyle: BlurStyle.normal)
                        ]),
                      )),
                  Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 27,
                                backgroundImage: AssetImage(
                                  widget.podimage,
                                ),
                              ),
                              SizedBox(
                                width: 18,
                              ),
                              Text(
                                widget.podTitle,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Pallete.whiteColor),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Text(widget.podDescription,
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Pallete.whiteColor,
                                )),
                          )
                        ],
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
