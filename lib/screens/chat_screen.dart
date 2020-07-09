import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  String message;
  final messageTextController = TextEditingController();
  var sendingTime;

  void getMessages() async {
    await for (var snapshot in _firestore.collection('messages').snapshots() ){
      for(var messages in snapshot.documents){
        print(messages['message']);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }
  void getCurrentUser() async {
    final user = await _auth.currentUser();
//    print(user.email);
    try {
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }



  String getTime(){
    TimeOfDay _time = new TimeOfDay.now();
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final String formattedTimeOfDay = localizations.formatTimeOfDay(_time);
    return formattedTimeOfDay.replaceAll(' ', '');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: IconButton(
                      icon: Icon(Icons.arrow_back_ios, size: 24,),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
                Text('Group Chat', style: TextStyle(color: Colors.black, fontFamily: 'SofiaPro', fontSize: 28, fontWeight: FontWeight.bold),),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                        icon: Icon(Icons.close, color: Colors.white, size: 24,),
                        onPressed: () {
//                          getTime();
                          _auth.signOut();
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }),
                  ),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('messages').orderBy('sendingTime').snapshots(),
                builder: (context, snapshot){
                  if (!snapshot.hasData){
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blueAccent,
                      ),
                    );
                  }
//                  List<DocumentSnapshot> docs = snapshot.data.documents;
                    final messages = snapshot.data.documents.reversed;
                    List<MessageBox> messageWidgets = [];
//                  .map((doc) => MessageBox(
//                        messageText : doc.data['message'],
//                        messageSender: doc.data['sender'],
//                        isMe: doc.data['sender'] == loggedInUser.email,
//                        time: doc.data['time'],
//                    )).toList();
                    for (var message in messages) {
                      final messageText = message['message'];
                      final messageSender = message['sender'];
                      final time = message['time'];
                      final isMe = messageSender == loggedInUser.email;
                      final messageWidget = MessageBox(messageSender: messageSender,messageText: messageText,isMe : isMe,time: time);
                      messageWidgets.add(messageWidget);
                    }
                    return ListView(
                      reverse: true,
                      padding: EdgeInsets.symmetric(vertical: 14,horizontal: 10),
                      children: messageWidgets,
                    );

                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,bottom: 8.0,top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Color(0xFFDDDDDD),
                    ),
                    width: 320,
                    child: TextField(
                      controller: messageTextController,
                      style: TextStyle(fontWeight: FontWeight.normal),

                      onChanged: (value) {
                        message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextController.clear();
                      sendingTime = DateTime.now();
                      _firestore.collection('messages').add(
                        {
                          'message': message,
                          'sender': loggedInUser.email,
                          'time' : getTime(),
                          'sendingTime': sendingTime.toString(),
                        }
                      );
                    },
                    child: Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Color(0xFFFEA5A6),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 28,
                      ),
                    )
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

class MessageBox extends StatelessWidget {

  final String messageText;
  final String messageSender;
  final String time;
  final bool isMe;
  const MessageBox({this.messageText, this.messageSender, this.isMe,this.time});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: isMe ? 0 : 30,
            backgroundImage: AssetImage('images/goku.jpg'),
          ),
          SizedBox(
            width: 17,
          ),
          Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end: CrossAxisAlignment.start,
            children: <Widget>[
              Text(isMe ? '': messageSender,style: TextStyle(color: Colors.grey, fontSize: 15),),
              SizedBox(
                height: 1.0,
              ),
              Container(
                constraints: BoxConstraints(maxWidth: 250.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15),bottomLeft: Radius.circular(isMe ? 15 : 0),bottomRight: Radius.circular(isMe ? 0 : 15)),
                  color: Color(isMe ? 0xFFFEA5A6 : 0xFFDDDDDD),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                  child: Text(
                    messageText, style: TextStyle(fontSize: 20, color:isMe ? Colors.white : Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 1.0),
              Text(time,style: TextStyle(color: Colors.grey, fontSize: 15),),
            ],
          ),
        ],
      ),
    );
  }
}
