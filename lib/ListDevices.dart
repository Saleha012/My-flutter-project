import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Device {
  final int id;
  final String name;
  final DateTime date;
  final String metertype;
  final String metername;
  final String deviceaddress;

  Device({
    required this.id,
    required this.name,
    required this.date,
    required this.metertype,
    required this.metername,
    required this.deviceaddress,
  });
}

class DeviceList extends StatefulWidget {
  @override
  _DeviceListState createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
  List<Device> devices = [];

  Future<List<Device>> fetchDevices() async {
    var headers = {
      'X-Amz-Date': '20230520T101119Z',
      'Authorization': 'AWS4-HMAC-SHA256 Credential=AKIARCZFXHXOVPS3PLPQ/20230520/us-west-2/execute-api/aws4_request, SignedHeaders=host;x-amz-date, Signature=68b93f92a60d8f71a6177faf4f717830e4cfac7c8dc0192e8c602847ab1fadc1'
    };
    var request = http.Request('GET', Uri.parse('https://b8y8kgej6c.execute-api.us-west-2.amazonaws.com/dev/device/list'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      //  print( await response.stream.bytesToString());
      final devicedata = await response.stream.bytesToString();
      // print(data);
      print(json.decode(devicedata));

      final List<dynamic> responseData = json.decode(devicedata);
      final List<Device> devices = responseData.map((data) {
        return Device(
          id: data['id'],
          name: data['name'],
          date: DateTime.parse(data['installation_date']),
          metertype: data['meter_type'],
          metername: data['meter_name'],
          deviceaddress: data['address'],
        );
      }).toList();
      return devices;
    } else {
      throw Exception('Failed to fetch devices');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDevices().then((fetchedDevices) {
      setState(() {
        devices = fetchedDevices;
      });
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to fetch devices.'),
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device List'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: devices.length,
        itemBuilder: (context, index) {
          final device = devices[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            child: Card(
              elevation: 2,
              child: ListTile(title: Text(
                device.name,
                style: TextStyle(
                  color: Colors.teal, // Set the text color to teal
                  fontSize: 18, // Set the font size to 18
                  fontWeight: FontWeight.bold, // Set the font weight to bold
                ),
              ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [



                    Text('id: ${device.id.toString()}'),
                    Text('Installation Date: ${device.date.toString()}'),
                    Text('Meter Name: ${device.metername}'),
                    Text('Meter Type: ${device.metertype}'),
                    Text('Device Address: ${device.deviceaddress}'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
