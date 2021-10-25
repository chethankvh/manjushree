import 'package:flutter/material.dart';
import 'package:manjushree_constructions/service/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MappBar extends StatefulWidget implements PreferredSizeWidget {
  const MappBar({
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

class _MappBarState extends State<MappBar> {
  double width, height;
  void logoutUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    // print(preferences);
    // print('preferences');
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
        automaticallyImplyLeading: false,
        backgroundColor: const Color(maincolor),
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MANJUSHRI',
                style:
                    TextStyle(fontSize: width * 4 / 100, color: Colors.black),
              ),
              SizedBox(height: width * 0.5 / 100),
              Text(
                'CONSTRUCTION',
                style: TextStyle(fontSize: width * 4 / 100),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.pushNamed(context, '/restPassword');
              }),
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                confirmationDialog(context);
              }),
        ],
      ),
    );
  }
}
