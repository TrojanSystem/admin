import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';

class SellerDetail extends StatefulWidget {
  const SellerDetail({Key key}) : super(key: key);

  @override
  State<SellerDetail> createState() => _SellerDetailState();
}

class _SellerDetailState extends State<SellerDetail> {
  bool isTapped = true;
  double totalSumation = 0.00;
  bool isNegative = false;
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    List<String> imageOfBread = [
      'images/bale_5.png',
      'images/bale_10.png',
      'images/slice.png',
      'images/donut.png'
    ];
    double _w = MediaQuery.of(context).size.width;
    int columnCount = 2;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedContainer(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          margin: const EdgeInsets.only(left: 8.0, right: 8, top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                const Color.fromRGBO(40, 53, 147, 1),
                const Color.fromRGBO(40, 53, 147, 1).withOpacity(0.9)
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 4,
                offset: const Offset(4, 8), // changes position of shadow
              ),
            ],
          ),
          duration: const Duration(seconds: 1),
          curve: Curves.fastLinearToSlowEaseIn,
          height: 350,
          width: 350,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat.E().format(
                      DateTime.now(),
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text('Tot Income: 2500',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      )),
                ],
              ),
              Expanded(
                flex: 3,
                child: AnimationLimiter(
                  child: GridView.count(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    padding: EdgeInsets.all(_w / 60),
                    crossAxisCount: columnCount,
                    children: List.generate(
                      4,
                      (int index) {
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          columnCount: columnCount,
                          child: ScaleAnimation(
                            duration: const Duration(milliseconds: 900),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: FadeInAnimation(
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: _w / 30,
                                    left: _w / 60,
                                    right: _w / 60),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 40,
                                      spreadRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      imageOfBread[index],
                                      width: 50,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text(
                                            'Given',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900),
                                          ),
                                          Text('300'),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text(
                                            'Sold',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900),
                                          ),
                                          Text('250'),
                                        ],
                                      ),
                                    )
                                  ],
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
            ],
          ),
        ),
      ),
    );
  }
}
