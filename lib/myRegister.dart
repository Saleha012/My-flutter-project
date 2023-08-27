import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  var count = 10000;
  var name = '';
  var email ='';
  var password ='';
  var confirmpasswod = '';
  var uuid = Uuid();

  @override

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/screen.jpeg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(),
            Container(
              padding: EdgeInsets.only(left: 35, top: 40),
              child: Text(
                'Create Account',
                style: TextStyle(color: Colors.teal, fontSize: 50),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextField(
                            style: TextStyle(color: Colors.black45),
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black87,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Name",
                                hintStyle: TextStyle(color: Colors.black45),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            onChanged: (value) =>{
                              name = value
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            style: TextStyle(color: Colors.black87),
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black87,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Email",
                                hintStyle: TextStyle(color: Colors.black45),
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
                            style: TextStyle(color: Colors.black45),
                            obscureText: true,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black87,
                                  ),

                                ),

                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.black45),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            onChanged: (value) =>{
                              password = value
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            style: TextStyle(color: Colors.black45),
                            obscureText: true,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black87,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Confrim Password",
                                hintStyle: TextStyle(color: Colors.black45),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            onChanged: (value) =>{
                              confirmpasswod = value
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  signup();
                                  // Navigator.pushNamed(context, 'login');
                                },

                                child: Text(
                                  'Sign up',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.teal,
                                      fontSize: 27,fontWeight: FontWeight.w700),
                                ),
                                style: ButtonStyle(),
                              ),
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
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  signup();
                                //  Navigator.pushNamed(context, 'login');
                                },
                                child: Text(
                                  'Sign In',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.black45,
                                      fontSize: 18),
                                ),
                                style: ButtonStyle(),
                              ),
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
 signup() async{
   String myString = Uuid().v4();
   int newId = convertStringToInt(myString);
    var headers = {
      'Content-Type': 'application/json',
      'X-Amz-Content-Sha256': 'beaead3198f7da1e70d03ab969765e0821b24fc913697e929e726aeaebf0eba3',
      'X-Amz-Date': '20230519T163147Z',
      'Authorization': 'AWS4-HMAC-SHA256 Credential=AKIARCZFXHXOVPS3PLPQ/20230519/us-west-2/execute-api/aws4_request, SignedHeaders=content-length;content-type;host;x-amz-content-sha256;x-amz-date, Signature=d76767928f941e2ed275f1857cf7093cba5ae6e64df960df3f5cbef80bc7760e'
    };
    var request = http.Request('POST', Uri.parse('https://b8y8kgej6c.execute-api.us-west-2.amazonaws.com/dev/user'));
    request.body = json.encode({
      "id": newId,
      "username": '$name',
      "password": "$password",
      "email": "$email",
      "confirmpassword":"$confirmpasswod",

    });
    request.headers.addAll(headers);
    print(request);
    print(request.body);
    print(request.headers);


    http.StreamedResponse response = await request.send();
print(await response.stream.bytesToString());
    if (response.statusCode == 200) {
      Navigator.pushNamed(context, 'login');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              ' Register Successfully')));
      //print(await response.stream.bytesToString());
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              ' Already exit! Please try again later')));
      print(response.reasonPhrase);
    }

  }
  int convertStringToInt(String input) {
    int sum = 0;
    for (int i = 0; i < input.length; i++) {
      sum += input.codeUnitAt(i);
    }
    return sum;
  }
}
