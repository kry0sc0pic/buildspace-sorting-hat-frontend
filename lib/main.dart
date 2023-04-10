import 'package:flutter/material.dart';
import 'package:sorter/landing.dart';
import 'package:sorter/question.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WelcomePage(),
  ));
}
