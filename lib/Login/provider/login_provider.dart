import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../../Firebase/firebase_collection.dart';

class LoginProvider {

  String? userEmail;
  List<dynamic> userData = [];

  getSharedPreferenceData(String? email) {
    userEmail=email;
  }

  Future<void> addUserDetail(
      {
        required String userName,
        required String userEmail,
        required String userMobile,
        required String userImage,
        required Timestamp timestamp
      }) async {
    DocumentReference documentReferencer =
    FirebaseCollection().userCollection.doc(userEmail);
    Map<String, dynamic> data = <String, dynamic>{
      "userEmail": userEmail.toString(),
      "userName": userName.toString(),
      "userMobile": userMobile.toString(),
      "userImage": userImage.toString(),
      "timeStamp" : timestamp
    };
    debugPrint('user data=> $data');

    FirebaseCollection().userCollection.get().then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        debugPrint("${result.data()}");
        userData.add(result.data());
      }
    });
    await documentReferencer
        .set(data)
        .whenComplete(() => debugPrint("Added user Details"))
        .catchError((e) => debugPrint(e));
  }
}