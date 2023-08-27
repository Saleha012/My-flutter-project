import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class Feed {
  final int id;
  final String feedType;
  final String description;

  Feed({required this.id, required this.feedType, required this.description});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'feedType': feedType,
      'description': description,
    };
  }
}

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}
int convertStringToInt(String input) {
  int sum = 0;
  for (int i = 0; i < input.length; i++) {
    sum += input.codeUnitAt(i);
  }
  return sum;
}
class _FeedbackPageState extends State<FeedbackPage> {
  var uuid = Uuid();


  final TextEditingController _feedbackController = TextEditingController();
  String _selectedCategory = 'General';

  List<String> _categories = [
    'General',
    'Bug Report',
    'Feature Request',
    'Other',
  ];

  void _submitFeedback() {
    String myString = Uuid().v4();
    int newId = convertStringToInt(myString);
    final category = _selectedCategory;
    final feedback = _feedbackController.text;

    final feed = Feed(id: newId, feedType: category, description: feedback);

    saveFeedback(feed);

    print('Feedback submitted: Category: $category, Feedback: $feedback');
  }

  void saveFeedback(Feed feed) async {
    var headers = {
      'Content-Type': 'application/json',
      // Add your headers as required
    };
    var request = http.Request(
      'POST',
      Uri.parse('https://b8y8kgej6c.execute-api.us-west-2.amazonaws.com/dev/feed'),
    );
    request.body = json.encode(feed.toJson());
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      print(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Feedback Submitted'),
              content: Text('Thank you for your feedback!'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        print(response.reasonPhrase);
        print('Failed to submit feedback. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error submitting feedback: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              onChanged: (newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
              items: _categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.teal, // Set the border color to teal
                  ),
                ),
              ),
              style: TextStyle(
                color: Colors.teal, // Set the text color to teal
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _feedbackController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Feedback',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.teal, // Set the border color to teal
                  ),
                ),
              ),
              style: TextStyle(
                color: Colors.teal, // Set the text color to teal
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitFeedback,
              style: ElevatedButton.styleFrom(
                primary: Colors.teal, // Set the button background color to teal
              ),
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
