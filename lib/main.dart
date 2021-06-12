import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:herewegoo/pages/detail_page.dart';
import 'package:herewegoo/pages/home_page.dart';
import 'package:herewegoo/pages/signin_page.dart';
import 'package:herewegoo/pages/signup_page.dart';
import 'pages/home_page.dart';
import 'pages/signin_page.dart';
import 'services/prefs_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  Widget _startPage() {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if(snapshot.hasData) {
          Prefs.saveUserId(snapshot.data.uid);
          return Home();
        }else {
          Prefs.removeUserId();
          return SignIn();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _startPage(),
      routes: {
        Home.id: (context) => Home(),
        SignIn.id: (context) => SignIn(),
        SignUp.id: (context) => SignUp(),
        Detail.id: (context) => Detail(),
      },
    );
  }
}

