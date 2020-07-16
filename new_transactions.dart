import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final calorieController = TextEditingController();
  DateTime _selectedDate;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('...');
  }

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredCal = double.parse(calorieController.text);

    if (enteredTitle.isEmpty || enteredCal < 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(enteredTitle, enteredCal, _selectedDate);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 10),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Food'),
                controller: titleController,
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Calories'),
                controller: calorieController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen'
                            : DateFormat.yMd().format(_selectedDate),
                      ),
                    ),
                    Platform.isIOS
                        ? CupertinoButton(
                            child: Text(
                              'Choose Date',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: _presentDatePicker,
                          )
                        : FlatButton(
                            textColor: Colors.black,
                            child: Text(
                              'Choose Date',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: _presentDatePicker,
                          ),
                  ],
                ),
              ),
              Platform.isIOS
                  ? CupertinoButton(
                      child: Text('Add Transaction'),
                      onPressed: submitData,
                    )
                  : RaisedButton(
                      onPressed: submitData,
                      child: Text('Add Transaction'),
                      textColor: Theme.of(context).textTheme.button.color,
                      color: Theme.of(context).primaryColor,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
