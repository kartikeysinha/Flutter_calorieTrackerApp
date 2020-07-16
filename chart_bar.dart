import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double calorieConsumed;
  final double caloriePctOfTotal;

  ChartBar(this.label, this.calorieConsumed, this.caloriePctOfTotal);

  @override
  Widget build(BuildContext context) {
    final curScaleFactor = MediaQuery.of(context).textScaleFactor;
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
      children: <Widget>[
        Container(
          height: constraints.maxHeight * 0.1,
          child: FittedBox(
            child: Text(
              '${calorieConsumed.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 10 * curScaleFactor,
              ),
            ),
          ),
        ),
        SizedBox(height: constraints.maxHeight * 0.075),
        Container(
          height: constraints.maxHeight * 0.65,
          width: 10,
          child: Stack(children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                color: Color.fromRGBO(200, 200, 200, 0.9),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            FractionallySizedBox(
              heightFactor: caloriePctOfTotal,
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(10))),
            )
          ]),
        ),
        SizedBox(height: constraints.maxHeight * 0.075),
        Container(
          height: constraints.maxHeight * 0.1,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15 * curScaleFactor,
            ),
          ),
        )
      ],
    );
    },);
  }
}