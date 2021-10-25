import 'package:flutter/material.dart';
import 'package:manjushree_constructions/service/constant.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    Key key,
    @required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height*8/100,
      color: const Color(maincolor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('SAVE',style: TextStyle(fontWeight:FontWeight.bold),),
        ],
      ),
    );
  }
}
