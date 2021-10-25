import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:manjushree_constructions/widgets/appbarinner.dart';
import '../service/constant.dart';
import 'package:manjushree_constructions/widgets/tripviewdet.dart';
import '../Service/api.dart';
import 'package:http/http.dart' as http;
import '../Service/progressbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Materials extends StatefulWidget {
  Materials({@required this.tripsheetid, this.projectdetail});
  final int tripsheetid;
  final List<dynamic> projectdetail;

  @override
  _MaterialsState createState() => _MaterialsState();
}

class _MaterialsState extends State<Materials> {
  List<dynamic> listdata = [];
  int listdatacount = 0;
  List tsdetails = [];
  ScrollController scrollController;
  ProgressBar _sendingMsgProgressBar;
  @override
  void initState() {
    super.initState();
    // print("tsids");
    // print(widget.projectdetail);
    getTSmaterials(widget.tripsheetid);
  }

  @override
  void dispose() {
    //   _sendingMsgProgressBar.hide();
    super.dispose();
  }

  void showSendingProgressBar() {
    _sendingMsgProgressBar.show(context);
  }

  void hideSendingProgressBar() {
    _sendingMsgProgressBar.hide();
  }

  Future getTSmaterials(tsid) async {
    // print("projectiddw$projectid");
    ///showSendingProgressBar();
    final String url = '/v1/gettripsheetdetail?tripsheetid=$tsid';
    //print("tpsurl$url");

    final http.Response res = await CallApi().getData(url);
    //  print("tpsapi$res");
    // ignore: always_specify_types
    final resdata = json.decode(res.body);
    // print("tps$resdata");
    setState(() {
      listdata = resdata;
    });
    //hideSendingProgressBar();
    //print('listdatacount$listdata');
  }

  double width, height;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget _tsmaterialBuilder(BuildContext context, int index) {
    // print('listdatacount');
    // print(listdata);
    tsdetails = [];
    int tsmid = listdata[index]['id'];
    int materialid = listdata[index]['materialid'];
    String qty = listdata[index]['qty'].toString();
    String price = listdata[index]['price'].toString();
    String material = listdata[index]['material'];
    // String tsdate = listdata[index]['tsdate'];
    var tsmaterials = {
      //   'tsmid': projectid,
      //   'projname': projectname,
      //   'equpnum': equpnum,
      //   'tsnum': tsnum,
      //   'tstime': tstime,
      //   'tsdate': tsdate,
    };
    // tsdetails.add(tsmaterials);
    return Padding(
        padding: EdgeInsets.symmetric(vertical: height * 1 / 100),
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: width * 1 / 100),
            child: Container(
              child: Row(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Text(
                      material,
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: height * 2.5 / 100,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
                  Row(children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10.0, left: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              'Qty: ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: height * 2.5 / 100),
                            ),
                          ),
                          Container(
                            child: Text(
                              qty,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * 2.5 / 100),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10.0, left: 10.0),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                'Price: ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: height * 2.5 / 100),
                              ),
                            ),
                            Container(
                              child: Text(
                                price,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: height * 2.5 / 100),
                              ),
                            ),
                          ]),
                    )
                  ])
                ]),
              ]),
            ),
          )
        ]));
  }

  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      floatingActionButton: Container(
        height: height * 4 / 100,
        child: FloatingActionButton.extended(
          backgroundColor: Color(0xff9E0202),
          onPressed: () {
            Navigator.pushNamed(context, '/tripsheetentry');
          },
          icon: Icon(Icons.edit),
          label: Text(
            'Edit Trip Sheet',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      appBar: MappBarinner(
        scaffoldKey: _scaffoldKey,
      ),
      // bottomNavigationBar: BottomNavigation(
      //   cIndex: 0,
      // ),
      body: Padding(
        padding: EdgeInsets.all(height * 2 / 100),
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(
                        'Trisp Sheet Number: ',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        widget.projectdetail[0]['tsnum'],
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ]),
                    SizedBox(height: 10),
                    Row(children: [
                      Container(
                          child: Text(
                        'Project: ',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )),
                      Container(
                          child: Text(
                        widget.projectdetail[0]['projname'],
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ))
                    ]),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Date & Time: ',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Text(
                          widget.projectdetail[0]['tsdate'] +
                              '  ' +
                              widget.projectdetail[0]['tstime'],
                          style: TextStyle(
                              color: Color(headercolor),
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ],
                    ),
                    Divider(
                        height: height * 2 / 100, color: Colors.transparent),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Materials Detail",
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: height * 3 / 100,
                                fontWeight: FontWeight.bold),
                          ),
                        ]),
                    Divider(
                        height: height * 1 / 100,
                        color: Colors.black,
                        thickness: 2),
                  ],
                ),
              ),
            ];
          },
          body: Container(
            child: ListView.separated(
              itemBuilder: _tsmaterialBuilder,
              itemCount: listdata.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) {
                return Divider(height: height * .2 / 100, color: Colors.blue);
              },
            ),
          ),
        ),
      ),
    );
  }
}
