
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:fluttertoast/fluttertoast.dart';


import 'package:cloud_firestore/cloud_firestore.dart';

import 'configMaps.dart';
import 'loginScreen.dart';
import 'package:firebase_database/firebase_database.dart';


class RegistrationScreen extends StatelessWidget {

  CollectionReference users = Firestore.instance.collection('users');
  static const String idScreen = "Register";
  final _firestore = Firestore.instance;
  DatabaseReference driversRef= FirebaseDatabase.instance.reference().child('Users');

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController nameTextEditingControler = TextEditingController();
  TextEditingController emailTextEditingControler = TextEditingController();
  TextEditingController phoneTextEditingControler = TextEditingController();
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
                width: 390.0,
                height: 250.0,
                alignment: Alignment.center,

              ),
              SizedBox(height: 1.0,),
              Text(
                "Register as a User",
                style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold"),
                textAlign: TextAlign.center,

              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: nameTextEditingControler,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Name",
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
                      controller: phoneTextEditingControler,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Phone",
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


                        onPressed: () async{
                          if (nameTextEditingControler.text.length < 4) {
                            displayToast(
                                "Name must be atleast 3 characters", context);
                          } else
                          if (!emailTextEditingControler.text.contains("@")) {
                            displayToast("Invalid Email", context);
                          }  else if (passwordTextEditingControler.text.length <
                              7) {
                            displayToast(
                                "Password must contains atleast 5 char",
                                context);
                          } else {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context){


                                }
                            );
                           var firebaseUser= (await _firebaseAuth
                           .createUserWithEmailAndPassword(email: emailTextEditingControler.text, password: phoneTextEditingControler.text)
                           ).user;

                            await users
                                .add({
                              'email': emailTextEditingControler.text.trim(), // John Doe
                              'name': nameTextEditingControler.text.trim(), // Stokes and Sons
                              'phone': phoneTextEditingControler.text.trim() // 42
                            })
                                .then((value) => print("User Added"))
                                .catchError((error) =>
                                print("Failed to add user: $error"));
                      if(firebaseUser!=null) {
                        Map userDataMap = {
                          "name": nameTextEditingControler.text,
                          "email": emailTextEditingControler.text,
                          "phone": phoneTextEditingControler.text,


                        };
                        driversRef.child(firebaseUser.uid).set(userDataMap);
                        print("my user");
                        print(driversRef);
                        final FirebaseUser user = await _firebaseAuth.currentUser();




                        displayToast("Congratulations your new account has been created", context);

                        registerNewUser(context);
                      }
                          }
                        },
                        child: Container(
                          height: 50.0,
                          child: Center(
                            child: Text(
                              "Register",
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
              TextButton(onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginScreen.idScreen, (route) => false);
              },
                child: Text(
                    "Already have an Account? Login here"
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  void registerNewUser(BuildContext context) async
  {

    try {

      final newUser = await _firebaseAuth.createUserWithEmailAndPassword(
          email: emailTextEditingControler.text,
          password: passwordTextEditingControler.text)
          .then((signedInUser) {
        _firestore.collection("users")
            .add({
          'email': emailTextEditingControler,
          'password': passwordTextEditingControler,

        }).then((value) {




          // Call the user's CollectionReference to add a new user


        });


      });



      }



    catch (e) {
      print(e);
    }
    //Navigator.pushNamedAndRemoveUntil(context, CarInfoScreen.idScreen, (route) => false);
    displayToast("User Registered", context);
  }
}
displayToast(String message,BuildContext context ){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}
