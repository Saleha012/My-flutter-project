
import 'package:flutter/material.dart';
import 'package:fyp/Deletedevice.dart';
import 'package:fyp/FAQPage.dart';
import 'package:fyp/Profilepage.dart';

import 'package:fyp/myRegister.dart';
import 'package:fyp/pageTwo.dart';

import'package:fyp/login.dart';
import 'package:fyp/pagethree.dart';
import 'package:fyp/profile.dart';
import 'package:fyp/record.dart';
import 'package:fyp/reset%20password.dart';
import 'package:fyp/splashscreen.dart';
import 'package:fyp/myhomepage.dart';
import 'package:fyp/pageone1.dart';

import 'FeedbackPage.dart';
import 'Insertdevice.dart';
import 'ListDevices.dart';



void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,


    routes: {
      '/': (context) => Splash(),
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(),
      'home': (context) => myhomepage(),
      //'/home': (context) => myhomepage(userId: ModalRoute.of(context)!.settings.arguments as String),
      //'pageone1': (context) => pageone1(userId: ModalRoute.of(context)!.settings.arguments as String),
      'pageone1': (context) => pageone1(),
'reset password':(context) => ForgotPasswordScreen(),
      'pagetwo': (context) => pageTwo(),
      'pagethree': (context) => Pagethree(date: 'dd/mm/yyy', reading: 0.0),
      'profile': (context) => Profilepage(),
      //'/profile': (context) => Profilepage(userId: ModalRoute.of(context)!.settings.arguments as String),
      'Deletedevice': (context) => Deletedevice(),
       'Insertdevice':(context)=> Insertdevice(),

      'FeedbackPage':(context) => FeedbackPage(),
      'DeviceList':(context) => DeviceList(),
      'FAQPage':(context) => FAQPage(),
      'record':(context) => record(),
    },
  )
  );
}








