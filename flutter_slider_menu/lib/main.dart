import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slider_menu/menu_dashboard.dart';

void main() {
  final Color backgroundColor = Color(0xFF343442);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: backgroundColor,
      //systemNavigationBarColor: Colors.yellow,
      statusBarBrightness: Brightness.light,
      //systemNavigationBarIconBrightness: Brightness.dark,
      ));

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Menu Dashboard',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MenuDashboard(),
    );
  }
}
