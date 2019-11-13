import 'package:flutter/material.dart';
import 'screens/stocks_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        unselectedWidgetColor: Colors.grey[400],
      ),
      home: StocksScreen(),
    );
  }
}
