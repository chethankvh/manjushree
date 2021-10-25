import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:manjushree_constructions/screens/tripsheetadd.dart';
import 'package:manjushree_constructions/screens/tripview.dart';
import '../Service/api.dart';
import 'package:http/http.dart' as http;
import '../Service/progressbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProjectDetails extends StatefulWidget {
  //const DashboardPage({key}) : super(key: key);
  ProjectDetails({Key key, @required this.width, this.prjid, this.prjname})
      : super(key: key);
  final double width;
  final int prjid;
  final String prjname;
  @override
  _ProjectDetailsState createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TripView(
                          projectid: widget.prjid, proj: widget.prjname)),
                );
              },
              child: buildColumn('images/truck.png', 'TRIP SHEET')),
          buildContainer(),
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/materialexpense');
              },
              child: buildColumn('images/material.png', 'MATERIAL EXPENSE')),
          buildContainer(),
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/labourentry');
              },
              child: buildColumn('images/labour.png', 'LABOUR')),
        ],
      ),
    );
  }

  Container buildContainer() => Container(
      height: widget.width * 20 / 100,
      child: const VerticalDivider(color: Colors.grey));

  Padding buildColumn(image, heading) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.width * 2 / 100),
      child: Column(
        children: [
          Image.asset(
            image,
            height: widget.width * 10 / 100,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: widget.width * 2 / 100),
            child: Text(
              heading,
              style: TextStyle(
                  color: Colors.black, fontSize: widget.width * 2.8 / 100),
            ),
          ),
        ],
      ),
    );
  }
}
