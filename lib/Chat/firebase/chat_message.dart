import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../Firebase/firebase_collection.dart';

class ChatMessageFirebase {
  Future<void> chatMessage(
      {
        required String senderId,
        required String receiverId,
        required String message,
        required Timestamp timestamp
      }) async {
    DocumentReference documentReferencer =
    FirebaseCollection().chatCollection.
    doc('$senderId $receiverId').
    collection('message').doc();
    Map<String, dynamic> data = <String, dynamic>{
      "senderId": senderId.toString(),
      "receiverId": receiverId.toString(),
      "message": message.toString(),
      "timeStamp" : timestamp
    };
    debugPrint('Chat Message => $data');

    await documentReferencer
        .set(data)
        .whenComplete(() => debugPrint("Send msg"))
        .catchError((e) => debugPrint(e));
  }


}