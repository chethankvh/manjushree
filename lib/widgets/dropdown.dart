import 'package:flutter/material.dart';

class DropDownDesign extends StatelessWidget {
  DropDownDesign(
      {Key key,
      @required this.width,
      @required this.textfieldmargin,
      this.valueArray,
      @required this.fieldValue,
      @required this.onChange,
      @required this.placeholder,
      this.validator,
      this.singledrop,
      this.datalist})
      : super(key: key);

  final double width;
  final double textfieldmargin;
  final List<Map> valueArray;
  final String placeholder;
  final Function onChange;
  final String fieldValue;
  final String singledrop;
  final Function validator;
  final datalist;
  @override
  Widget build(BuildContext context) {
    final double font = width / 20;
    var finalwidth = (singledrop == false) ? width : width / 2;
    return DropdownButtonFormField<String>(
      isExpanded: true,
      icon: Icon(Icons.keyboard_arrow_down),
      iconSize: font,
      style: TextStyle(
          color: Colors.black, fontSize: font / 1.5, fontFamily: 'Opensans'),
      validator: validator,
      hint: Text(
        placeholder,
        style: TextStyle(
            color: Colors.black, fontSize: font / 1.5, fontFamily: 'Opensans'),
      ),
      value: fieldValue,
      onChanged: onChange,
      items: datalist.toList(),
    );
  }
}
