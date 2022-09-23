import 'dart:developer';
import 'package:barber_booking_management/utils/app_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'model/chatroom_model.dart';
import 'model/message_model.dart';

class ChatRoomPage extends StatefulWidget {
  final  snapshotData;
  final ChatRoomModel chatroom;
  const ChatRoomPage({Key? key, required this.snapshotData, required this.chatroom}) : super(key: key);
  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {

  TextEditingController messageController = TextEditingController();

  void sendMessage() async {
    String msg = messageController.text.trim();
    messageController.clear();
    if(msg != "") {
      // Send Message
      MessageModel newMessage = MessageModel(
          messageid: uuid.v1(),
          sender: FirebaseAuth.instance.currentUser?.email,
          timeStamp: DateTime.now().toString(),
          text: msg,
          seen: false
      );

      FirebaseFirestore.instance.collection("chatrooms").doc(widget.chatroom.chatroomid).
      collection("messages").doc(newMessage.messageid).set(newMessage.toMap());
      widget.chatroom.lastMessage = msg;
      widget.chatroom.lastMessageTime = DateTime.now().toString();
      FirebaseFirestore.instance.collection("chatrooms").
      doc(widget.chatroom.chatroomid).set(widget.chatroom.toMap());
      log('Chat Room Id ${widget.chatroom.chatroomid}');
      log('New Message Id ${newMessage.messageid}');
      log("Message Sent!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.snapshotData['userName'].toString()),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("chatrooms").
                  doc(widget.chatroom.chatroomid).collection("messages").
                  orderBy("timeStamp", descending: true).
                  snapshots(),
                  builder: (context,AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator(),);
                    }
                    if(snapshot.requireData.docChanges.isNotEmpty) {
                      QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;
                      return ListView.builder(
                        reverse: true,
                        itemCount: dataSnapshot.docs.length,
                        itemBuilder: (context, index) {
                          MessageModel currentMessage = MessageModel.fromMap(dataSnapshot.docs[index].data() as Map<String, dynamic>);
                          return Row(
                            mainAxisAlignment: (currentMessage.sender == FirebaseAuth.instance.currentUser?.email) ? MainAxisAlignment.end : MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: currentMessage.sender != FirebaseAuth.instance.currentUser?.email ?
                                  CrossAxisAlignment.start : CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                        margin: currentMessage.sender == FirebaseAuth.instance.currentUser?.email ?
                                        const EdgeInsets.fromLTRB(50,7,00,0) : const EdgeInsets.fromLTRB(00,7,50,00),
                                        padding: currentMessage.sender == FirebaseAuth.instance.currentUser?.email ?
                                        const EdgeInsets.fromLTRB(10,10,5,10) : const EdgeInsets.fromLTRB(5,10,10,10),
                                        decoration: BoxDecoration(
                                            color: (currentMessage.sender == FirebaseAuth.instance.currentUser?.email) ? AppColor.appColor : AppColor.greyColor,
                                            borderRadius:
                                            currentMessage.sender == FirebaseAuth.instance.currentUser?.email ?
                                            const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight:  Radius.circular(10),
                                                bottomLeft:  Radius.circular(10)
                                            ) : const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomRight: Radius.circular(10)
                                            )
                                        ),
                                        child: Text(
                                          '${currentMessage.text.toString()}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        )
                                    ),
                                    Text(
                                      '${currentMessage.timeStamp.toString().substring(11,16)}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                    else if(snapshot.hasError) {
                      return const Center(
                        child: Text("An error occurred! Please check your internet connection."),
                      );
                    }
                    else {
                      return const Center(
                        child: Text("Say hii"),
                      );
                    }
                    // else {
                    //   return const Center(
                    //     child: CircularProgressIndicator(),
                    //   );
                    // }
                  },
                ),
              ),
            ),

            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5
              ),
              child: Row(
                children: [

                  Flexible(
                    child: TextField(
                      controller: messageController,
                      maxLines: null,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter message"
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      sendMessage();
                    },
                    icon: Icon(Icons.send, color: Theme.of(context).colorScheme.secondary,),
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}