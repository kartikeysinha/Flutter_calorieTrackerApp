import 'package:calorie_tracker/models/transaction.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './chart_bar.dart';


class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for(var i = 0; i < recentTransactions.length; i++){
        if(recentTransactions[i].date.day == weekDay.day &&
           recentTransactions[i].date.month == weekDay.month &&
           recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].cal;
        }
      }

      return {'day' : DateFormat.E().format(weekDay).substring(0,1), 'cal': totalSum};
    }).reversed.toList();
  }

  double get maxCalorie {
    return groupedTransactionValues.fold(0.0, (maximum, item) {
      if (maximum >= item['cal']){
        return maximum;
      } else {
        return item['cal'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                  child: ChartBar(
                  data['day'],
                  data['cal'], 
                  maxCalorie == 0 ? 0.0 : (data['cal'] as double) / maxCalorie,
                ),
              );
            }).toList(),
          ),
        )
      ),
    );
  }
}