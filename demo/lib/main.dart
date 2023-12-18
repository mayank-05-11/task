import 'package:demo/Screens/Home%20Screen/home_screen.dart';
import 'package:demo/Screens/Login%20Screen/login.dart';
import 'package:demo/Screens/Registration%20Screen/registraton%20screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // Dismiss keyboard in whole app after tap on screen
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: RegistrationScreen(),
      ),
    );
  }
}
