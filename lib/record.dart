import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Record {
 // final int id;
   final String power;
  final String meterType;
  final int sensor;
  final String readingTime;

  Record({
   // required this.id,
     required this.power,
    required this.meterType,
    required this.sensor,
    required this.readingTime
  });

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      //id: json['id'],
       power: json['kWh'],
      meterType: json['meterType'] ?? '',
        sensor:json["sensorId"]??'',
        readingTime:json["readingTime"]??''

    );
  }
}

class RecordTable extends StatelessWidget {
  final List<Record> records;

  RecordTable({required this.records});

  @override
  Widget build(BuildContext context) {

      return Scaffold(

        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(label: Text('Sensor Id')),

               DataColumn(label: Text('Meter Type')),
              DataColumn(label: Text('Power Usage')),
              DataColumn(label: Text('Date'))

            ],
            rows: records.map((record) {
              return DataRow(
                cells: <DataCell>[
                  DataCell(Text(record.sensor.toString())),

                  DataCell(Text(record.meterType ?? 'N/A')),
                  DataCell(Text(record.power ?? 'N/A' )),
                 DataCell(Text(record.readingTime ?? 'N/A'))
                 // DataCell(Text(record.sensor.toString() ?? 'N/A'))
                ],
              );
            }).toList(),
          ),
        ),

    );
  }
}
class record extends StatefulWidget {
  @override
  _recordState createState() => _recordState();
}

class _recordState extends State<record> {
  List<Record> records = [];

  Future<void> fetchData() async {
    var headers = {
      'X-Amz-Date': '20230521T180655Z',
      'Authorization': 'AWS4-HMAC-SHA256 Credential=AKIARCZFXHXOVPS3PLPQ/20230521/us-west-2/execute-api/aws4_request, SignedHeaders=host;x-amz-date, Signature=2a6e36be4438fbf829e3184f2650caea6ff66760ab8dc51d1c06c1fb19260e69'
    };
    try {
      var request = http.Request('GET', Uri.parse(
          'https://b8y8kgej6c.execute-api.us-west-2.amazonaws.com/dev/meter/meterreadings'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final devicedata = await response.stream.bytesToString();
        //
        //print(json.decode(devicedata));

        var data = json.decode(devicedata);
        print(data);

        //var data = json.decode(response.body);
        var recordList = List<Map<String, dynamic>>.from(data)
            .map(
                (record) => Record.fromJson(record))
            .toList();
        setState(() {
          records = recordList;
        });
      } else {
        print('Failed to fetch records from API');
      }
    } catch (e) {
  print('Error: $e');
  }
}


@override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {


      return Scaffold(
        appBar: AppBar(
          title: Text('Record'),
backgroundColor:Colors.teal,
        ),
        body: RecordTable(records: records),

    );
  }
}
