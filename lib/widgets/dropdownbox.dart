import 'package:flutter/material.dart';

class DropdownBox extends StatelessWidget {
  DropdownBox({
    Key key,
    @required this.value,
    @required this.list,
    @required this.placeholder,
    @required this.onChange,
  }) : super(key: key);

  final String value;
  final list;
  String placeholder;
  double width, height;

  Function onChange;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 95 / 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(height * 1 / 100)),
        border: Border.all(
          color: Colors.black,
          width: 0.4,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: width * 0.5 / 100),
        child: DropdownButton<String>(
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(color: Colors.black, fontSize: width * 5 / 100),
          hint: Text(placeholder), // Not necessary for Option 1
          value: value,
          onChanged: (newValue) {
            onChange(newValue);
          },
          items: list,
        ),
      ),
    );
  }
}
