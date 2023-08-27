// TODO Implement this library.
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp/myForgetpassword.dart';

import 'package:fyp/myhomepage.dart';
import 'package:fyp/reset%20password.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;



class MyLogin extends StatefulWidget {
    const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}
  var email="";
  var password = "";

   class _MyLoginState extends State<MyLogin> {
     @override

     Widget build(BuildContext context) {
       return Container(
         decoration: BoxDecoration(
           image: DecorationImage(
               image: AssetImage('assets/screen.jpeg'), fit: BoxFit.cover),
         ),
         child: Scaffold(
           backgroundColor: Colors.transparent,
           body: Stack(
             children: [
               Container(),
               Container(
                 padding: EdgeInsets.only(left: 35, top: 150),
                 child: Text(
                   'Welcome\nBack',
                   style: TextStyle(color: Colors.teal, fontSize: 56),
                 ),
               ),
               SingleChildScrollView(
                 child: Container(
                   padding: EdgeInsets.only(
                       top: MediaQuery
                           .of(context)
                           .size
                           .height * 0.5),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Container(
                         margin: EdgeInsets.only(left: 35, right: 35),
                         child: Column(
                           children: [
                             TextField(
                               style: TextStyle(color: Colors.black),
                               decoration: InputDecoration(
                                   fillColor: Colors.grey.shade100,
                                   filled: true,
                                   hintText: "Email",
                                   border: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(10),
                                   )),
                               onChanged: (value) =>{
                                 email = value
                               },
                             ),
                             SizedBox(
                               height: 30,
                             ),
                             TextField(
                               style: TextStyle(color: Colors.black),
                               obscureText: true,
                               decoration: InputDecoration(
                                   fillColor: Colors.grey.shade100,
                                   filled: true,
                                   hintText: "Password",
                                   border: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(10),
                                   )),
                               onChanged: (value) =>{
                                 password = value
                               },
                             ),
                             SizedBox(
                               height: 40,
                             ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment
                                   .spaceBetween,
                               children: [
                                 TextButton(
                                   onPressed: () {
                                     main();
                                    // Navigator.pushNamed(context, 'home');
                                   },

                                   child: Text(
                                     'Sign in',
                                     textAlign: TextAlign.right,
                                     style: TextStyle(
                                         decoration: TextDecoration.underline,
                                         color: Colors.teal,
                                         fontSize: 27,
                                         fontWeight: FontWeight.w700),
                                   ),
                                   style: ButtonStyle(),
                                 ),


                                 //    Text(
                                 // 'Sign in',
                                 // style: TextStyle(color: Colors.teal,
                                 //     fontSize: 27, fontWeight: FontWeight.w700),
                                 //    ),
                                 CircleAvatar(
                                   radius: 30,
                                   backgroundColor: Colors.teal,
                                   child: IconButton(
                                       color: Colors.white,
                                       onPressed: () {},
                                       icon: Icon(
                                         Icons.arrow_forward,
                                       )),
                                 )
                               ],
                             ),
                             SizedBox(
                               height: 40,
                             ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment
                                   .spaceBetween,
                               children: [
                                 TextButton(
                                   onPressed: () {
                                     Navigator.pushNamed(context, 'register');
                                   },
                                   child: Text(
                                     'Sign Up',
                                     textAlign: TextAlign.left,
                                     style: TextStyle(
                                         decoration: TextDecoration.underline,
                                         color: Color(0xff4c505b),
                                         fontSize: 18),
                                   ),
                                   style: ButtonStyle(),
                                 ),
                                 TextButton(
                                     onPressed: () {

                                         Navigator.push(
                                           context,
                                           MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                                         );

                                     },


                                     child: Text('Forgot Password',
                                       style: TextStyle(
                                         decoration: TextDecoration.underline,
                                         color: Color(0xff4c505b),
                                         fontSize: 18,
                                       ),
                                     )),
                               ],
                             )
                           ],
                         ),
                       )
                     ],
                   ),
                 ),
               ),
             ],
           ),
         ),
       );
     }
      main() async{
       var headers = {
         'Content-Type': 'application/json',
         'X-Amz-Content-Sha256': 'beaead3198f7da1e70d03ab969765e0821b24fc913697e929e726aeaebf0eba3',
         'X-Amz-Date': '20230519T132956Z',
         'Authorization': 'AWS4-HMAC-SHA256 Credential=AKIARCZFXHXOVPS3PLPQ/20230519/us-west-2/execute-api/aws4_request, SignedHeaders=content-length;content-type;host;x-amz-content-sha256;x-amz-date, Signature=6b2a2071827900719faa8c00ef9a06d914a49230639694f2aaa0e6c371fcdd62'
       };
       var request = http.Request('POST',
           Uri.parse('https://b8y8kgej6c.execute-api.us-west-2.amazonaws.com/dev/user/login'));
       request.body = json.encode({
         "email": '$email',
         "password": '$password'
       });
       request.headers.addAll(headers);

       http.StreamedResponse response = await request.send();
      //print( await response.stream.bytesToString());
       if (response.statusCode == 200) {
         Navigator.pushNamed(context, 'home');
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
             content: Text(
                 ' Login Successfully')));

       }

       else {
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
             content: Text(
                 ' Username is not found! Please try again later')));
         print(response.reasonPhrase);
       }

     }
   }
