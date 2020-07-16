import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
  final List<Transaction> _usertransactions = [];
  bool _showChart = false;

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bctx) {
          return GestureDetector(
            onTap: () {return NewTransaction(_addNewTransaction);},
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
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Calorie Counter'),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
              GestureDetector(
                child: Icon(CupertinoIcons.add),
                onTap: () => _startAddNewTransaction(context),
              )
            ]),
          )
        : AppBar(
            title: Text('Calorie Counter'),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.add,
                ),
                onPressed: () => _startAddNewTransaction(context),
              ),
            ],
          );
    final txListWidget = Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 0.6 *
                (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top),
            child: TransactionList(_usertransactions, _deleteTransaction),
          ),
        ],
      ),
    );
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isLandscape)
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Show List',
                    style: TextStyle(
                        fontSize: 15 * MediaQuery.of(context).textScaleFactor),
                  ),
                  Switch.adaptive(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  ),
                  Text(
                    'Show Chart',
                    style: TextStyle(
                        fontSize: 15 * MediaQuery.of(context).textScaleFactor),
                  ),
                ]),
              if (isLandscape)
                _showChart
                    ? Container(
                        child: Card(
                          child: Container(
                            height: 0.7 *
                                (MediaQuery.of(context).size.height -
                                    appBar.preferredSize.height -
                                    MediaQuery.of(context).padding.top),
                            child: Chart(_recentTransactions),
                          ),
                        ),
                      )
                    : Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 0.8 *
                                  (MediaQuery.of(context).size.height -
                                      appBar.preferredSize.height -
                                      MediaQuery.of(context).padding.top),
                              child: TransactionList(
                                  _usertransactions, _deleteTransaction),
                            ),
                          ],
                        ),
                      ),
              if (!isLandscape)
                Container(
                  child: Card(
                    child: Container(
                      height: 0.3 *
                          (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top),
                      child: Chart(_recentTransactions),
                    ),
                  ),
                ),
              if (!isLandscape) txListWidget,
            ]),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isLandscape)
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Show List',
                              style: TextStyle(
                                  fontSize: 15 *
                                      MediaQuery.of(context).textScaleFactor),
                            ),
                            Switch.adaptive(
                              value: _showChart,
                              onChanged: (val) {
                                setState(() {
                                  _showChart = val;
                                });
                              },
                            ),
                            Text(
                              'Show Chart',
                              style: TextStyle(
                                  fontSize: 15 *
                                      MediaQuery.of(context).textScaleFactor),
                            ),
                          ]),
                    if (isLandscape)
                      _showChart
                          ? Container(
                              child: Card(
                                child: Container(
                                  height: 0.6 *
                                      (MediaQuery.of(context).size.height -
                                          appBar.preferredSize.height -
                                          MediaQuery.of(context).padding.top),
                                  child: Chart(_recentTransactions),
                                ),
                              ),
                            )
                          : Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: 0.6 *
                                        (MediaQuery.of(context).size.height -
                                            appBar.preferredSize.height -
                                            MediaQuery.of(context).padding.top),
                                    child: TransactionList(
                                        _usertransactions, _deleteTransaction),
                                  ),
                                ],
                              ),
                            ),
                    if (!isLandscape)
                      Container(
                        child: Card(
                          child: Container(
                            height: 0.3 *
                                (MediaQuery.of(context).size.height -
                                    appBar.preferredSize.height -
                                    MediaQuery.of(context).padding.top),
                            child: Chart(_recentTransactions),
                          ),
                        ),
                      ),
                    if (!isLandscape) txListWidget,
                    Center(
                      child: Platform.isIOS
                          ? Container()
                          : FloatingActionButton(
                              child: Icon(Icons.add),
                              onPressed: () => _startAddNewTransaction(context),
                            ),
                    )
                  ]),
            ));
  }
}
