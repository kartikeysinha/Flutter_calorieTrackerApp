import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 440,
        child: transactions.isEmpty
            ? Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      'No food items added yet!',
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 200,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              )
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
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'cal',
                                      style: TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        '${transactions[index].title}',
                      ),
                      subtitle: Text(
                        DateFormat.yMd().format(transactions[index].date),
                      ),
                      trailing: IconButton(
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
