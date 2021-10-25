import 'package:flutter/material.dart';
import '../Service/constant.dart';

class Button extends StatelessWidget {
  Button({
    Key key,
    @required this.buttontext,
    @required this.onPress,
  }) : super(key: key);
  String buttontext;
  Function onPress;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
//    final double height = MediaQuery.of(context).size.height;

    return Material(
      elevation: 5.0,
      color: const Color(logibt),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(
            horizontal: width * 8 / 100, vertical: width * 2 / 100),
        onPressed: () {
          onPress();
        },
        child: Text(
          buttontext,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
