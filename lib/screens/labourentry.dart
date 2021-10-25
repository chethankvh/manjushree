import 'package:flutter/material.dart';
import 'package:manjushree_constructions/service/constant.dart';
import 'package:manjushree_constructions/widgets/appbar.dart';
import 'package:manjushree_constructions/widgets/dropdownbox.dart';

class LabourEntry extends StatefulWidget {
  const LabourEntry({key}) : super(key: key);

  @override
  _LabourEntryState createState() => _LabourEntryState();
}

class _LabourEntryState extends State<LabourEntry> {
  double width, height;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> _locations = ['A', 'B', 'C', 'D']; // Option 2
  String _supplier, material, quantity;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    final textStyle =
        TextStyle(color: Colors.black, fontSize: height * 2.5 / 100);
    final textStyle2 = TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: height * 2.2 / 100);
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: MappBar(
        scaffoldKey: _scaffoldKey,
      ),
      bottomNavigationBar: Container(
        height: height * 8 / 100,
        color: const Color(maincolor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'SAVE',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 2 / 100),
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
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Date: ',
                            style: textStyle,
                          ),
                          Text(
                            '21-04-2021',
                            style: textStyle2,
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: height * 1 / 100),
                        child: DropdownBox(
                          list: _locations,
                          value: _supplier,
                          placeholder: 'Labour Type',
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: height * 1 / 100),
                        child: Container(
                        
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              isDense: true,
                              contentPadding: EdgeInsets.fromLTRB(
                                  width * 4 / 100,
                                  width * 4 / 100,
                                  width * 4 / 100,
                                  0),
                              hintText: 'Quantity',
                              labelText: 'Quantity',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: height * 1 / 100),
                        child: Container(
                        
                          child: TextFormField(
                            maxLines: 3,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              isDense: true,
                              contentPadding: EdgeInsets.fromLTRB(
                                  width * 4 / 100,
                                  width * 4 / 100,
                                  width * 4 / 100,
                                  0),
                              hintText: 'Note',
                              labelText: 'Note',
                            ),
                          ),
                        ),
                      ),
                      RaisedButton(
                        child: Text('Add'),
                        onPressed: () {
                          // addItemToList();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'MATERIAL NAME',
                      style: TextStyle(
                          color: Colors.black, fontSize: width * 4 / 100),
                    ),
                    Text(
                      '125',
                      style: TextStyle(
                          color: Colors.black, fontSize: width * 3 / 100),
                    )
                  ],
                ),
                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.black)),

                trailing: const Icon(Icons.delete, color: Colors.red, size: 20),
                onTap: () {},
              );
              ;
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(height: height * .2 / 100, color: Colors.black);
            },
          ),
        ),
      ),
    );
  }
}
