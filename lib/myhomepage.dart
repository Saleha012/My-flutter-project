import 'package:flutter/material.dart';
import 'package:fyp/FeedbackPage.dart';
import 'package:fyp/pageTwo.dart';
// Import the file where pageTwo widget is defined
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fyp/pageone1.dart';
import 'package:fyp/pagethree.dart';
import 'package:fyp/profile.dart';
import 'package:fyp/record.dart';

import 'FAQPage.dart';

import 'ListDevices.dart';
import 'Profilepage.dart';
import 'login.dart';
class myhomepage extends StatefulWidget {
 // final String userId;

  myhomepage();

  //const myhomepage({Key? key}) : super(key: key);
  @override
  State<myhomepage> createState() => _myhomepageState();
}
class _myhomepageState extends State<myhomepage> {

  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    pageone1(),
    pageTwo(),
    record(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        image: DecorationImage(
          image: AssetImage('assets/images.jpg'),
          fit: BoxFit.cover,
        ),
      ),

      child: Scaffold(
          appBar: AppBar(
            title: Text('Home'),
            backgroundColor: Colors.teal,
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                    child: Text('Menu'),
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/theme.jpg')))
                ),
                ListTile(
                  leading: Icon(Icons.verified_user),
                  title: Text('Profile',),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => Profilepage()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.help),
                  title: Text('FAQ'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => FAQPage()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.devices),
                  title: Text('Devices'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => DeviceList()));
                  },),
                ListTile(
                  leading: Icon(Icons.border_color),
                  title: Text('Feedback'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => FeedbackPage()));
                  },),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Logout'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MyLogin()));
                  },),

                AboutListTile( // <-- SEE HERE
                  icon: Icon(
                    Icons.info,
                  ),
                  child: Text('About app'),
                  applicationIcon: Icon(
                    Icons.local_play,
                  ),
                  applicationName: 'SmartConnect',
                  applicationVersion: '1.0.25',
                  applicationLegalese: '© 2023 Company',
                  aboutBoxChildren: [

                    ///Content goes here...
                  ],
                ),
              ],
            ),
          ),
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.auto_graph),
                label: 'Statics',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Record',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.teal,
            onTap: _onItemTapped,
          )
      ),);
  }

}


