import 'package:flutter/material.dart';
import 'package:incheon_airport_parking/res/api.dart';
import 'package:incheon_airport_parking/res/service_key.dart';

import 'model/parking.dart';

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
              child: Text(
                "인천국제공항 주차장 현황",
                style: TextStyle(
                  fontSize: 24
                ),
              ),
            )),
            Expanded(flex: 10,
              child: FutureBuilder(
                future: fetchParkingData(APIServiceKey.API_KEY),
                builder: (context, sanpshot){
                  if(sanpshot.hasData){
                   List<Parking> _items = sanpshot.data;
                   return ListView.builder(
                      itemCount: _items.length,
                     itemBuilder: (context, index){
                     return ListTile(title: Text(_items[index].floor),);
                   },);
                  }else{
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
