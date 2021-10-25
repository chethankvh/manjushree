import 'package:flutter/material.dart';
import 'package:manjushree_constructions/widgets/dropdownbox.dart';

class FuelEntry extends StatefulWidget {
  const FuelEntry({key}) : super(key: key);

  @override
  _FuelEntryState createState() => _FuelEntryState();
}

class _FuelEntryState extends State<FuelEntry> {
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
    return Column(
      children: [
        Container(
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
                padding: EdgeInsets.symmetric(vertical: height * 1 / 100),
                child: DropdownBox(
                  list: _locations,
                  value: _supplier,
                  placeholder: 'Vehicle Type',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * 1 / 100),
                child: DropdownBox(
                  list: _locations,
                  value: _supplier,
                  placeholder: 'Vehicle',
                ),
              ),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(
                        width * 4 / 100, width * 4 / 100, width * 4 / 100, 0),
                    hintText: 'Amount',
                    labelText: 'Amount',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
