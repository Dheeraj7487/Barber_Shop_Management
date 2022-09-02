import 'package:barber_booking_management/Inbox/inbox_screen.dart';
import 'package:barber_booking_management/Profile/profile_screen.dart';
import 'package:barber_booking_management/utils/app_image.dart';
import 'package:flutter/material.dart';

import '../Appointment/appoinment_screen.dart';
import '../Home/home_screen.dart';
import '../NearBy/near_by_screen.dart';
import '../utils/app_color.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {

  int _selectedIndex=0;
  String imageUrl="https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg";
  List<Widget> buildScreen(){
    return [
      const HomeScreen(),
      const NearbyScreen(),
      const AppointmentScreen(),
      const InboxScreen(),
      const ProfileScreen()
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: buildScreen().elementAt(_selectedIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        backgroundColor: AppColor.whiteColor,
        selectedLabelStyle: const TextStyle(color: AppColor.appColor),
        unselectedLabelStyle: const TextStyle(color: AppColor.blackColor,),
        selectedItemColor: AppColor.appColor,
        unselectedItemColor: AppColor.appColor,
        onTap: _onItemTapped,
        items:  [
          const BottomNavigationBarItem(
              label: "Home",
              icon:  Icon(Icons.home_outlined,size: 26,)
          ),
          BottomNavigationBarItem(
              label: "Near By",
              icon: Image.asset(AppImage.nearBy,height: 24,width: 25,)
          ),
          BottomNavigationBarItem(
              label: "Appointment",
              icon: Image.asset(AppImage.appointment,height: 24,width: 25,)
          ),
          BottomNavigationBarItem(
              label: "Inbox",
              icon: Image.asset(AppImage.inbox,height: 24,width: 25,)
          ),
          const BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(Icons.person_outline,size: 26,
              )),
        ],
      ),
    );
  }
}

