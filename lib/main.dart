import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:incheon_airport_parking/res/api.dart';
import 'package:incheon_airport_parking/res/service_key.dart';
import 'package:incheon_airport_parking/ui/terminal_one_page.dart';
import 'package:line_icons/line_icons.dart';

import 'model/parking.dart';
import 'ui/home_page.dart';
import 'ui/terminal_two_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  int _selectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    fetchParkingData(APIServiceKey.API_KEY);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "인천국제공항 주차장 현황",
                    style: TextStyle(
                        fontSize: 24
                    ),
                  ),
                  IconButton(icon: Icon(Icons.settings,),iconSize: 28, onPressed: (){})
                ],

              ),
            )),
            Expanded(flex: 10,
              child: IndexedStack(
                index: _selectedIndex,
                children: [
                  HomePage(),
                  TerminalOnePage(),
                  TerminalTwoPage(),
                ],
              )
            ),
          ],
        ),
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: Colors.grey[800],
                tabs: [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.local_parking_sharp,
                    text: '터미널1',
                  ),
                  GButton(
                    icon: Icons.local_parking_sharp,
                    text: '터미널2',
                  ),

                ],

                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
    );
  }
}
