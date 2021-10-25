import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:manjushree_constructions/widgets/appbar.dart';
import 'package:manjushree_constructions/widgets/bottomnavigator.dart';
import 'package:manjushree_constructions/widgets/tripviewdet.dart';
import '../Service/api.dart';
import 'package:http/http.dart' as http;
import '../Service/progressbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TripView extends StatefulWidget {
  TripView({@required this.projectid, this.proj});

  final int projectid;
  final String proj;
  @override
  _TripViewState createState() => _TripViewState();
}

class _TripViewState extends State<TripView> {
  List<dynamic> listdata;
  int listdatacount = 0;
  List tsdetails = [];
  ScrollController scrollController;
  @override
  void initState() {
    super.initState();
    // print("projectid");
    getTripsheets(widget.projectid);
  }

  Future<void> getTripsheets(projectid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    // print("projectiddw$projectid");
    final String url =
        '/v1/gettripsheet?project=$projectid&sort=tsdate|desc&api_token=$token';
    final http.Response res = await CallApi().getData(url);
    //  print("tpsapi$res");
    // ignore: always_specify_types
    final resdata = json.decode(res.body);
    //print("tps$resdata");
    setState(() {
      listdata = resdata['data'];
      listdatacount = resdata['count'];
    });

    //print('listdatacount$listdatacount');
  }

  double width, height;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _tslistBuilder(BuildContext context, int index) {
    // print('lstdata$listdata');
    tsdetails = [];
    int tsid = listdata[index]['id'];
    String projectname = listdata[index]['project'];
    String equpnum = listdata[index]['eqnum'];
    String tsnum = listdata[index]['tsnumber'].toString();
    String tstime = listdata[index]['tstime'];
    String tsdate = listdata[index]['tsdate'];
    var tsentrydetail = {
      'tsid': tsid,
      'projname': projectname,
      'equpnum': equpnum,
      'tsnum': tsnum,
      'tstime': tstime,
      'tsdate': tsdate,
    };
    // print(tsentrydetail);
    tsdetails.add(tsentrydetail);
    return SingleChildScrollView(   child: Padding(
      padding: EdgeInsets.symmetric(vertical: height * 1 / 100),
      child: Column(
        children: <Widget>[
         
            Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
            Container(
              child: Column(children: [
                //  print('lstdata$tsdetails');
                TripViewDetails(
                    height: height, width: width, listdata: tsdetails),
              ]),
            ),
      ] 
          ),
      
        ],
      ),
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      floatingActionButton: Container(
        height: height *5 / 100,
        child: FloatingActionButton.extended(
          backgroundColor: Color(0xff9E0202),
          onPressed: () {
            Navigator.pushNamed(context, '/tripsheetentry');
          },
          icon: Icon(Icons.edit),
          label: Text(
            'Add New Trip Sheet',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
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
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'TRIP SHEET',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Divider(height: height * 1 / 100, color: Colors.black),
                  ],
                ),
              ),
            ];
          },
          body: Container(
            
            child: ListView.separated(
              itemBuilder: _tslistBuilder,
              itemCount: listdatacount,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) {
                return Divider(height: height * .2 / 100, color: Colors.black);
              },
            ),
          ),
        ),
      ),
    );
  }
}
