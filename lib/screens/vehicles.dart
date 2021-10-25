import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:manjushree_constructions/widgets/appbar.dart';
import 'package:manjushree_constructions/widgets/bottomnavigator.dart';
import 'package:manjushree_constructions/service/progressbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Service/api.dart';
import 'package:http/http.dart' as http;
import 'package:manjushree_constructions/widgets/textformfileld.dart';

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
  TextEditingController odometernum = TextEditingController();
  @override
  void initState() {
    super.initState();

    _loadData();
    _sendingMsgProgressBar = ProgressBar();
  }

  void showSendingProgressBar() {
    _sendingMsgProgressBar.show(context);
  }

  void hideSendingProgressBar() {
    _sendingMsgProgressBar.hide();
  }

  @override
  void dispose() {
    _sendingMsgProgressBar.hide();
    super.dispose();
  }

  Future _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');

    final int userid = prefs.getInt('user_id');
    showSendingProgressBar();
    String url = '/v1/getvehicles?api_token=$token';
    http.Response res = await CallApi().getData(url);
    // ignore: always_specify_types
    var jsonResponse = json.decode(res.body);
    // print('Repsonse');
    // print(jsonResponse);
    // update data and loading status
    if (jsonResponse == []) {
      hideSendingProgressBar();
      isLoading = false;
    } else {
      hideSendingProgressBar();
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

  void _vehiclestatus(id, startorend) async {
    showSendingProgressBar();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    String odonum = '';
    String url = '/v1/getvehiclestart?vid=$id&api_token=$token';
    http.Response res = await CallApi().getData(url);
    print(url);
    // ignore: always_specify_types
    var jsonResponse = json.decode(res.body);
    print('Repsonse');
    print(jsonResponse);
    if (jsonResponse == []) {
      hideSendingProgressBar();
      isLoading = false;
      odometernum = TextEditingController();
    } else {
      hideSendingProgressBar();
      odonum = jsonResponse['startnum'].toString();
      if (odonum == "null") {
        odonum = '';
      }
      odometernum = TextEditingController(text: odonum);
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  right: -20.0,
                  top: -40.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Enter Vehicle $startorend Reading',
                            style: TextStyle(color: Colors.black)),
                      ),
                      Container(
                        child: TextFormWidget(
                            placeholder: 'ODO Reading',
                            valController: odometernum,
                            keytype: TextInputType.number),
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            RaisedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel"),
                              color: Colors.red,
                              textColor: Colors.white,
                            ),
                            RaisedButton(
                              onPressed: () {
                                setState(() {
                                  Navigator.pop(context);
                                  vehiclerunning(id, startorend);
                                });
                              },
                              child: Text("Save"),
                              color: Colors.green,
                              textColor: Colors.white,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  void vehiclerunning(id, status) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    final int userid = prefs.getInt('user_id');
    showSendingProgressBar();
    final Map<String, String> data = {
      'vehicleodonum': odometernum.text,
      'vid': id.toString(),
      'vhstatus': status,
      'userid': userid.toString(),
      'created_by': userid.toString(),
      'updated_by': userid.toString(),
      'api_token': token,
    };
    String url = '/v1/updatevehicleodo';
    final http.Response res = await CallApi().postData(data, url);

    // ignore: always_specify_types
    var jsonResponse = json.decode(res.body);
    //print(jsonResponse);
    FocusScope.of(context).requestFocus(FocusNode());
    //print('text');
    //print(jsonResponse[0]['text']);
    hideSendingProgressBar();
    if (jsonResponse[0]['type'] == 'success') {
      //print(jsonResponse[0]['text']);
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Theme(
            data: ThemeData.light(),
            child: Text(
              jsonResponse[0]['text'],
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: Colors.white,
                  fontSize: width * 3 / 100,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
      Future.delayed(const Duration(seconds: 1), () {
        odometernum = TextEditingController();
        Navigator.pushNamed(context, '/vehicles');
      });
    } else {
      print(jsonResponse[0]['title']);
    }
  }

  Widget _vehicleList(BuildContext context, int position) {
    final String name = vehicles[position]['vehicle'];
    int id = vehicles[position]['id'];
    int hirestatus = vehicles[position]['hirestatus'];
    String vehicleType = vehicles[position]['type'];
    Color vcolor;
    String vehiclecond = '';
    String startorend = '';
    String status = '';
    var iseven = id.floor().isEven ? true : false;
    int color_range = 100;
    if (iseven == true) {
      color_range = 200;
    } else {
      color_range = 350;
    }
    if (hirestatus == 1) {
      vehiclecond = 'Started';
      vcolor = Colors.red;
      startorend = "End ODO";
      status = "End";
    } else {
      vehiclecond = 'Stopped';
      vcolor = Colors.green;
      startorend = "Start ODO";
      status = "Start";
    }

    return GestureDetector(
        child: Card(
          // 1
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          // 2
          color: Colors.grey[color_range],
          elevation: 0,
          child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.only(left: 15.0, right: 15.0),
              trailing: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            vcolor,
                            vcolor,
                          ],
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(10.0),
                      primary: Colors.white,
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                    onPressed: () {
                      _vehiclestatus(id, status);
                    },
                    child: Text(vehiclecond),
                  ),
                ],
              ),
              title: Text(
                name,
                style: TextStyle(letterSpacing: 3.0, color: Colors.black),
              ),
              subtitle: Text(
                vehicleType,
                style: TextStyle(color: Colors.brown),
              ),
            ),
          ]),
        ),

        // 3
        onTap: () {});
  }

  String _title;

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
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle:
                            const TextStyle(fontSize: 20, color: Colors.green),
                      ),
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
              padding: EdgeInsets.all(height * 1 / 100),
              child: NestedScrollView(
                headerSliverBuilder: (context, value) {
                  return [
                    SliverToBoxAdapter(),
                  ];
                },
                body: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(
                            bottom: 5, // Space between underline and text
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: Colors.amber,
                            width: 3.0, // Underline thickness
                          ))),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Vehicles List',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ])),
                      Container(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: height * 2 / 100),
                          child: ListView.builder(
                              itemCount: vehiclescount,
                              itemBuilder: _vehicleList,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true),
                        ),
                      ),
                    ]),
              ),
            )));
  }
}
