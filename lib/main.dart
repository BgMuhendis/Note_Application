import 'package:flutter/material.dart';
import 'package:kalici_depolama/sqflite.dart';
import 'package:kalici_depolama/units/database_helper.dart';

void main() =>runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    home: SqfliteIslemleri(),
    );
  }

}


