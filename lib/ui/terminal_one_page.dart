import 'package:flutter/material.dart';
import 'package:incheon_airport_parking/model/parking.dart';
import 'package:incheon_airport_parking/res/api.dart';
import 'package:incheon_airport_parking/res/service_key.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

class TerminalOnePage extends StatefulWidget {
  @override
  _TerminalOnePageState createState() => _TerminalOnePageState();
}

class _TerminalOnePageState extends State<TerminalOnePage> with
SingleTickerProviderStateMixin{
  TabController _tabController;
  List<Parking> _shortParking = [];
  List<Parking> _longParking = [];

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    fetchParkingTerminalOneData(APIServiceKey.API_KEY).then((value){
      print(value);
      value.forEach((element) {
        print(element.floor);
        String _floor = element.floor;
        List<String> _ff = _floor.split(" ");
        String _length = _ff[1];
        print(_length.substring(0,2));
        if(_length.substring(0,2) == "단기"){
          _shortParking.add(element);
        }else if(_length.substring(0,2) == "장기"){
          _longParking.add(element);
        }

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: TabBar(
            controller: _tabController,
            labelStyle: TextStyle( //up to your taste
                fontWeight: FontWeight.w700
            ),
            indicatorSize: TabBarIndicatorSize.label, //makes it better
            labelColor: Color(0xff1a73e8), //Google's sweet blue
            unselectedLabelColor: Color(0xff5f6368), //niceish grey
            isScrollable: true, //up to your taste
            indicator: MD2Indicator( //it begins here
                indicatorHeight: 3,
                indicatorColor: Color(0xff1a73e8),
                indicatorSize: MD2IndicatorSize.normal //3 different modes tiny-normal-full
            ),
            tabs: <Widget>[
              Tab(
                text: "단기주차장",
              ),
              Tab(
                text: "장기주차장",
              ),

            ],
          ),
        ),
        Expanded(
          flex: 10,
          child: TabBarView(
              controller: _tabController,
              children: [
                _shortParking.length > 0 ? ListView.builder(
                    itemCount: _shortParking.length,
                    itemBuilder: (context, index){
                  return ListTile(
                    title: Text(_shortParking[index].floor),
                  );
                }) : Center(child: CircularProgressIndicator(),),
                _longParking.length > 0 ? ListView.builder(
                    itemCount: _longParking.length,
                    itemBuilder: (context, index){
                      return ListTile(
                        title: Text(_longParking[index].floor),
                      );
                    }) : Center(child: CircularProgressIndicator(),),
              ]),
        )
      ],
    );
  }
}
