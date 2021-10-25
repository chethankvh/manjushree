import 'package:flutter/material.dart';
import '../widgets/button.dart';
import '../service/constant.dart';
import '../widgets/materials.dart';
import '../widgets/tsphotos.dart';

class TripViewDetails extends StatefulWidget {
  TripViewDetails({
    Key key,
    @required this.height,
    @required this.width,
    this.listdata,
  }) : super(key: key);

  final double height;
  final double width;
  final List<dynamic> listdata;

  @override
  _TripViewDetail createState() => _TripViewDetail();
}

class _TripViewDetail extends State<TripViewDetails> {
  @override
  Widget build(BuildContext context) {
    // print('arr exists');
    //  print(widget.listdata);

    String equpnum = widget.listdata[0]['equpnum'];
    String tsnum = widget.listdata[0]['tsnum'];
    String tsdate = widget.listdata[0]['tsdate'];
    String tstime = widget.listdata[0]['tstime'];
    int tsid = widget.listdata[0]['tsid'];
    String project = widget.listdata[0]['projname'];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(
                        tsdate + '  ' + tstime,
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ]),
                    Row(
                      children: [
                        Text(
                          'Trip Sheet No.: ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: widget.height * 2.5 / 100),
                        ),
                        Text(
                          tsnum,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: widget.height * 2.5 / 100),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Equipment No.: ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: widget.height * 2.5 / 100),
                        ),
                        Text(
                          equpnum,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: widget.height * 2.5 / 100),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin:
                              const EdgeInsets.only(right: 10.0, left: 10.0),
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Materials(
                                        tripsheetid: tsid,
                                        projectdetail: widget.listdata)),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 1 / 100),
                              child: Text(
                                "Materials",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: const Color(headercolor),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              const EdgeInsets.only(right: 10.0, left: 10.0),
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TSphotos(
                                        tripsheetid: tsid,
                                        projectdetail: widget.listdata)),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.5 / 100),
                              child: Text(
                                "Photos",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: const Color(appbar1),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
      ]
    );
  }
}
