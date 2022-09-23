import 'package:barber_booking_management/Addshop/provider/add_shop_provider.dart';
import 'package:barber_booking_management/Login/provider/loading_provider.dart';
import 'package:barber_booking_management/Login/provider/login_provider.dart';
import 'package:barber_booking_management/Login/screen/splash_screen.dart';
import 'package:barber_booking_management/utils/app_color.dart';
import 'package:barber_booking_management/widget/loading_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'Category/provider/appointment_provider.dart';

var uuid = Uuid();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
          ChangeNotifierProvider<AddShopProvider>(create: (_) => AddShopProvider()),
          ChangeNotifierProvider<AppointmentProvider>(create: (_) => AppointmentProvider()),
          ChangeNotifierProvider<LoadingProvider>(create: (_) => LoadingProvider()),
        ],
      child: MaterialApp(
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
              ),
              iconTheme:  IconThemeData(
                color: AppColor.appColor,
              ),
            ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColor.appColor),
          ),
          home: const SplashScreen(),
        builder: (context, child) {
          return Loading(child: child!);
        },
      ),
    );
  }
}

