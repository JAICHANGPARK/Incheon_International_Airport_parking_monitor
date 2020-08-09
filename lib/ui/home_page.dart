import 'package:flutter/material.dart';
import 'package:incheon_airport_parking/model/parking.dart';
import 'package:incheon_airport_parking/res/api.dart';
import 'package:incheon_airport_parking/res/service_key.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchParkingData(APIServiceKey.API_KEY),
      builder: (context, snapShot){
        if(snapShot.hasData){
          List<Parking> _items = snapShot.data;
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
    );
  }
}
