import 'package:flutter/material.dart';
import 'package:thetask/pages/home.dart';
import 'package:thetask/pages/loading.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/home',
  routes: {
    '/home': (context) => const Home(),
    '/': (context) => const Loading()
  },
));