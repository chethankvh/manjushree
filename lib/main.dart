import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manjushree_constructions/screens/dashboard_screen.dart';
import 'package:manjushree_constructions/screens/login_screen.dart';
import 'package:manjushree_constructions/screens/splash_screen.dart';
import 'package:manjushree_constructions/screens/vehicles.dart';
import 'package:manjushree_constructions/screens/projects_screen.dart';
import 'package:manjushree_constructions/screens/tripsheetadd.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  @override
  StreamSubscription<ConnectivityResult> subscription;

  ConnectivityResult internetresult;
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    //checkCrashlytics();
    checkStatus();

    // implement initState
    super.initState();

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() {
        internetresult = result;
      });
    });
  }

  checkStatus() async {
    internetresult = await Connectivity().checkConnectivity();
   
  }

  // Be sure to cancel subscription after you are done
  @override
  void dispose() {
    super.dispose();

    subscription.cancel();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final double _screenWidth = WidgetsBinding.instance.window.physicalSize.width;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    switch (internetresult) {
      case ConnectivityResult.none:
        return Container(
          color: Colors.white,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('images/no-internet.png'),
                Text(
                  'Please check your internet connection',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: _screenWidth / 30,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );

        break;
      case ConnectivityResult.mobile:
        return buildMaterialApp();
        break;
      case ConnectivityResult.wifi:
        return buildMaterialApp();
        break;
      default:
        return buildMaterialApp();
        break;
    }
  }

  MaterialApp buildMaterialApp() {
    return MaterialApp(
      title: 'Manjushree Construction',
      builder: (BuildContext ctx, Widget child) {
        final double width = MediaQuery.of(ctx).size.width;
        return Theme(
            data: ThemeData.light().copyWith(
              visualDensity: VisualDensity.adaptivePlatformDensity,
              errorColor: Colors.red,
              textTheme: TextTheme(
                headline1: TextStyle(
                    fontSize: width * 10 / 100, fontFamily: 'NotoSansJP-Light'),
                headline2: TextStyle(
                    fontSize: width * 8 / 100, fontFamily: 'NotoSansJP-Light'),
                headline3: TextStyle(
                    fontSize: width * 7 / 100, fontFamily: 'NotoSansJP-Light'),
                bodyText1: TextStyle(
                    fontSize: width * 3.2 / 100,
                    fontFamily: 'NotoSansJP-Light'),
                bodyText2: TextStyle(
                    fontSize: width * 4 / 100, fontFamily: 'NotoSansJP-Light'),
                subtitle1: TextStyle(
                    fontSize: width * 5 / 100, fontFamily: 'NotoSansJP-Light'),
                subtitle2: TextStyle(
                    fontSize: width * 4 / 100, fontFamily: 'NotoSansJP-Light'),
              ),
            ),
            child: child);
      },
      home: SplashScreen(),
      initialRoute: '/',
      routes: {
        '/login': (BuildContext context) => LoginPage(),
        '/dashboard': (BuildContext context) => DashboardPage(),
        '/vehicles': (BuildContext context) => Vehicles(),
        '/projects': (BuildContext context) => Projects(),
        '/tripsheetentry': (BuildContext context) => TripSheetPage(),
      },
    );
  }
}
