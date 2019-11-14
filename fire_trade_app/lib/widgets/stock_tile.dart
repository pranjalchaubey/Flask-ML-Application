import 'package:flutter/material.dart';

class StockTile extends StatelessWidget {
  final bool isChecked;
  final String stockTitle;
  final Function checkboxCallback;

  StockTile({this.isChecked, this.stockTitle, this.checkboxCallback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        stockTitle,
        style: TextStyle(
          color: Colors.grey[400],
          fontSize: 18.0,
          fontWeight: FontWeight.w300,
          decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
        activeColor: Colors.transparent,
        checkColor: Color(0xFF81C525),
        value: isChecked,
        onChanged: checkboxCallback,
      ),
    );
  }
}
