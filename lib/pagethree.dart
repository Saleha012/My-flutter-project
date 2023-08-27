
import 'package:flutter/cupertino.dart';



import 'package:flutter/material.dart';

class Pagethree extends StatelessWidget {


  late final String date;
  late final double reading;

  Pagethree({required this.date, required this.reading});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
         title: Text('Meter Reading'),
         backgroundColor: Colors.teal,

       ),
      body: ListTile(
        title: Text(date),
        subtitle: Text('$reading kWh'),
        leading: Icon(Icons.electric_meter),
      ),
    );
  }
}
