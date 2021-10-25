import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:manjushree_constructions/widgets/appbar.dart';
import 'package:manjushree_constructions/widgets/bottomnavigator.dart';
import 'package:manjushree_constructions/widgets/projectlist.dart';
import 'package:manjushree_constructions/service/progressbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Service/api.dart';
import 'package:http/http.dart' as http;

class DashboardPage extends StatefulWidget {
  const DashboardPage({key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double width, height;
  List projects = [];
  int projectscount = 0;
  int runnigvehiclescount = 0;
  List resultdetails;
  List runningvehicles = [];
  bool isLoading = false;
  ProgressBar _sendingMsgProgressBar;

  @override
  void initState() {
    super.initState();
    _loadData();
    _sendingMsgProgressBar = ProgressBar();
  }

  @override
  void dispose() {
    _sendingMsgProgressBar.hide();
    super.dispose();
  }

  void showSendingProgressBar() {
    _sendingMsgProgressBar.show(context);
  }

  void hideSendingProgressBar() {
    _sendingMsgProgressBar.hide();
  }

  Future _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    final int userid = prefs.getInt('user_id');
    showSendingProgressBar();
    String url = '/v1/getprojects?userid=$userid&api_token=$token';
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
      setState(() {
        hideSendingProgressBar();
        //   print('items: ' + items.toString());
        resultdetails = jsonResponse['detail'];
        projectscount = jsonResponse['count'];
        //print('resultdet $resultdetails');
        projects.addAll(resultdetails);
        // print('resultdet $projects');
        isLoading = false;
      });
    }

    String url2 = '/v1/getvehicles?running=1api_token=$token';
    http.Response res2 = await CallApi().getData(url2);
    //print(url);
    // ignore: always_specify_types
    var jsonResponse2 = json.decode(res2.body);
    // print('Repsonse');
    // print(jsonResponse2);
    if (jsonResponse2 == []) {
      runningvehicles = [];
      runnigvehiclescount = jsonResponse2.length;
    } else {
      setState(() {
        runnigvehiclescount = jsonResponse2.length;
        runningvehicles.addAll(jsonResponse2);
      });
    }
  }

  Widget _projectBuilder(BuildContext context, int position) {
    final String name = projects[position]['projectname'];
    int id = projects[position]['id'];
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 1 / 100),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: width * 1 / 100),
            child: Container(
              child: Column(children: [
                ProjectList(width: width, projectname: name, projid: id),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _vehicleList(BuildContext context, int position) {
    final String name = runningvehicles[position]['vehicle'];
    int id = runningvehicles[position]['id'];

    String vehicleType = runningvehicles[position]['type'];
    Color vcolor;

    var iseven = id.floor().isEven ? true : false;
    int color_range = 100;
    if (iseven == true) {
      color_range = 200;
    } else {
      color_range = 350;
    }

    return GestureDetector(
        child: Card(
      // 1
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      // 2
      color: Colors.grey[color_range],
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.only(left: 15.0, right: 15.0),
            title: Text(
              name,
              style: TextStyle(letterSpacing: 3.0, color: Colors.black),
            ),
            subtitle: Text(
              vehicleType,
              style: TextStyle(color: Colors.brown),
            ),
          ),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: MappBar(
        scaffoldKey: _scaffoldKey,
      ),
      bottomNavigationBar: BottomNavigation(
        cIndex: 0,
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(height * 1 / 100),
          child: Column(
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
                            'My Projects',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )
                        ])),
                Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 2 / 100),
                    child: ListView.builder(
                        itemCount: projectscount,
                        itemBuilder: _projectBuilder,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics()),
                  ),
                ),
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
                            'Running Vehicles',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )
                        ])),
                Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 2 / 100),
                    child: ListView.builder(
                        itemCount: runnigvehiclescount,
                        itemBuilder: _vehicleList,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics()),
                  ),
                )
              ])),
    );
  }
}
