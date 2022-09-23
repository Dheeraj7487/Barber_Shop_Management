import 'package:barber_booking_management/Profile/profile_screen.dart';
import 'package:barber_booking_management/utils/app_image.dart';
import 'package:flutter/material.dart';
import '../Category/category_screen.dart';
import '../Chat/chat_screen.dart';
import '../Chat/chat_user.dart';
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
  List<Widget> buildScreen(){
    return [
      const HomeScreen(),
      const NearbyScreen(),
      const CategoryScreen(),
      const ChatUserScreen(),
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
        backgroundColor: Colors.transparent,
        selectedFontSize: 12,
        selectedLabelStyle: const TextStyle(color: AppColor.appColor),
        unselectedLabelStyle: const TextStyle(color: AppColor.blackColor,),
        selectedItemColor: AppColor.appColor,
        unselectedItemColor: AppColor.appColor,
        onTap: _onItemTapped,
        items:  [
          BottomNavigationBarItem(
              label: "Home",
              icon:  Image.asset(AppImage.home,height: 22,width: 25,)
          ),
          BottomNavigationBarItem(
              label: "Near By",
              icon: Image.asset(AppImage.nearBy,height: 25,width: 25,)
          ),
          BottomNavigationBarItem(
              label: "Category",
              icon: Image.asset(AppImage.categories,height: 24,width: 25,)
          ),
          BottomNavigationBarItem(
              label: "Chat",
              icon: Image.asset(AppImage.chat,height: 24,width: 25,color: AppColor.appColor,)
          ),
          BottomNavigationBarItem(
              label: "Profile",
              icon: Image.asset(AppImage.profile,height: 19,width: 25,)
    ),
        ],
      ),
    );
  }
}

