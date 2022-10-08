import 'package:ada_bread/dataHub/data/production_data_hub.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class ProgressContainerItem extends StatefulWidget {
  final String soldItem;
  final String dailyProducedItem;

  const ProgressContainerItem({
    this.soldItem,
    this.dailyProducedItem,
  });

  @override
  State<ProgressContainerItem> createState() => _ProgressContainerItemState();
}

class _ProgressContainerItemState extends State<ProgressContainerItem> {
  @override
  Widget build(BuildContext context) {
    Provider.of<ProductionModelData>(context).totalTask =
        int.parse(widget.dailyProducedItem);
    Provider.of<ProductionModelData>(context).taskDone =
        int.parse(widget.soldItem);
    final percent = Provider.of<ProductionModelData>(context).percent();
    final showPercent =
        Provider.of<ProductionModelData>(context).doublePercent();

    return Container(
      margin: const EdgeInsets.only(left: 10, right: 5, bottom: 5),
      padding: const EdgeInsets.only(left: 20, right: 20),
      height: 90,
      child: Row(
        children: [
          CircularPercentIndicator(
            circularStrokeCap: CircularStrokeCap.round,
            radius: 60.0,
            lineWidth: 9.0,
            percent: double.parse(percent),
            center: Text(
              '$showPercent %',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            progressColor: showPercent < 25
                ? Colors.blue[900]
                : showPercent > 25 && showPercent < 50
                    ? Colors.blue
                    : showPercent > 50 && showPercent < 75
                        ? Colors.blueAccent
                        : showPercent > 75
                            ? Colors.green
                            : Colors.red,
          ),
          const SizedBox(
            width: 25,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Daily Progress',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.soldItem.toString(),
                      style: TextStyle(
                        color: Colors.blue[900],
                      ),
                    ),
                    TextSpan(
                      text: ' / ',
                      style: TextStyle(
                        color: Colors.blue[900],
                      ),
                    ),
                    TextSpan(
                      text: widget.dailyProducedItem.toString(),
                      style: TextStyle(
                        color: Colors.blue[900],
                      ),
                    ),
                    const TextSpan(
                      text: ' Piece done',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    );
  }
}
