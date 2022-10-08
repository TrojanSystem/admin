import 'package:flutter/material.dart';

class MyCustomWidget extends StatefulWidget {
  @override
  _MyCustomWidgetState createState() => _MyCustomWidgetState();
}

class _MyCustomWidgetState extends State<MyCustomWidget> {
  String bale_5 = 'ባለ 5 ብር';
  String bale_10 = 'ባለ 10 ብር';
  String slice = 'ስላይስ';
  String donut = 'ቦምቦሊኖ';
  String sentence = 'Here';
  bool isExpanded = true;
  bool isExpanded2 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: AnimatedContainer(
              margin: EdgeInsets.symmetric(
                horizontal: isExpanded ? 100 : 100,
                vertical: 20,
              ),
              padding: const EdgeInsets.all(20),
              height: isExpanded ? 85 : 330,
              curve: Curves.fastLinearToSlowEaseIn,
              duration: const Duration(milliseconds: 1200),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff6F12E8).withOpacity(0.5),
                    blurRadius: 20,
                    offset: const Offset(5, 10),
                  ),
                ],
                color: const Color(0xff6F12E8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(isExpanded ? 20 : 0),
                  topRight: Radius.circular(isExpanded ? 20 : 0),
                  bottomLeft: Radius.circular(isExpanded ? 20 : 20),
                  bottomRight: Radius.circular(isExpanded ? 20 : 20),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'images/bale_5.png',
                            width: 40,
                            height: 40,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            bale_5,
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up,
                        color: Colors.white,
                        size: 27,
                      ),
                    ],
                  ),
                  isExpanded ? const SizedBox() : const SizedBox(height: 20),
                  AnimatedCrossFade(
                    firstChild: const Text(
                      '',
                      style: TextStyle(
                        fontSize: 0,
                      ),
                    ),
                    secondChild: Text(
                      sentence,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15.7,
                      ),
                    ),
                    crossFadeState: isExpanded
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 1200),
                    reverseDuration: Duration.zero,
                    sizeCurve: Curves.fastLinearToSlowEaseIn,
                  ),
                ],
              ),
            ),
          ),
          // InkWell(
          //   highlightColor: Colors.transparent,
          //   splashColor: Colors.transparent,
          //   onTap: () {
          //     setState(() {
          //       isExpanded2 = !isExpanded2;
          //     });
          //   },
          //   child: AnimatedContainer(
          //     margin: EdgeInsets.symmetric(
          //       horizontal: isExpanded2 ? 50 : 50,
          //       vertical: 20,
          //     ),
          //     padding: const EdgeInsets.all(20),
          //     height: isExpanded2 ? 85 : 330,
          //     curve: Curves.fastLinearToSlowEaseIn,
          //     duration: const Duration(milliseconds: 1200),
          //     decoration: BoxDecoration(
          //       boxShadow: [
          //         BoxShadow(
          //           color: const Color(0xffFF5050).withOpacity(0.5),
          //           blurRadius: 20,
          //           offset: const Offset(5, 10),
          //         ),
          //       ],
          //       color: const Color(0xffFF5050),
          //       borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(isExpanded ? 20 : 0),
          //         topRight: Radius.circular(isExpanded ? 20 : 0),
          //         bottomLeft: Radius.circular(isExpanded ? 20 : 20),
          //         bottomRight: Radius.circular(isExpanded ? 20 : 20),
          //       ),
          //     ),
          //     child: Column(
          //       children: [
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //               mainAxisSize: MainAxisSize.min,
          //               children: [
          //                 Image.asset(
          //                   'images/bale_10.png',
          //                   width: 40,
          //                   height: 40,
          //                 ),
          //                 const SizedBox(
          //                   width: 15,
          //                 ),
          //                 Text(
          //                   bale_10,
          //                   style: const TextStyle(
          //                     fontWeight: FontWeight.w900,
          //                     color: Colors.white,
          //                     fontSize: 22,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //             Icon(
          //               isExpanded2
          //                   ? Icons.keyboard_arrow_down
          //                   : Icons.keyboard_arrow_up,
          //               color: Colors.white,
          //               size: 27,
          //             ),
          //           ],
          //         ),
          //         isExpanded2 ? const SizedBox() : const SizedBox(height: 20),
          //         AnimatedCrossFade(
          //           firstChild: const Text(
          //             '',
          //             style: TextStyle(
          //               fontSize: 0,
          //             ),
          //           ),
          //           secondChild: Text(
          //             Sentence,
          //             style: const TextStyle(
          //               color: Colors.white,
          //               fontSize: 15.7,
          //             ),
          //           ),
          //           crossFadeState: isExpanded2
          //               ? CrossFadeState.showFirst
          //               : CrossFadeState.showSecond,
          //           duration: const Duration(milliseconds: 1200),
          //           reverseDuration: Duration.zero,
          //           sizeCurve: Curves.fastLinearToSlowEaseIn,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
