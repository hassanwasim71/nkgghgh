import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'main.dart';
import 'myHomePage.dart';
import 'registrationScreen.dart';

import 'configMaps.dart';
class LoginScreen extends StatelessWidget {

  static const String idScreen="Login";
  final _firestore = Firestore.instance;

  final _auth = FirebaseAuth.instance;

  TextEditingController emailTextEditingControler = TextEditingController();

  TextEditingController passwordTextEditingControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 15.0,),
              Image(
                image: AssetImage("images/logo.png"),
                width: 300.0,
                height: 250.0,
                alignment: Alignment.center,

              ),
              SizedBox(height: 1.0,),
              Text(
                "Login as a User",
                style: TextStyle(fontSize: 24.0,fontFamily: "Brand Bold"),
                textAlign: TextAlign.center,

              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: emailTextEditingControler,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,

                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    SizedBox(height: 1.0,),
                    TextField(
                      controller: passwordTextEditingControler,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,

                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    SizedBox(height: 10.0,),
                    ElevatedButton(


                        onPressed: () async {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context){


                              }
                          );

                          try {
                            await FirebaseAuth.instance.signInWithEmailAndPassword(
                                email: emailTextEditingControler.text,
                                password: passwordTextEditingControler.text
                            ).then((value) =>  Navigator.pushNamed(context, MyHomePage.idScreen));

                          }  catch (e) {
                            if (e.code == 'user-not-found') {
                              Navigator.pop(context);
                              print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              Navigator.pop(context);
                              print('Wrong password provided for that user.');
                            }
                          }
                        },
                        child: Container(
                          height: 50.0,
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: "Brand Bold"
                              ),
                            ),
                          ),


                        )

                    ),



                  ],
                ),
              ),
              TextButton(  onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, RegistrationScreen.idScreen, (route) => false);
              },
                child: Text(
                    "Do not have an Account? Register here"
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

