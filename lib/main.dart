import 'package:flutter/material.dart';
import 'package:patterns_provider/pages/add_page.dart';
import 'package:patterns_provider/pages/hom_page.dart';
import 'package:patterns_provider/pages/updata_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:HomePage(),
      routes:{
        HomePage.id:(context)=>const HomePage(),
        UpdatePage.id:(context)=> UpdatePage(),
        AddPage.id:(context)=>AddPage(),
      },
    );
  }
}

