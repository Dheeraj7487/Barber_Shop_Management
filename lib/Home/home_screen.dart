import 'package:barber_booking_management/Home/widget/best_salon_service_widget.dart';
import 'package:barber_booking_management/Home/widget/choose_barber_widget.dart';
import 'package:barber_booking_management/Home/widget/popular_category_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Login/screen/login_screen.dart';
import '../utils/app_color.dart';
import '../utils/app_utils.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: IconButton(onPressed: (){
          FirebaseAuth.instance.signOut();
          AppUtils.instance.clearPref().then((value) => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => LoginScreen())));

        }, icon: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            ChooseBarberWidget(),
            BestSalonServiceWidget(),
            PopularCategoryWidget()
          ],
        ),
      ),
    );
  }
}
