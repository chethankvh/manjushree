import 'package:flutter/material.dart';
import 'package:manjushree_constructions/screens/fuelentry.dart';
import 'package:manjushree_constructions/screens/odometerentry.dart';
import 'package:manjushree_constructions/service/constant.dart';
import 'package:manjushree_constructions/widgets/appbar.dart';
import 'package:manjushree_constructions/widgets/bottomnavigator.dart';
import 'package:manjushree_constructions/widgets/savebutton.dart';

class VehicleEntry extends StatefulWidget {
  const VehicleEntry({key}) : super(key: key);

  @override
  _VehicleEntryState createState() => _VehicleEntryState();
}

class _VehicleEntryState extends State<VehicleEntry>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  double width, height;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
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
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: MappBar(
        scaffoldKey: _scaffoldKey,
      ),
      bottomNavigationBar: SaveButton(height: height),
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
                      'PROJECT ONE',
                      style: TextStyle(color: Colors.black),
                    ),
                    Divider(
                      color: Colors.black,
                      height: 10,
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                          const Tab(
                            text: 'ODO Meter',
                          ),

                          // second tab [you can add an icon using the icon property]
                          const Tab(
                            text: 'Fuel Entry',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(controller: _tabController, children: [
            const ODOMeterEntry(),

            // second tab bar view widget
            const FuelEntry(),
          ]),
        ),
      ),
    );
  }
}
