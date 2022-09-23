// import 'package:barber_booking_management/Firebase/firebase_collection.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../main.dart';
// import '../utils/app_color.dart';
// import 'chat_room_page.dart';
// import 'model/chatroom_model.dart';
//
// class ChatUserScreen extends StatefulWidget {
//   const ChatUserScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ChatUserScreen> createState() => _ChatUserScreenState();
// }
//
// class _ChatUserScreenState extends State<ChatUserScreen> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//           stream: FirebaseFirestore.instance.collection('chatrooms').
//           // where('userEmail',isNotEqualTo: FirebaseCollection.currentUserId).
//           where('participants.${FirebaseAuth.instance.currentUser?.uid}',isEqualTo: true).
//           snapshots(),
//           builder: (context,AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
//             if(snapshot.connectionState == ConnectionState.waiting){
//               return const SizedBox();
//             }else if (snapshot.hasError) {
//               return const Center(child: Text("Something went wrong"));
//             } else if (!snapshot.hasData) {
//               return const SizedBox();
//             } else if (snapshot.requireData.docChanges.isEmpty){
//               return const SizedBox();
//             } else {
//               return ListView.builder(
//                   itemCount: snapshot.data?.docs.length,
//                   itemBuilder: (context,index){
//                     return GestureDetector(
//                       onTap: () async{
//                         //print('Doc Id get => ${FirebaseAuth.instance.currentUser?.uid}');
//                         Future<ChatRoomModel?> getChatroomModel() async {
//                           ChatRoomModel? chatRoom;
//                           // print('Doc Id get => ${snapshot.data?.docs[index]['uid']}');
//                           var querySnapShot = await FirebaseCollection().userCollection.get();
//                             for(var snapshotData in querySnapShot.docChanges){
//                               if(snapshotData.doc.get('userEmail') == snapshot.data?.docs[index]['chatUser2'] &&
//                                   snapshotData.doc.get('userEmail') == snapshot.data?.docs[index]['chatUser2'])
//                               {
//                               print('For Loop 1  => ${snapshotData.doc.get('userEmail')}');
//
//                               QuerySnapshot snapshot1 = await FirebaseFirestore.instance.collection("chatrooms").
//                               where("participants.${FirebaseAuth.instance.currentUser?.uid}", isEqualTo: true).
//                               where("participants.${snapshotData.doc.get('uid')}", isEqualTo: true).get();
//
//                               if(snapshot1.docs.length > 0) {
//                                 var docData = snapshot1.docs[0].data();
//                                 ChatRoomModel existingChatroom = ChatRoomModel.fromMap(docData as Map<String, dynamic>);
//                                 chatRoom = existingChatroom;
//                                 break;
//                               }
//                               else {
//                                 ChatRoomModel newChatroom = ChatRoomModel(
//                                   chatroomid: uuid.v1(),
//                                   chatUserName: snapshot.data?.docs[index]['userName'],
//                                   lastMessage: "",
//                                   chatUser1: FirebaseAuth.instance.currentUser?.email,
//                                   chatUser2: snapshot.data?.docs[index]['userEmail'],
//                                   lastMessageTime: DateTime.now().toString(),
//                                   participants: {
//                                     FirebaseAuth.instance.currentUser!.uid.toString(): true,
//                                     snapshot.data?.docs[index]['uid']: true,
//                                   },
//                                 );
//
//                                 await FirebaseFirestore.instance.collection("chatrooms").doc(newChatroom.chatroomid).set(newChatroom.toMap());
//                                 chatRoom = newChatroom;
//                                 debugPrint("New Chatroom Created");
//                               }
//                               }
//
//                               // if(snapshotData.doc.get('userEmail') == snapshot.data?.docs[index]['chatUser1'] )
//                               // {
//                               //   print('For Loop 1  => ${snapshotData.doc.get('userEmail')}');
//                               //
//                               //   QuerySnapshot snapshot1 = await FirebaseFirestore.instance.collection("chatrooms").
//                               //   where("participants.${FirebaseAuth.instance.currentUser?.uid}", isEqualTo: true).
//                               //   where("participants.${snapshotData.doc.get('uid')}", isEqualTo: true).get();
//                               //
//                               //   if(snapshot1.docs.length > 0) {
//                               //     var docData = snapshot1.docs[0].data();
//                               //     ChatRoomModel existingChatroom = ChatRoomModel.fromMap(docData as Map<String, dynamic>);
//                               //     chatRoom = existingChatroom;
//                               //     break;
//                               //   }
//                               //   else {
//                               //     ChatRoomModel newChatroom = ChatRoomModel(
//                               //       chatroomid: uuid.v1(),
//                               //       chatUserName: snapshot.data?.docs[index]['userName'],
//                               //       lastMessage: "",
//                               //       chatUser1: FirebaseAuth.instance.currentUser?.email,
//                               //       chatUser2: snapshot.data?.docs[index]['userEmail'],
//                               //       lastMessageTime: DateTime.now().toString(),
//                               //       participants: {
//                               //         FirebaseAuth.instance.currentUser!.uid.toString(): true,
//                               //         snapshot.data?.docs[index]['uid']: true,
//                               //       },
//                               //     );
//                               //
//                               //     await FirebaseFirestore.instance.collection("chatrooms").doc(newChatroom.chatroomid).set(newChatroom.toMap());
//                               //     chatRoom = newChatroom;
//                               //     debugPrint("New Chatroom Created");
//                               //   }
//                               // }
//
//                             }
//
//                           return chatRoom;
//                         }
//                         ChatRoomModel? chatroomModel = await getChatroomModel();
//                         if(chatroomModel != null) {
//                           Navigator.push(context, MaterialPageRoute(
//                               builder: (context) {
//                                 return ChatRoomPage(
//                                   snapshotData: snapshot.data?.docs[index],
//                                   chatroom: chatroomModel,
//                                 );
//                               }
//                           ));
//                         }
//                       },
//                       child: ListTile(
//                         title:  Text('${snapshot.data?.docs[index]['userName']?.substring(0,1).toUpperCase()}'
//                             '${snapshot.data?.docs[index]['userName'].substring(1).toLowerCase()}',
//                             style: const TextStyle(fontSize: 12)),
//                         subtitle: Text(snapshot.data?.docs[index]['lastmessage'],
//                             style: const TextStyle(fontSize: 10)),
//                         leading:
//                         //snapshot.data?.docs[index]['userImage'] != '' ?
//                         // ClipOval(
//                         //     child: Image.network(snapshot.data?.docs[index]['userImage'],
//                         //         height: 50,width: 50,fit: BoxFit.fill)) :
//                         ClipOval(
//                           child: Container(
//                             color: AppColor.appColor,
//                             height: 40,width: 40,child: Center(
//                             child: Text('${snapshot.data?.docs[index]['userName']?.substring(0,1).toUpperCase()}',
//                                 style: const TextStyle(color: AppColor.whiteColor)),
//                           ),),
//                         ),
//                         trailing: Text('${snapshot.data?.docs[index]['lastMessageTime'].
//                                   toString().substring(11,16)}',
//                                   style: const TextStyle(color: AppColor.greyColor,fontSize: 10)),
//                       ),
//                     );
//                   }
//               );
//             }
//           }
//       ),
//     );
//   }
//
// }
