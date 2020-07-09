import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final calorieController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredCal = double.parse(calorieController.text);

    if (enteredTitle.isEmpty || enteredCal <= 0){
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredCal,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
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
            RaisedButton(
              onPressed: null,
              child: Text('Date'),
              color: Theme.of(context).accentColor,
              textColor: Theme.of(context).textTheme.button.color,
            ),
            FlatButton(
              onPressed: () {
                widget.addTx(titleController.text, double.parse(calorieController.text),);
              },
              child: Text('Add Transaction'),
              textColor: Theme.of(context).textTheme.button.color,
            )
          ],
        ),
      ),
    );
  }
}
