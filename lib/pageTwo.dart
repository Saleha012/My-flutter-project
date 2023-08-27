import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;

class ChartData {
  final String timePeriod;
  final double value;
  bool isExpanded; // Add isExpanded property

  ChartData({required this.timePeriod, required this.value, this.isExpanded = false});
}

class pageTwo extends StatefulWidget {
  @override
  _pageTwoState createState() => _pageTwoState();
}



class _pageTwoState extends State<pageTwo> {
  String meterId = '';
  String selectedGraphType = 'yearly';

  List<ChartData> dailyChartData = [];
  List<ChartData> hourlyChartData = [];
  List<ChartData> weeklyChartData = [];
  List<ChartData> monthlyChartData = [];
  List<ChartData> yearlyChartData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meter Energy Charts'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                meterId = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Search by Meter ID',
              labelStyle: TextStyle(color: Colors.teal), // Set the label text color to teal
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal), // Set the border color when focused to teal
              ),

            ),
          ),
          ElevatedButton(
            onPressed: () {
              fetchData();
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.teal, // Set the button color to teal
            ),
            child: Text('Fetch Data'),
          ),
          DropdownButton<String>(
            value: selectedGraphType,
            onChanged: (String? value) {
              setState(() {
                selectedGraphType = value!;
              });
            },
            items: <String>['yearly', 'monthly', 'daily']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: buildChartWidget(),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> fetchData() async {
    var headers = {
      'X-Amz-Date': '20230523T181409Z',
      'Authorization':
      'AWS4-HMAC-SHA256 Credential=AKIARCZFXHXOVPS3PLPQ/20230523/us-west-2/execute-api/aws4_request, SignedHeaders=host;x-amz-date, Signature=07e6eeb01af9c0a9ea49603dd1e059031d90d92b18536f61b67a6960c4346882'
    };
    var request = http.Request(
      'GET',
      Uri.parse('https://b8y8kgej6c.execute-api.us-west-2.amazonaws.com/dev/meter/meterreadings/dashboard?deviceId=9999'),
    );

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final devicedata = await response.stream.bytesToString();
      final jsonData = json.decode(devicedata) as Map<String, dynamic>;

      setState(() {
        dailyChartData = [];
        hourlyChartData = [];
        weeklyChartData = [];
        monthlyChartData = [];
        yearlyChartData = [];

        final hourlyData = jsonData['hourly'] as List<dynamic>;
        for (var entry in hourlyData) {
          if (entry['date'] != null && entry['kwh'] != null) {
            hourlyChartData.add(ChartData(
              timePeriod: entry['date'],
              value: entry['kwh'].toDouble(),
            ));
          }
        }

        final dailyData = jsonData['daily'] as List<dynamic>;
        for (var entry in dailyData) {
          if (entry['date'] != null && entry['kwh'] != null) {
            dailyChartData.add(ChartData(
              timePeriod: entry['date'],
              value: entry['kwh'].toDouble(),
            ));
          }
        }

        final weeklyData = jsonData['weekly'] as List<dynamic>;
        for (var entry in weeklyData) {
          if (entry['date'] != null && entry['kwh'] != null) {
            weeklyChartData.add(ChartData(
              timePeriod: entry['date'],
              value: entry['kwh'].toDouble(),
            ));
          }
        }

        final monthlyData = jsonData['monthly'] as List<dynamic>;
        for (var entry in monthlyData) {
          if (entry['date'] != null && entry['kwh'] != null) {
            monthlyChartData.add(ChartData(
              timePeriod: entry['date'],
              value: entry['kwh'].toDouble(),
            ));
          }
        }

        final yearlyData = jsonData['yearly'] as List<dynamic>;
        for (var entry in yearlyData) {
          if (entry['date'] != null && entry['kwh'] != null) {
            yearlyChartData.add(ChartData(
              timePeriod: entry['date'],
              value: entry['kwh'].toDouble(),

            ));
          }
        }
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Widget buildChartWidget() {
    List<ChartData> chartData = [];
    switch (selectedGraphType) {
      case 'daily':
        chartData = dailyChartData;
        break;
      case 'hourly':
        chartData = hourlyChartData;
        break;
      case 'weekly':
        chartData = weeklyChartData;
        break;
      case 'monthly':
        chartData = monthlyChartData;
        break;
      case 'yearly':
        chartData = yearlyChartData;
        break;
    }

    return charts.TimeSeriesChart(
      [
        charts.Series<ChartData, DateTime>(
          id: 'Energy',
          domainFn: (ChartData data, _) => DateTime.parse(data.timePeriod),
          measureFn: (ChartData data, _) => data.value,
          data: chartData,
        ),
      ],
      animate: true,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }
}

