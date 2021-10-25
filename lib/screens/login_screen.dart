import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:manjushree_constructions/service/constant.dart';
import 'package:manjushree_constructions/service/progressbar.dart';
import 'package:manjushree_constructions/widgets/textformfileld.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/api.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controller;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController usernameController =
      TextEditingController(text: 'supervisor');
  TextEditingController pwdController =
      TextEditingController(text: 'dadmin@#1721');
  //pwdController;
  double width, height;
  ProgressBar _sendingMsgProgressBar;
  String devicetoken = '';
  String name, password;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _sendingMsgProgressBar = ProgressBar();
  }

  @override
  void dispose() {
    _sendingMsgProgressBar.hide();
    super.dispose();
  }

  void showSendingProgressBar() {
    _sendingMsgProgressBar.show(context);
  }

  void hideSendingProgressBar() {
    _sendingMsgProgressBar.hide();
  }

  void _redirectPage(String s) {
    Navigator.pushNamed(context, s);
  }

  Future<void> makeLogin() async {
    final FormState form = _form.currentState;

    if (form.validate()) {
      showSendingProgressBar();
      final Map<String, String> data = {
        'name': usernameController.text,
        'password': pwdController.text
      };

      final http.Response res = await CallApi().postData(data, '/login');
      // ignore: always_specify_types
      final body = json.decode(res.body);
      print(body['success']);

      if (body['success'] == true) {
        print(body);
        hideSendingProgressBar();
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', body['access_token']);
        final userid =
            (body['user_dt']['id'] == null) ? 0 : body['user_dt']['id'];
        final name =
            (body['user_dt']['name'] == null) ? '' : body['user_dt']['name'];
        final userrole = (body['user_dt']['user_role'] == null)
            ? 3
            : body['user_dt']['user_role'];
        prefs.setInt('user_id', userid);
        prefs.setString('user_name', name);
        prefs.setInt('user_role', userrole);
        Navigator.pushNamed(context, '/dashboard');
      } else {
        hideSendingProgressBar();
        // print("Message$body");
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(body['message']),
          ),
        );
      }
    } else {
      print("Not Valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    // final double font = width / 20;
    // final double buttonwidthsize = width / 2;
    // final double buttonheightsize = width / 7.5;
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: const Text(
                  'Confirm Exit',
                  style: TextStyle(color: Colors.black),
                ),
                content: const Text(
                  'Are you sure you want to exit?',
                  style: TextStyle(color: Colors.black),
                ),
                actions: <Widget>[
                  FlatButton(
                    color: Colors.red,
                    child: const Text('YES'),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                  ),
                  FlatButton(
                    color: Colors.green,
                    child: const Text('NO'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      },
      child: Scaffold(
        backgroundColor: const Color(kpagebackground),
        key: _scaffoldKey,
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/manjushreebgfull.jpg'),
                fit: BoxFit.fill),
          ),
          child: SingleChildScrollView(
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: height * 15 / 100,
                          left: width * 7 / 100,
                          right: width * 7 / 100),
                      child: Image(
                        height: height * 15 / 100,
                        image: const AssetImage('images/manjushree.png'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: width * 15 / 100,
                          left: width * 7 / 100,
                          right: width * 7 / 100),
                      child: TextFormWidget(
                        icon: Icons.email_outlined,
                        placeholder: 'Username',
                        texttype: false,
                        valController: usernameController,
                        validator: (String name) {
                          if (name.isEmpty) {
                            return 'User Name is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: width * 4 / 100,
                          left: width * 7 / 100,
                          right: width * 7 / 100),
                      child: TextFormWidget(
                        icon: Icons.vpn_key,
                        placeholder: 'Password',
                        texttype: true,
                        valController: pwdController,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 7 / 100, right: width * 7 / 100),
                      child: Container(
                        margin: EdgeInsets.only(
                          top: height * 4 / 100,
                        ),
                        child: InkWell(
                          child: Container(
                            width: width * 85 / 100,
                            decoration: const BoxDecoration(
                              color: Color(maincolor),
                              shape: BoxShape.rectangle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(
                                child: Text('LOGIN',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: width * 4 / 100)),
                              ),
                            ),
                          ),
                          onTap: () {
                            //Navigator.pushNamed(context, '/dashboard');
                            makeLogin();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
