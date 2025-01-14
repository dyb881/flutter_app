import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_app/stores/stores.dart';
import 'package:flutter_app/pages/home/home_page.dart';
import 'package:flutter_app/pages/user/user_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter APP',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialBinding: StoresBinding(),
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/user': (context) => UserPage(),
        });
  }
}
