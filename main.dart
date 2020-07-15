import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transactions.dart';
import './widgets/chart.dart';

void main() {
  runApp(CalorieApp());
}

class CalorieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calorie Tracker",
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.redAccent,
          textTheme: TextTheme(
            button: TextStyle(color: Colors.yellow),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _usertransactions = [
    /*Transaction(
      id: 't1',
      title: 'Apple',
      cal: 100,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Banana',
      cal: 50,
      date: DateTime.now(),
    ), */
  ];

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bctx) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  List<Transaction> get _recentTransactions {
    return _usertransactions.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txCal, DateTime chosenDate) {
    final newTx = Transaction(
        title: txTitle,
        cal: txCal,
        date: chosenDate,
        id: DateTime.now().toString());

    setState(() {
      _usertransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _usertransactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calorie Counter'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
              ),
              onPressed: () => _startAddNewTransaction(context),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(child: Chart(_recentTransactions)),
                Container(
                  height: 440,
                  child: Column(
                    children: <Widget>[
                      TransactionList(_usertransactions, _deleteTransaction),
                    ],
                  ),
                ),
                Center(
                  child: FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
                )
              ]),
        ));
  }
}
