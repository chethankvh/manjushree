import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:manjushree_constructions/widgets/appbar.dart';
import 'package:manjushree_constructions/widgets/bottomnavigator.dart';
import '../Service/progressbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Service/api.dart';
import 'package:http/http.dart' as http;

class Vehicles extends StatefulWidget {
  const Vehicles({key}) : super(key: key);

  @override
  _VehiclesState createState() => _VehiclesState();
}

class _VehiclesState extends State<Vehicles> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double width, height;
  List vehicles = [];
  int vehiclescount = 0;
  List resultdetails;
  bool isLoading = false;
  ProgressBar _sendingMsgProgressBar;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');

    final int userid = prefs.getInt('user_id');

    String url = '/v1/getvehicles?api_token=$token';
    http.Response res = await CallApi().getData(url);
    // ignore: always_specify_types
    var jsonResponse = json.decode(res.body);
    // print('Repsonse');
    // print(jsonResponse);
    // update data and loading status
    if (jsonResponse == []) {
      isLoading = false;
    } else {
      setState(() {
        //   print('items: ' + items.toString());
        resultdetails = jsonResponse;
        vehiclescount = jsonResponse.length;
        //print('resultdet $resultdetails');
        vehicles.addAll(resultdetails);
        //  print('resultdet $vehicles');
        isLoading = false;
      });
    }
  }

  Widget _projectBuilder(BuildContext context, int position) {
    final String name = vehicles[position]['vehicle'];
    int id = vehicles[position]['id'];
    int hirestatus = vehicles[position]['hirestatus'];
    String vehicleType = vehicles[position]['type'];

    return Container(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: height * 1 / 100),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: width * 1 / 100),
            child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Container(
                    child: Text(
                      name,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18),
                      maxLines: 1,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0))),
                  ),
                  new GestureDetector(
                    onTap: () {
                      setState(() {});
                    },
                    child: new Container(
                        margin: const EdgeInsets.all(0.0),
                        child: Text("Started")),
                  ),
                ]),
          ),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: () {
          return showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  title: const Text(
                    'Confirm Exit',
                    style: TextStyle(color: Colors.black),
                  ),
                  content: const Text(
                    'Are you sure you want to exit?',
                    style: TextStyle(color: Colors.black),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      color: Colors.red,
                      child: const Text('YES'),
                      onPressed: () {
                        //SystemNavigator.pop();
                      },
                    ),
                    FlatButton(
                      color: Colors.green,
                      child: const Text('NO'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          appBar: MappBar(
            scaffoldKey: _scaffoldKey,
          ),
          bottomNavigationBar: BottomNavigation(
            cIndex: 0,
          ),
          body: Padding(
            padding: EdgeInsets.all(height * 2 / 100),
            child: NestedScrollView(
              headerSliverBuilder: (context, value) {
                return [
                  SliverToBoxAdapter(),
                ];
              },
              body: Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 2 / 100),
                  child: ListView.builder(
                      itemCount: vehiclescount,
                      itemBuilder: _projectBuilder,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true),
                ),
              ),
            ),
          ),
        ));
  }
}
