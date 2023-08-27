
import 'package:flutter/material.dart';
import 'package:fyp/Deletedevice.dart';
import 'package:fyp/FAQPage.dart';
import 'package:fyp/Insertdevice.dart';
import 'package:fyp/record.dart';

import 'ListDevices.dart';
import 'Profilepage.dart';
class pageone1 extends StatefulWidget {


  @override
  pageone1();
  _pageone1State createState() => _pageone1State();
}



class _pageone1State extends State<pageone1> {

  int _selectedIndex = -1;

  void _onIconPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });}





  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Home'),
      //   backgroundColor: Colors.teal,
      // ),


      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      Padding(
      padding: const EdgeInsets.all(80.0),
      child: Text(
        'Welcome to Smartconnect',
          textAlign: TextAlign.center,
        style: TextStyle(


            fontWeight: FontWeight.bold,
            color: Colors.teal,
            fontSize: 34,
          ),
        ),
    ),
    Expanded(

      child: GridView.count(
        crossAxisCount: 3,

        childAspectRatio: 1.0,
        mainAxisSpacing: 70.0,
        crossAxisSpacing: 30.0,
        padding: EdgeInsets.all(25.0),
        children: [
          HomeIcon(
            icon: Icons.people_outline_rounded,
            label: "Profile",
            selected: _selectedIndex == 0,
            onPressed: () {
              _onIconPressed(0);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                  //builder: (context) => Profilepage(userId: widget.userId),
                    builder: (context) => Profilepage(),
              ),);
            },
          ),
          HomeIcon(
            icon: Icons.grain,
            label: "Records",
            selected: _selectedIndex == 1,
            onPressed: () {
              _onIconPressed(1);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => record()),
              );
            },
          ),
          HomeIcon(
            icon: Icons.add,
            label: "Insert device",
            selected: _selectedIndex == 2,
            onPressed: () {
              _onIconPressed(2);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Insertdevice()),
              );
            },
          ),
          HomeIcon(
            icon: Icons.question_answer_outlined,
            label: "FAQs",
            selected: _selectedIndex == 3,
            onPressed: () {
              _onIconPressed(3);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FAQPage()),
              );
            },
          ),
          HomeIcon(
            icon: Icons.delete_outlined,
            label: "Remove device",
            selected: _selectedIndex == 4,
            onPressed: () {
              _onIconPressed(4);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Deletedevice()),
              );
            },
          ),
          HomeIcon(
            icon: Icons.list_alt_outlined,
            label: "Devices list",
            selected: _selectedIndex == 5,
            onPressed: () {
              _onIconPressed(5);
             Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DeviceList()),
              );
            },
          ),
        ],
      ),
    ),
    ]),);
  }
}

class HomeIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onPressed;
  final Color iconColor;
  final Color labelColor;
  final double iconSize;
  final double labelFontSize;
  final double containerWidth;
  final double containerHeight;
  final EdgeInsets containerPadding;
  final BorderRadius containerBorderRadius;
  final List<BoxShadow> containerBoxShadow;

  HomeIcon({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onPressed,
    this.iconColor = Colors.teal,
    this.labelColor = Colors.teal,
    this.iconSize = 30.0,
    this.labelFontSize = 14.0,
    this.containerWidth = 100.0,
    this.containerHeight = 900.0,
    this.containerPadding = const EdgeInsets.all(5.0),
    this.containerBorderRadius = const BorderRadius.all(Radius.circular(25.0)),
    this.containerBoxShadow = const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 100,
        offset: Offset(0, 7),
      ),
    ],
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = selected ? Colors.teal[100]! : Colors.white;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: containerWidth,
        height: containerHeight,
        padding: containerPadding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: containerBorderRadius,
          boxShadow: containerBoxShadow,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: iconColor,
            ),
            SizedBox(height: 8.0),
            Text(
              label,
              style: TextStyle(
                fontSize: labelFontSize,
                color: labelColor,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}



/*class PhonePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}*//*class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MapPage "),
      ),
      body: Center(
        child: Text("Email Page"),
      ),
    );
  }
}*/
/*class EmailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Email Page"),
      ),
      body: Center(
        child: Text("Email Page"),
      ),
    );
  }
}*/
/*class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CalendarPage"),
      ),
      body: Center(
        child: Text("Email Page"),
      ),
    );
  }
}
class  CameraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CameraPage"),
      ),
      body: Center(
        child: Text("Email Page"),
      ),
    );
  }
}*/
