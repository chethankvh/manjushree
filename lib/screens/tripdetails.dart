import 'package:flutter/material.dart';
import 'package:manjushree_constructions/widgets/dropdownbox.dart';
import 'package:intl/intl.dart';
import '../Service/api.dart';
import 'package:http/http.dart' as http;
import '../Service/progressbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DetailsTabTripSheet extends StatefulWidget {
  const DetailsTabTripSheet({key}) : super(key: key);

  @override
  _DetailsTabTripSheetState createState() => _DetailsTabTripSheetState();
}

class _DetailsTabTripSheetState extends State<DetailsTabTripSheet> {
  double width, height;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> _locations = ['A', 'B', 'C', 'D']; // Option 2
  List _suppliers = [];
  String _supplier;
  List _materials = [];
  String _materialid;
  String _materialname;
  String _material;
  var parts;

  final List<String> mquantity = <String>[];
  final List<String> mprice = <String>[];
  final List<String> materialslist = <String>[];
  @override
  void initState() {
    super.initState();
    _loadSuppliers();
    _loadMaterials();
  }

  TextEditingController qtyController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  Future _loadSuppliers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');

    String url = '/v1/getsuppliers?api_token=$token';
    http.Response res = await CallApi().getData(url);
    // ignore: always_specify_types
    var jsonResponse = json.decode(res.body);
    // print('Repsonse');
    //print(jsonResponse);
    // update data and loading status
    if (jsonResponse == []) {
    } else {
      setState(() {
        _suppliers = jsonResponse;
      });
    }
  }

  Future _loadMaterials() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');

    String murl = '/v1/getmaterials?api_token=$token';
    http.Response mres = await CallApi().getData(murl);
    // ignore: always_specify_types
    var mats = json.decode(mres.body);
    // print('Repsonse');
    // print(mats);
    // update data and loading status
    if (mats == []) {
    } else {
      setState(() {
        _materials = mats;
      });
    }
  }

  void addItemToList() {
    setState(() {
      mquantity.insert(0, qtyController.text);
      mprice.insert(0, priceController.text);
      materialslist.insert(0, _materialname);
      qtyController = TextEditingController();
      priceController = TextEditingController();
      // msgCount.insert(0, 0);
    });
  }

  void deleteItemFromList(item, itemqty, itemprc) {
    print(mquantity);
    print(mprice);
    print(materialslist);
    setState(() {
      mquantity.remove(itemqty);
      mprice.remove(itemprc);
      materialslist.remove(item);
    });
    print(mquantity);
    print(mprice);
    print(materialslist);
  }

  Widget _materialsList(BuildContext context, int position) {
    // print("quantity");
    // print(mquantity);
    return GestureDetector(
        child: Card(
          // 1
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0), ),
          // 2
          color: Colors.grey[50],
          elevation: 0,
          child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
            ListTile(
              title: Text(
                '${materialslist[position]}',
                style:
                    TextStyle(color: Colors.black, fontSize: width * 4.5 / 100),
              ),
              // subtitle: Text("Intermediate", style: TextStyle(color: Colors.black)),

              subtitle: 
                  Text(
                    'Qty: ' + '${mquantity[position]} Price: ' + '${mprice[position]}',
                      style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
               
              trailing: FittedBox(
                fit: BoxFit.fill,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  // space between two icons
                  children: <Widget>[
                    new Container(
                      child: new IconButton(
                        icon:
                            new Icon(Icons.delete, color: Colors.red, size: 30),
                        onPressed: () {
                          deleteItemFromList(materialslist[position],
                              mquantity[position], mprice[position]);
                        },
                      ),
                      margin: EdgeInsets.only(top: 25.0),
                    )
                  ],
                ),
              ),
            
            )
          ]),
        ),

        // 3
        onTap: () {});
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    DateFormat dateFormat = DateFormat("dd-MM-yyy");
    DateFormat timeFormat = DateFormat("HH:mm");
    DateTime dateToday = new DateTime.now();
    String cdate = dateFormat.format(dateToday);
    String ctime = timeFormat.format(dateToday);

    final textStyle =
        TextStyle(color: Colors.black, fontSize: height * 2.5 / 100);
    final textStyle2 = TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: height * 2.2 / 100);

    return NestedScrollView(
      headerSliverBuilder: (context, value) {
        return [
          SliverToBoxAdapter(
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Date: ',
                            style: textStyle,
                          ),
                          Text(
                            cdate,
                            style: textStyle2,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Time: ',
                            style: textStyle,
                          ),
                          Text(
                            ctime,
                            style: textStyle2,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height * 2 / 100),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(width * 4 / 100,
                            width * 4 / 100, width * 4 / 100, 0),
                        border: OutlineInputBorder(),
                        hintText: 'Tripsheet No',
                        labelText: 'Tripsheet No',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 1 / 100),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(width * 4 / 100,
                            width * 4 / 100, width * 4 / 100, 0),
                        border: OutlineInputBorder(),
                        hintText: 'Equipment No',
                        labelText: 'Equipment No',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 1 / 100),
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownBox(
                          placeholder: "Select Supplier",
                          value: _supplier,
                          //isDense: true,
                          onChange: (String newValue) {
                            setState(() {
                              _supplier = newValue;
                            });
                            //print(_supplier);
                          },
                          list: _suppliers.map((map) {
                            return new DropdownMenuItem<String>(
                              value: map['id'].toString(),
                              child: new Text(map['suppliername'],
                                  style: new TextStyle(color: Colors.black)),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 1 / 100),
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownBox(
                          placeholder: "Select Material",
                          value: _material,
                          //isDense: true,
                          onChange: (String mValue) {
                            setState(() {
                              parts = mValue.split(':');
                              if (parts != null) {
                                print("psao$parts");

                                _materialid = parts[0].trim();
                                _materialname = parts[1].trim();
                                _material = _materialid + ":" + _materialname;
                              }
                            });

                            print(_material);
                            print(_materialname);
                          },
                          list: _materials.map((det) {
                            return new DropdownMenuItem<String>(
                              value:
                                  det['id'].toString() + ':' + det['material'],
                              child: new Text(det['material'],
                                  style: new TextStyle(color: Colors.black)),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 1 / 100),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      controller: qtyController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(width * 4 / 100,
                            width * 4 / 100, width * 4 / 100, 0),
                        border: OutlineInputBorder(),
                        hintText: 'Quantity',
                        labelText: 'Quantity',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 1 / 100),
                    child: Container(
                        child: Row(
                      children: [
                        Container(
                          width: width * 66 / 100,
                          child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            controller: priceController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              isDense: true,
                              contentPadding: EdgeInsets.fromLTRB(
                                  width * 4 / 100,
                                  width * 4 / 100,
                                  width * 4 / 100,
                                  0),
                              hintText: 'Price',
                              labelText: 'Price',
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: width * 2 / 100),
                          child: RaisedButton(
                            child: Text('Add'),
                            onPressed: () {
                              addItemToList();
                            },
                          ),
                        ),
                      ],
                    )),
                  ),
                ],
              ),
            ),
          ),
        ];
      },
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: materialslist.length,
        itemBuilder: _materialsList,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(height: height * .2 / 100, color: Colors.black);
        },
      ),
    );
  }
}
