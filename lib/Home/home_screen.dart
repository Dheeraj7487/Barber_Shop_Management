import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Login/screen/login_screen.dart';
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

        }, icon: Icon(Icons.arrow_back)),
      ),
    );
  }
}
