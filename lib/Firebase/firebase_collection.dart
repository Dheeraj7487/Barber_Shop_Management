import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseCollection {
  static const String userCollectionName = 'user';
  static String? currentUserId = FirebaseAuth.instance.currentUser?.email;
  CollectionReference userCollection = FirebaseFirestore.instance.collection(userCollectionName);
}