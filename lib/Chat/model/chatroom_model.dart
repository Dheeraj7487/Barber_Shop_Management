class ChatRoomModel {
  String? chatroomid;
  String? chatUserName;
  String? chatUser1;
  String? chatUser2;
  Map<String, dynamic>? participants;
  String? lastMessage;
  String? lastMessageTime;

  ChatRoomModel({this.chatroomid, this.participants,
    this.lastMessage,required this.chatUser1,required this.chatUser2,
    required this.chatUserName,
    required this.lastMessageTime});

  ChatRoomModel.fromMap(Map<String, dynamic> map) {
    chatroomid = map["chatroomid"];
    chatUserName = map["userName"];
    participants = map["participants"];
    lastMessage = map["lastmessage"];
    chatUser1 = map["chatUser1"];
    chatUser2 = map["chatUser2"];
    lastMessageTime = map["lastMessageTime"];
  }

  Map<String, dynamic> toMap() {
    return {
      "chatroomid": chatroomid,
      "userName": chatUserName,
      "participants": participants,
      "chatUser1": chatUser1,
      "chatUser2": chatUser2,
      "lastmessage": lastMessage,
      "lastMessageTime": lastMessageTime
    };
  }
}