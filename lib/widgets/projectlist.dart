import 'package:flutter/material.dart';
import 'package:manjushree_constructions/screens/tripsheetadd.dart';
import 'package:manjushree_constructions/widgets/projectdet.dart';

class ProjectList extends StatelessWidget {
  ProjectList({Key key, @required this.width, this.projectname, this.projid})
      : super(key: key);
  final int projid;
  final double width;
  final String projectname;

  @override
  Widget build(BuildContext context) {
    String projname = '';
    // print("Printdata$projectname");
    if (projectname != null) {
      projname = projectname;
    } else {
      projname = '';
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.keyboard_arrow_right,
              color: Colors.red,
            ),
            Text(
              projname,
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        ProjectDetails(width: width, prjid: projid, prjname: projname),
        Divider(
          color: Colors.black,
          height: 10,
        ),
      ],
    );
  }

  Container buildContainer() => Container(
      height: width * 20 / 100,
      child: const VerticalDivider(color: Colors.grey));

  Padding buildColumn(image, heading) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: width * 2 / 100),
      child: Column(
        children: [
          Image.asset(
            image,
            height: width * 10 / 100,
          ),
          Padding(
            padding: EdgeInsets.only(top: width * 2 / 100),
            child: Text(
              heading,
              style:
                  TextStyle(color: Colors.black, fontSize: width * 2.8 / 100),
            ),
          ),
        ],
      ),
    );
  }
}
