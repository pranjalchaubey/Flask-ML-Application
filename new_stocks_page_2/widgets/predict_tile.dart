import 'package:flutter/material.dart';

class PredictTile extends StatelessWidget {
  final String stockTitle;
  final String prediction;

  PredictTile({this.stockTitle, this.prediction});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        stockTitle,
        style: TextStyle(
          color: Colors.grey[400],
          fontSize: 18.0,
          fontWeight: FontWeight.w300,
          //decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Text(
        prediction,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.grey[400],
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          //decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
    );
  }
}
