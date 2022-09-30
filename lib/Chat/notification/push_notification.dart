import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import '../firebase/chat_notification.dart';

class PushNotification extends ChangeNotifier{

  final firebaseMessaging = FCM();
  late FirebaseMessaging messaging;
  String? notificationTitle,notificationBody,notificationData;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  _changeData(String msg) {
    notificationData = msg;
    notifyListeners();
  }
  _changeBody(String msg){
    notificationBody = msg;
    notifyListeners();
  }
  _changeTitle(String msg){
    notificationTitle = msg;
    notifyListeners();
  }

  // onSelectLocalNotification(payload) {
  //   if (notificationTitle == notificationBody) {
  //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewScreen1(payload: "Screen1")));
  //   } else {Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewScreen2(payload: "Screen2")));}
  // }

  onSelectLocalInitialize() {
    var androidSettings = const AndroidInitializationSettings('mipmap/ic_launcher');
    //var iOSSettings = IOSInitializationSettings(requestSoundPermission: false, requestBadgePermission: false, requestAlertPermission: false,);
    var initSettings = InitializationSettings(android: androidSettings, );
    flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  chatMessageNotification(notificationToken,userName,message,currentEmail) async{
    debugPrint("Method called $notificationToken");
    debugPrint("Method called $userName");
    final msg = jsonEncode({
      "registration_ids": <String>[
        "$notificationToken"
      ],
      "notification": {
        "title": "$userName",
        "body": "$message",
        "android_channel_id": "pushnotificationapp",
        "sound": true,
      },
      "data":{
        "type":"",
        "name":"",
      }
    });

    try {
      var response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          'Authorization': 'key=AAAA2L_n9b8:APA91bG5wLS93tJN1WII5DPgu7TxOUDftuzH_vWz-uG4AAgZYgvsE1Mfzt35sG-GlYM1l9118aBlj4rN4En083xCbuwTuJHVvEcDCoab1MI4zvo4VbDEla5WjJDWlZR3USJ0L1iTK5Qa',
          'Content-Type': 'application/json'
        },

        body: msg,
      );

      if(response.statusCode==200){
        debugPrint("Notification Send");

         notificationTitle = userName;
         notificationBody = message;

         firebaseMessaging.setNotifications();
         firebaseMessaging.streamCtlr.stream.listen(_changeData);
         firebaseMessaging.bodyCtlr.stream.listen(_changeBody);
         firebaseMessaging.titleCtlr.stream.listen(_changeTitle);

         //ForeGround FireBase Notification
         FirebaseMessaging.onMessage.listen((RemoteMessage event) {
           FlutterLocalNotificationsPlugin localNotificationsPlugin = FlutterLocalNotificationsPlugin();
           var androidChannelSpecifics = const AndroidNotificationDetails('default', 'Test App Notifications',);
           //var iOSChannelSpecifics = IOSNotificationDetails();
           var platformChannelSpecifics = NotificationDetails(android: androidChannelSpecifics,);
           localNotificationsPlugin.show(0, event.notification!.title, event.notification!.body, platformChannelSpecifics);

           var androidSettings = const AndroidInitializationSettings('mipmap/ic_launcher');
           //var iOSSettings = IOSInitializationSettings(requestSoundPermission: false, requestBadgePermission: false, requestAlertPermission: false,);

           var initSettings = InitializationSettings(android: androidSettings, );
           flutterLocalNotificationsPlugin.initialize(initSettings,);
         });

         //Background Firebase Notification

        FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
           // if (message.notification!.title == message.notification!.body) {
           //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewScreen1(payload: "Screen1")));
           // }
         });


        onSelectLocalInitialize();
         FlutterLocalNotificationsPlugin localNotifPlugin = FlutterLocalNotificationsPlugin();
         var androidChannelSpecifics = const AndroidNotificationDetails('default', 'Test App Notifications',);
        // var iOSChannelSpecifics = IOSNotificationDetails();
         var platformChannelSpecifics = NotificationDetails(android: androidChannelSpecifics);
        FirebaseAuth.instance.currentUser?.email != currentEmail ?
        localNotifPlugin.show(0, notificationTitle, notificationBody, platformChannelSpecifics) : print('Aponenent User');

      }
      else{
        debugPrint("Notification Send Error");
      }
    }catch(e){
      debugPrint("Debug print Catch $e");
    }

  }
}