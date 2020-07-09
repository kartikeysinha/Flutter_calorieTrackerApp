import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double calorieConsumed;
  final double caloriePctOfTotal;

  ChartBar(this.label, this.calorieConsumed, this.caloriePctOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FittedBox(
          child: Text('${calorieConsumed.toStringAsFixed(0)}'),
        ),
        SizedBox(height: 4),
        Container(
          height: 60,
          width: 10,
          child: Stack(children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1)),
              color: Color.fromRGBO(200, 200, 200, 0.9),
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
        SizedBox(height: 4),
        Text(label)
      ],
    );
  }
}
