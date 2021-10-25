import 'package:flutter/material.dart';
import 'package:manjushree_constructions/service/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MappBarinner extends StatefulWidget implements PreferredSizeWidget {
  const MappBarinner({
    key,
    @required GlobalKey<ScaffoldState> scaffoldKey,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        _scaffoldKey = scaffoldKey,
        super(key: key);

  @override
  _MappBarState createState() => _MappBarState();
  @override
  final Size preferredSize;
  final GlobalKey<ScaffoldState> _scaffoldKey;
}

class _MappBarState extends State<MappBarinner> {
  double width, height;
  void logoutUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    print(preferences);
    print('preferences');
    Navigator.pushNamed(context, '/login');
  }

  Future<void> confirmationDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            backgroundColor: Colors.white,
            title: const Text(
              'LOGOUT',
              style: TextStyle(color: Colors.black),
            ),
            content: Wrap(
              children: [
                Center(
                  child: Column(
                    children: [
                      const Text(
                        'Are You Sure??',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: const Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: const Text('CONFIRM'),
                onPressed: () async {
                  logoutUser();
                  // onDelete(type);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
      child: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: const Color(maincolor),
        titleSpacing: 0,
        title: Text(
          'Trip Sheet Materials',
          style: TextStyle(fontSize: width * 5 / 100),
        ),
        centerTitle: true,
        actions: [IconButton(icon: Icon(Icons.info), onPressed: () {})],
      ),
    );
  }
}
