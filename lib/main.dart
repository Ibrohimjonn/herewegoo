import 'package:flutter/material.dart';
import 'package:herewegoo/pages/home_page.dart';
import 'package:herewegoo/pages/signin_page.dart';
import 'package:herewegoo/pages/signup_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignIn(),
      routes: {
        Home.id: (context) => Home(),
        SignIn.id: (context) => SignIn(),
        SignUp.id: (context) => SignUp(),
      },
    );
  }
}

