import 'package:flutter/material.dart';
import 'package:manjushree_constructions/screens/tripdetails.dart';
import 'package:manjushree_constructions/screens/tripmedia.dart';
import 'package:manjushree_constructions/service/constant.dart';
import 'package:manjushree_constructions/widgets/appbar.dart';
import 'package:manjushree_constructions/widgets/bottomnavigator.dart';

class TripSheetPage extends StatefulWidget {
  TripSheetPage({
    Key key,
     this.projectname,
     this.projectid,
  }) : super(key: key);

  final String projectname;
  final int projectid;

  @override
  _TripSheetPageState createState() => _TripSheetPageState();
}

class _TripSheetPageState extends State<TripSheetPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  double width, height;
  String pjname;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    pjname = widget.projectname;
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    //print(widget.projectname);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      floatingActionButton: Container(
        height: height * 5 / 100,
        child: FloatingActionButton.extended(
          backgroundColor: Colors.green,
          onPressed: () {},
          icon: Icon(Icons.save),
          label: Text(
            'Save',
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
        cIndex: 1,
      ),
      body: Padding(
        padding: EdgeInsets.all(height * 1 / 100),
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (pjname ?? "Project"),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      color: Colors.black,
                      height: 10,
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(tabinactive),
                  ),
                  child: TabBar(
                    isScrollable: true,
                    controller: _tabController,
                    // give the indicator a decoration (color and border radius)
                    indicator: const BoxDecoration(
                      color: Color(tabactive),
                    ),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black,

                    tabs: [
                      // first tab [you can add an icon using the icon property]
                      Container(
                        width: width * 40 / 100,
                        height: height * 5 / 100,
                        child: const Tab(
                          text: 'DETAILS',
                        ),
                      ),

                      // second tab [you can add an icon using the icon property]
                      Container(
                        width: width * 40 / 100,
                        height: height * 5 / 100,
                        child: const Tab(
                          text: 'MEDIA',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TabBarView(controller: _tabController, children: [
              const DetailsTabTripSheet(),

              // second tab bar view widget
              const MediaTabTripSheet(),
            ]),
          ),
        ),
      ),
    );
  }
}
