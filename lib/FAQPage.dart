import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  final List<FAQItem> faqItems = [
    FAQItem(
      question: 'What is the SmartConnect app?',
      answer: 'The SmartConnect app is a mobile application developed to help users monitor and track their energy consumption. It provides real-time data on electricity usage, historical trends, and cost analysis, empowering users to make informed decisions about their energy consumption habits.',
    ),
    FAQItem(
      question: 'How can I download and install the SmartConnect app?',
      answer: 'The SmartConnect app can be downloaded and installed from the respective app stores for Android and iOS devices. Simply search for "Energy Meter" in the app store, tap on the app, and follow the installation instructions.',
    ),
    FAQItem(
      question: 'Is my energy consumption data secure?',
      answer: 'Yes, the Energy Meter app takes user privacy and data security seriously. It employs encryption and secure communication protocols to ensure that your energy consumption data is transmitted and stored securely. However, its always recommended to use secure Wi-Fi networks and keep your mobile device protected with a passcode or biometric authentication',
    ),
    FAQItem(
      question: 'How accurate is the energy consumption data provided by the app?',
      answer: 'The energy consumption data provided by the Energy Meter app is typically accurate, as it directly retrieves data from the connected energy meter device. However, occasional variations may occur due to factors like device calibration or data transmission issues. Its always a good idea to cross-reference the app data with your actual energy bills for verification.',
    ),
    // Add more FAQ items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: faqItems.length,
        itemBuilder: (BuildContext context, int index) {
          return ExpansionTile(
            title: Text(
              faqItems[index].question,
              style: TextStyle(

                fontWeight: FontWeight.bold,
                  color: Colors.teal,
              ),
            ),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(faqItems[index].answer),
              ),
            ],
          );
        },
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({
    required this.question,
    required this.answer,
  });
}
