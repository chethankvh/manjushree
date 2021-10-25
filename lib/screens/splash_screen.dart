import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      checkLogin;
    });
  }

  get checkLogin async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    var user_id = preferences.getInt('user_id').toString();
    print('user_id$user_id');
    if (user_id.isNotEmpty && user_id != null && user_id != 'null') {
      setState(() {
        //print('inside');
        Navigator.pushNamed(context, '/dashboard');
      });
    } else {
      Navigator.pushNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
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
            child: Padding(
              padding: EdgeInsets.only(top:height*25/100, left: width * 7 / 100, right: width * 7 / 100),
              child: Image(
              
                image: const AssetImage('images/manjushree.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
