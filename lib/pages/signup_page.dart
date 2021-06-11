import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:herewegoo/pages/signin_page.dart';
import 'package:herewegoo/services/auth_service.dart';
import 'package:herewegoo/services/prefs_service.dart';
import 'package:herewegoo/services/utils_service.dart';

import 'home_page.dart';

class SignUp extends StatefulWidget {

  static final String id = 'signup';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var isLoading = false;
  var fullnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  _doSignUp() {
    String name = fullnameController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    if(name.isEmpty || email.isEmpty || password.isEmpty) return;

    setState(() {
      isLoading = true;
    });

    AuthService.signUpUser(context, name, email, password).then((firebaseUser) => {
      _getFirebaseUser(firebaseUser),
    });
  }

  _getFirebaseUser(FirebaseUser firebaseUser)  async{

    setState(() {
      isLoading = false;
    });

    if(firebaseUser != null){
      await Prefs.saveUserId(firebaseUser.uid);
      Navigator.pushReplacementNamed(context, Home.id);
    }else{
      Utils.fireToast('check your informations');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: fullnameController,
                  decoration: InputDecoration(
                    hintText: 'FullName',
                  ),
                ),
                SizedBox(height: 12,),

                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                SizedBox(height: 12,),

                TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 45,
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: _doSignUp,
                    color: Colors.red,
                    child: Text('Sign Up',style: TextStyle(color: Colors.white),),
                  ),
                ),
                SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Already have an account',style: TextStyle(color: Colors.black),),
                    SizedBox(width: 16,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SignIn.id);
                      },
                      child: Text('SignIn',style: TextStyle(color: Colors.black),),
                    ),
                  ],
                ),
              ],
            ),
          ),
          isLoading ?
          Center(
            child: CircularProgressIndicator(),
          ): SizedBox.shrink(),
        ],
      ),
    );
  }
}
