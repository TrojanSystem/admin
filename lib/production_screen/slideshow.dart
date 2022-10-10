import 'package:ada_bread/production_screen/slideShowItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class Slide extends StatelessWidget {
  final String bale_5;
  final String bale_10;
  final String slice;
  final String bombolino;
  final double totProducedIncome;
  final String soldBale_5;
  final String soldBale_10;
  final String soldSlice;
  final String soldBombolino;
  final String soldIncomeBale_5;
  final String soldIncomeBale_10;
  final String soldIncomeSlice;
  final String soldIncomeBombolino;
  final int totSoldIncome;
  const Slide(
      {this.bale_10,
      this.soldIncomeBale_5,
      this.soldIncomeBale_10,
      this.soldIncomeSlice,
      this.soldIncomeBombolino,
      this.totSoldIncome,
      this.totProducedIncome,
      this.soldBale_5,
      this.soldBale_10,
      this.soldBombolino,
      this.soldSlice,
      this.bale_5,
      this.bombolino,
      this.slice});

  @override
  Widget build(BuildContext context) {
    int sum = (int.parse(bale_5) +
        int.parse(bale_10) +
        int.parse(slice) +
        int.parse(bombolino));
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        color: Colors.black12,
        child: FittedBox(
          alignment: Alignment.center,
          clipBehavior: Clip.antiAlias,
          child: ImageSlideshow(
            /// Width of the [ImageSlideshow].
            width: 500,

            /// Height of the [ImageSlideshow].
            height: 300,

            /// The page to show when first creating the [ImageSlideshow].
            initialPage: 0,

            /// The color to paint the indicator.
            indicatorColor: Colors.blue,
            indicatorRadius: 8,

            /// The color to paint behind th indicator.
            indicatorBackgroundColor: Colors.grey,

            /// The widgets to display in the [ImageSlideshow].
            /// Add the sample image file into the images folder
            children: [
              SlideShowItem(
                bale_5: 'አጠቃላይ',
                image: 'logo_2.jpg',
                value: sum.toString(),
                totIncome: totProducedIncome,
                totSold: totSoldIncome.toString(),
              ),
              SlideShowItem(
                bale_5: 'ባለ 5 ብር',
                image: 'bale_5.png',
                value: bale_5 == null ? '0' : bale_5.toString(),
                totIncome: double.parse(soldIncomeBale_5),
                totSold: soldBale_5.toString(),
              ),
              SlideShowItem(
                bale_5: 'ባለ 10 ብር',
                image: 'bale_10.png',
                value: bale_10 == null ? '0' : bale_10.toString(),
                totIncome: double.parse(soldIncomeBale_10),
                totSold: soldBale_10.toString(),
              ),
              SlideShowItem(
                bale_5: 'ስላይስ',
                image: 'slice.png',
                value: slice == null ? '0' : slice.toString(),
                totIncome: double.parse(soldIncomeSlice),
                totSold: soldSlice.toString(),
              ),
              SlideShowItem(
                bale_5: 'ቦምቦሊኖ',
                image: 'donut.png',
                value: bombolino == null ? '0' : bombolino.toString(),
                totIncome: double.parse(soldIncomeBombolino),
                totSold: soldBombolino.toString(),
              ),
            ],

            /// Called whenever the page in the center of the viewport changes.
            onPageChanged: (value) {},

            /// Auto scroll interval.
            /// Do not auto scroll with null or 0.
            autoPlayInterval: 5000,

            /// Loops back to first slide.
            isLoop: true,
          ),
        ),
      ),
    );
  }
}
