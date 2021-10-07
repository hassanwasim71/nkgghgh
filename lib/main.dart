import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutterthreadexample/commons/const.dart';
import 'package:flutterthreadexample/registrationScreen.dart';
import 'package:flutterthreadexample/userProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'commons/utils.dart';
import 'configMaps.dart';
import 'controllers/FBCloudMessaging.dart';
import 'loginScreen.dart';
import 'myHomePage.dart';
import 'threadMain.dart';
import 'package:firebase_core/firebase_core.dart';
void main()async
{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(



        primarySwatch: Colors.blue,
      ),
      initialRoute: FirebaseAuth.instance.currentUser==null? LoginScreen.idScreen: MyHomePage.idScreen,
      debugShowCheckedModeBanner:false ,
      routes: {
        RegistrationScreen.idScreen:(context)=> RegistrationScreen(),
        LoginScreen.idScreen:(context)=> LoginScreen(),
        MyHomePage.idScreen:(context)=> MyHomePage(),

        '/login':(_)=>LoginScreen(),
        '/register':(_)=>RegistrationScreen(),

      },


    );
  }
}
