import 'package:flutter/material.dart';

class TextFormWidget extends StatelessWidget {
  TextFormWidget(
      {Key key,
      @required this.placeholder,
      this.icon,
      this.validator,
      this.valController,
      this.texttype,
      this.onChange,
      this.iconprefix,
      this.maxline,
      this.keytype})
      : super(key: key);
  String placeholder;
  IconData icon;
  final bool texttype;
  final Function validator, onChange;
  final TextEditingController valController;
  final int maxline;
  final IconData iconprefix;
  final TextInputType keytype;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    TextInputType keyboardtype = TextInputType.text;
    if (keytype != null) {
      keyboardtype = keytype;
    }
   // print(texttype);
    return TextFormField(
      obscureText: texttype,
      controller: valController,
      keyboardType: keyboardtype,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        focusColor: Colors.black,
        prefixIcon: Icon(icon),
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(
            width * 4 / 100, width * 4 / 100, width * 4 / 100, 0),
        labelText: placeholder,
        filled: true,
        fillColor: Color(0xffE6E6E6),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blueGrey,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Your password';
        }
        return null;
      },
    );
  }
}
