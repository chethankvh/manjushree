import 'package:flutter/material.dart';
import 'package:manjushree_constructions/service/constant.dart';
import 'package:manjushree_constructions/widgets/appbar.dart';
import 'package:manjushree_constructions/widgets/bottomnavigator.dart';
import 'package:manjushree_constructions/widgets/projectdet.dart';
import 'package:manjushree_constructions/service/progressbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:manjushree_constructions/widgets/projectlist.dart';
import '../Service/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Projects extends StatefulWidget {
  const Projects({ Key key}) : super(key: key);

  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  double width, height;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List projects = [];
  int projectscount = 0;
  List resultdetails;
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
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: MappBar(
          scaffoldKey: _scaffoldKey,
        ),
        bottomNavigationBar: BottomNavigation(
          cIndex: 1,
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: height * 0.5 / 100,
                    right: height * 0.5 / 100,
                    top: height * 0.5 / 100,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(tabinactive),
                    ),
                    child: Center(
                        // child: TabBar(
                        //   isScrollable: true,
                        //   controller: _tabController,
                        //   // give the indicator a decoration (color and border radius)
                        //   indicator: const BoxDecoration(
                        //     color: Color(tabactive),
                        //   ),
                        //   labelColor: Colors.black,
                        //   unselectedLabelColor: Colors.black,

                        //   tabs: [
                        //     // first tab [you can add an icon using the icon property]
                        //     const Tab(
                        //       text: 'Ongoing',
                        //     ),

                        //     // second tab [you can add an icon using the icon property]
                        //     const Tab(
                        //       text: 'Completed',
                        //     ),
                        //   ],
                        // ),
                        ),
                  ),
                ),
              ),
            ];
          },
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
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: 2,
                      itemBuilder: _onGoingList,
                    ),
                  )),
                ]),
          ),
        ));
  }

  Widget _onGoingList(BuildContext context, int position) {
    final String name = projects[position]['projectname'];
    int id = projects[position]['id'];
    return Padding(
        padding: EdgeInsets.symmetric(vertical: width * 1 / 100),
        child: Container(
            color: Colors.blueGrey,
            child: Column(children: [
              ExpansionTile(
                  title: Container(
                    child: Text(
                      name,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  children: [
                    ProjectDetails(width: width, prjid: id, prjname: name),
                  ]),
            ])));
  }
}
