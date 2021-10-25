import 'package:flutter/material.dart';

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
    print('arr exists');
    print(widget.listdata[0]['projname']);
    String equpnum = widget.listdata[0]['equpnum'];
    String tsnum = widget.listdata[0]['tsnum'];
    String tsdate = widget.listdata[0]['tsdate'];
    String tstime = widget.listdata[0]['tstime'];
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.height * 1 / 100),
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                // Center(
                //   child: Padding(
                //     padding: EdgeInsets.only(right: widget.width * 10 / 100),
                //     child: RotatedBox(
                //       quarterTurns: 1,
                //       child: Container(
                //         decoration: BoxDecoration(
                //             color: Colors.green,
                //             borderRadius: BorderRadius.all(
                //               Radius.circular(widget.width * 0.5 / 100),
                //             )),
                //         child: Padding(
                //           padding: EdgeInsets.all(widget.width * 1.5 / 100),
                //           child: RichText(
                //             text: TextSpan(
                //               text: 'VERIFIED',
                //               style: const TextStyle(
                //                   color: Colors.white,
                //                   fontWeight: FontWeight.bold),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      tsdate + '  ' + tstime,
                      style: const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: widget.height * 1.2 / 100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Trip Sheet No.: ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: widget.height * 2.5 / 100),
                          ),
                          Text(
                            tsnum,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: widget.height * 1.2 / 100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Equipment No.: ',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            equpnum,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            // Container(
            //   child: Padding(
            //     padding: EdgeInsets.only(top: widget.height * 1.2 / 100),
            //     child: ListView.builder(
            //       scrollDirection: Axis.vertical,
            //       shrinkWrap: true,
            //       physics: const BouncingScrollPhysics(),
            //       itemCount: 2,
            //       itemBuilder: (BuildContext context, int index) {
            //         return Container(
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceAround,
            //             children: [
            //               Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text(
            //                     'Material Name',
            //                     style: TextStyle(
            //                         color: Colors.black,
            //                         fontSize: widget.width * 3.3 / 100,
            //                         fontWeight: FontWeight.bold),
            //                   ),
            //                   Text(
            //                     'Quantity 125',
            //                     style: TextStyle(
            //                       fontSize: widget.width * 2.6 / 100,
            //                       color: Colors.black,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               const Text(
            //                 '1250.000',
            //                 style: const TextStyle(
            //                   color: Colors.black,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            // ),
            // Container(
            //       margin: EdgeInsets.only(top: widget.width * 2 / 100),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //         children: [
            //           Icon(
            //             Icons.photo_album,
            //             size: widget.width * 18 / 100,
            //           ),
            //           Icon(
            //             Icons.photo_album,
            //             size: widget.width * 18 / 100,
            //           ),
            //           Icon(
            //             Icons.photo_album,
            //             size: widget.width * 18 / 100,
            //           ),
            //         ],
            //       ),
            //     )
          ],
        ),
      ),
    );
  }
}
