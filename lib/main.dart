import 'package:barber_booking_management/Login/screen/splash_screen.dart';
import 'package:barber_booking_management/utils/app_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(AppColor.whiteColor))),
          appBarTheme: const AppBarTheme(
            color: AppColor.whiteColor,
            elevation: 0.0,
            centerTitle: true,
            titleTextStyle:  TextStyle(
              color: AppColor.appColor,
              fontSize: 16,
            ),
            iconTheme:  IconThemeData(
              color: AppColor.blackColor,
            ),
          ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColor.appColor),
        ),
      home: SplashScreen()
    );
  }
}

