import 'package:flutter/material.dart';
import 'package:fire_trade_app/screens/welcome_screen.dart';
import 'package:fire_trade_app/screens/login_screen.dart';
import 'package:fire_trade_app/screens/registration_screen.dart';
import 'package:fire_trade_app/screens/subscribe_screen.dart';
import 'package:fire_trade_app/screens/stocks_screen.dart';

void main() => runApp(FireTrade());

class FireTrade extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        SubscribeScreen.id: (context) => SubscribeScreen(),
        StockScreen.id: (context) => StockScreen(),
      },
    );
  }
}