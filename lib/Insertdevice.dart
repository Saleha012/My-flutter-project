import 'dart:convert';
import 'dart:ffi';
import 'package:lil_auto_increment/lil_auto_increment.dart';
import 'package:uuid/uuid.dart';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Device {
  final String name;
  final DateTime date;
  final String metertype;
  final String metername;
  final String deviceaddress;


  Device({
    required this.name,
    required this.date,
    required this.metertype,
    required this.metername,
    required this.deviceaddress});




}

class Insertdevice extends StatelessWidget {
 //var count = 1;

 var uuid = Uuid();


 final deviceNameController = TextEditingController();
  final deviceaddressController = TextEditingController();
  final meternameController = TextEditingController();
  final metertypeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back), // Set the return arrow icon
            onPressed: () {
              Navigator.of(context).pop(); // Go back to the previous screen
            },
          ),
          title: Text('Add Device'),

        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: deviceNameController,
                decoration: InputDecoration(
                  labelText: 'Device Name',
                  labelStyle: TextStyle(color: Colors.teal), // Set the label text color to teal
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal), // Set the border color when focused to teal
                  ),

                ),
              ),
              TextField(
                controller: deviceaddressController,
                decoration: InputDecoration(
                  labelText: 'Device Address',
                  labelStyle: TextStyle(color: Colors.teal), // Set the label text color to teal
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal), // Set the border color when focused to teal
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: meternameController,
                decoration: InputDecoration(
                  labelText: 'Meter Name',
                  labelStyle: TextStyle(color: Colors.teal), // Set the label text color to teal
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal), // Set the border color when focused to teal
                  ),

                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: metertypeController,
                decoration: InputDecoration(
                  labelText: 'Meter Type',
                  labelStyle: TextStyle(color: Colors.teal), // Set the label text color to teal
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal), // Set the border color when focused to teal
                  ),

                ),
              ),

              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal, // Set the button color to teal
                ),
                onPressed: () async {
                  final deviceName = deviceNameController.text;
                  final deviceaddress = deviceaddressController.text;
                  final metername  = meternameController.text;
                  final meterType  = metertypeController.text;
                  final deviceDate = DateTime.now();
                  final newDevice = Device(
                      name: deviceName,
                      deviceaddress: deviceaddress,
                      metername: metername,
                      date: deviceDate,
                      metertype :meterType
                  );

                  final success = await addDevice(newDevice);
                  if (success) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Success'),
                          content: Text('Device added successfully.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('Failed to add device.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                deviceNameController.clear();


                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },

                child: Text('Add Device'),
              ),
            ],
          ),
        ),
      ),


    );

  }
  Future<bool>  addDevice(Device device) async {
    String myString = Uuid().v4();
    int newId = convertStringToInt(myString);
   // print(newId);
    var headers = {
      'Content-Type': 'application/json',
      'X-Amz-Content-Sha256': 'beaead3198f7da1e70d03ab969765e0821b24fc913697e929e726aeaebf0eba3',
      'X-Amz-Date': '20230520T062138Z',
      'Authorization': 'AWS4-HMAC-SHA256 Credential=AKIARCZFXHXOVPS3PLPQ/20230520/us-west-2/execute-api/aws4_request, SignedHeaders=content-length;content-type;host;x-amz-content-sha256;x-amz-date, Signature=fb1ead1ce374e2111a5146f24df0e3101309cb350a9b24b7ccf06f2e3c81520a'
    };
    var request = http.Request('POST', Uri.parse('https://b8y8kgej6c.execute-api.us-west-2.amazonaws.com/dev/device'));
   // print("nextId1");
     // print(nextId1().toString());
    request.body = json.encode({

      'name': device.name,
      'installation_date': device.date.toIso8601String(),
      "address": device.deviceaddress,
      "meter_name": device.metername,
      "meter_type":device.metertype,
      "id": newId
    });
    request.headers.addAll(headers);
     print(request.body);
    http.StreamedResponse response = await request.send();


    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;

      // print(await response.stream.bytesToString());
    }
    else {
       print(response.reasonPhrase);
      return false;
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
