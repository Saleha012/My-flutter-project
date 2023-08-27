import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fyp/login.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((value) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MyLogin())));
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children:[
            Stack(
                alignment: Alignment.center,
                children:[
                  CircleAvatar(
                    backgroundColor: Colors.teal[400],
                    radius :60,
                    child:Image(image: AssetImage('assets/logo.png')),
                  )

                ]
            ),
            SizedBox(height:20,),
            Text('Smart Connect',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight:FontWeight.bold,
                  fontSize: 30),)
          ],
        ),
      ),
    );
  }

}
