import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class User {
  final int id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['username'],
      email: json['email'],
    );
  }
}

class Profilepage extends StatefulWidget {
  @override
  _ProfilepageState createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  User? currentUser;

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    try {
      var headers = {
        'X-Amz-Date': '20230520T183944Z',
        'Authorization': 'AWS4-HMAC-SHA256 Credential=AKIARCZFXHXOVPS3PLPQ/20230520/us-west-2/execute-api/aws4_request, SignedHeaders=host;x-amz-date, Signature=eacdc76aac6c20dec486de054b40a7c545705eff8c8dc00dd64d151616d8fbb6'
      };
      var request = http.Request('GET', Uri.parse('https://b8y8kgej6c.execute-api.us-west-2.amazonaws.com/dev/user?userId=2307'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responseData = json.decode(await response.stream.bytesToString());
        setState(() {
          currentUser = User.fromJson(responseData);
          print(currentUser);
        });
      } else {
        print('Failed to fetch user details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
        backgroundColor: Colors.teal,
      ),
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: currentUser != null
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ID:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '${currentUser!.id}',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Name:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  currentUser!.name,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Email:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  currentUser!.email,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            )
     /* body: currentUser != null
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ID: ${currentUser!.id.toString()}'),
          Text('Name: ${currentUser!.name}'),
          Text('Email: ${currentUser!.email}'),
        ],*/

          : Center(
        child: CircularProgressIndicator(),
      ),),
    );
  }
}
