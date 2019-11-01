import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.white70,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Select your preferred stocks...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Color(0xFFB7D9A3), width: 2.0),
  ),
);
