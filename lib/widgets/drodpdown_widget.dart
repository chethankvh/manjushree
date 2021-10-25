import 'package:flutter/material.dart';
import '../service/constant.dart';
import 'dropdown.dart';

class DropDownButton extends StatelessWidget {
  DropDownButton(
      {Key key,
      @required this.width,
      @required this.textfieldmargin,
      this.valueArray,
      @required this.fieldValue,
      @required this.onChange,
      @required this.placeholder,
      this.datalist,
      this.validator,
      @required this.labeltext})
      : super(key: key);

  final double width;
  final double textfieldmargin;
  final List<Map> valueArray;
  final String placeholder;
  final Function onChange;
  final String fieldValue;
  final String labeltext;
  final Function validator;
  final datalist;
  @override
  Widget build(BuildContext context) {
    final double font = width / 20;
    return Container(
      width: width,
      // height: width * 14 / 100,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 1,
          )),
      margin: EdgeInsets.only(
          left: textfieldmargin / 10,
          right: textfieldmargin / 10,
          top: textfieldmargin / 35,
          bottom: textfieldmargin / 35),
      child: Padding(
        padding: EdgeInsets.only(
            top: textfieldmargin / 35,
            bottom: textfieldmargin / 35,
            left: textfieldmargin / 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                labeltext,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: font / 2.3,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Opensans'),
              ),
            ),
            SizedBox(height: width * 1 / 100),
            DropDownDesign(
              width: width,
              textfieldmargin: textfieldmargin,
              valueArray: valueArray,
              fieldValue: fieldValue,
              placeholder: placeholder,
              onChange: onChange,
              datalist: datalist.toList(),
              validator: validator,
            ),
          ],
        ),
      ),
    );
  }
}
