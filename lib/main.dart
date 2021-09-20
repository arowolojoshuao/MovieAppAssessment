import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uba_movieapp/global/routes.dart';
import 'package:uba_movieapp/global/uidata.dart';
import 'package:uba_movieapp/screens/login_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'blocs/social_auth/login_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginProvider(
      child:MaterialApp(
        title: UiData.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          brightness: Brightness.dark,
          fontFamily: 'OpenSans',
        ),
        home:  LoginScreen(),
        routes: routes,
      ),
    );
  }

}



class Load {
  static void show(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        useRootNavigator: false,
        builder: (BuildContext context) => Center(
          child: Container(
            width: 60.0,
            height: 60.0,
            child: Center(
              child: SpinKitFadingCircle(color: Colors.amber),
            ),
          ),
        ));
  }

  static void dismiss(BuildContext context) {
    // Navigator.of(context, rootNavigator: true).pop();
    Navigator.pop(context, true);
  }


  static Widget LoadingWidget({double width, double height, Color color}) {
    return Container(
      width: width,
      height: height,
      decoration:
      BoxDecoration(color: color, borderRadius: BorderRadius.circular(4.0)),
      child: Center(
        child: SpinKitFadingCircle(color: Colors.amber),
      ),
    );
  }

  static Widget onlySpinKitFadingCircle({double width, double height}) {
    return Center(
      child: SpinKitFadingCircle(color: Colors.amber),
    );
  }

}