import 'package:flutter/material.dart';

class SlideShowItem extends StatelessWidget {
  final String bale_5;
  final String image;
  final String value;

  SlideShowItem({this.bale_5, this.value, this.image});
  String Sentence = 'Here';
  bool isExpanded = true;
  bool isExpanded2 = true;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {},
      child: AnimatedContainer(
        margin: const EdgeInsets.symmetric(
          horizontal: 100,
          vertical: 20,
        ),
        padding: const EdgeInsets.all(20),
        height: 120,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'images/$image',
                  width: 80,
                  height: 80,
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
            // isExpanded ? const SizedBox() : const SizedBox(height: 20),
            // AnimatedCrossFade(
            //   firstChild: const Text(
            //     '',
            //     style: TextStyle(
            //       fontSize: 0,
            //     ),
            //   ),
            //   secondChild: Text(
            //     Sentence,
            //     style: const TextStyle(
            //       color: Colors.white,
            //       fontSize: 15.7,
            //     ),
            //   ),
            //   crossFadeState: isExpanded
            //       ? CrossFadeState.showFirst
            //       : CrossFadeState.showSecond,
            //   duration: const Duration(milliseconds: 1200),
            //   reverseDuration: Duration.zero,
            //   sizeCurve: Curves.fastLinearToSlowEaseIn,
            // ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: 400,
              height: 2,
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Produced',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                ),
                Text(
                  value.toString(),
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w900),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Sold',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                ),
                Text(
                  '4',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Tot Income',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                ),
                Text(
                  '3600',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
