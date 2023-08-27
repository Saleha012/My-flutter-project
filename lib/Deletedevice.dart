import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Device {
  final int id;
  final String name;
  final DateTime date;

  Device({required this.id, required this.name, required this.date});

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'],
      name: json['name'],
      date: DateTime.parse(json['installation_date']),
    );
  }
}

class Deletedevice extends StatefulWidget {
  @override
  _DeletedeviceState createState() => _DeletedeviceState();
}

class _DeletedeviceState extends State<Deletedevice> {
  List<Device> devices = [];

  @override
  void initState() {
    super.initState();
    fetchDevices();
  }

  Future<void> fetchDevices() async {
    // Make an API call to fetch the list of devices
    var headers = {
      'X-Amz-Date': '20230520T101119Z',
      'Authorization': 'AWS4-HMAC-SHA256 Credential=AKIARCZFXHXOVPS3PLPQ/20230520/us-west-2/execute-api/aws4_request, SignedHeaders=host;x-amz-date, Signature=68b93f92a60d8f71a6177faf4f717830e4cfac7c8dc0192e8c602847ab1fadc1'
    };
    var request = http.Request('GET', Uri.parse('https://b8y8kgej6c.execute-api.us-west-2.amazonaws.com/dev/device/list'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {

      final devicedata = await response.stream.bytesToString();
      // print(data);
      //print(json.decode(devicedata));

      final List<dynamic> responseData = json.decode(devicedata);
     // final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        devices = responseData.map((data) => Device.fromJson(data)).toList();
      });
    } else {

      print('Failed to fetch devices. Status code: ${response.statusCode}');
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device Management'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: devices.length,
              itemBuilder: (context, index) {
                final device = devices[index];
                return ListTile(
                  title: Text(device.name,
                  style: TextStyle(
                    color: Colors.teal, // Set the text color to teal
                    fontSize: 18, // Set the font size to 18
                    fontWeight: FontWeight.bold, // Set the font weight to bold
                  ),),
                  subtitle: Text(device.date.toString()),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.teal,
                    onPressed: () => removeDevice(device.id),
                  ),
                );
              },
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: TextField(
          //           decoration: InputDecoration(
          //             labelText: 'Device Name',
          //             hintText: 'Enter device name',
          //           ),
          //           onSubmitted: (value) {
          //            // addDevice(value);
          //           },
          //         ),
          //       ),
          //       IconButton(
          //         icon: Icon(Icons.add),
          //         onPressed: () {
          //          // addDevice('New Device');
          //         },
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
  Future<void> removeDevice(int deviceId) async {
    // Make an API call to remove the device

    var headers = {
      'X-Amz-Date': '20230530T045231Z',
      'Authorization': 'AWS4-HMAC-SHA256 Credential=AKIARCZFXHXOVPS3PLPQ/20230530/us-west-2/execute-api/aws4_request, SignedHeaders=host;x-amz-date, Signature=3a025139b096f9d9c6e0cf5acfa82f4c8115d260e902589ef582bde5afc17a13'
    };
    var request = http.Request('DELETE', Uri.parse('https://b8y8kgej6c.execute-api.us-west-2.amazonaws.com/dev/device?deviceId=${deviceId}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print(request);
    // print(  response.stream.bytesToString());
    if (response.statusCode == 200) {

      print("success");
      setState(() {
        devices.removeWhere((device) => device.id == deviceId);
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              ' Device ID deleted successfully.')));
    } else {
      // print( await response.stream.bytesToString());
      print('Failed to remove device. Status code: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              ' Failed to remove  Device ID')));
    }
  }

}

