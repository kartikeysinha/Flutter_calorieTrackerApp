import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    final curScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Container(
        child: transactions.isEmpty
            ? LayoutBuilder(builder: (ctx, constraints) {
                return Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'No food items added yet!',
                        style: TextStyle(
                          fontSize: 20 * curScaleFactor,
                          color: Colors.black,
                          fontWeight: FontWeight.normal
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: constraints.maxHeight * 0.6,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                );
              })
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                    elevation: 5,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: '${transactions[index].cal} \n',
                                  style: TextStyle(
                                    fontSize: 20 * curScaleFactor,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'cal',
                                      style: TextStyle(
                                        fontSize: 10 * curScaleFactor,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        '${transactions[index].title}',
                        style: TextStyle(
                          fontSize: 19 * curScaleFactor,
                        ),
                      ),
                      subtitle: Text(
                        DateFormat.yMd().format(transactions[index].date),
                        style: TextStyle(
                          fontSize: 15 * curScaleFactor,
                        ),
                      ),
                      trailing: MediaQuery.of(context).size.width > 450
                          ? FlatButton.icon(
                            textColor: Colors.red,
                              onPressed: () => deleteTx(transactions[index].id),
                              icon: Icon(Icons.delete),
                              label: Text('delete'))
                          : IconButton(
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: () => deleteTx(transactions[index].id),
                            ),
                    ),
                  );
                },
                itemCount: transactions.length,
              ));
  }
}
