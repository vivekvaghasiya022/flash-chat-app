import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainChatScreen extends StatelessWidget {

  List<String> name = ['Mari','Endy','Lily','Joshua','Jason'];
  List<Users> users = [
//    Users('images/chat_img0.jpg', 'Group Chat', "It's a great idea!", '5:22PM', 2),
    Users('images/chat_img0.jpg', 'Matilda Luiz', "Will you be in school today?", '4:12PM', 1),
    Users('images/chat_img1.jpg', 'Arthur Remor', "I'm waiting for you", '3:18PM', 1),
    Users('images/chat_img2.jpg', 'Nina Maren', "When will we meet?", '1:19PM', 0),
  ];

  static const String id = 'main_chat_screen';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Chat', style: TextStyle(color: Colors.white, fontFamily: 'SofiaPro', fontSize: 32, fontWeight: FontWeight.bold),),
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Color(0xFF363636),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Icon(Icons.add, color: Colors.white,size: 25,),
                      )
                    ],
                  ),
                ),
                Expanded(

                  child: Padding(
                    padding: const EdgeInsets.only(left:15.0,top: 30.0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: name.length,
                      itemExtent: 97,
                      itemBuilder: (context, index){
                        return Column(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: AssetImage('images/img$index.jpg'),
                              radius: 35,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(name[index],style: TextStyle(color: Colors.white),),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Today', style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                            Text(':', style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: (){
                    Navigator.pushNamed(context, ChatScreen.id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: AssetImage('images/goku.jpg'),
                              radius: 35.0,
                            ),
                            SizedBox(width: 20,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Group chat',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                Text('Hii there',style: TextStyle(color: Colors.grey,fontSize: 16))
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text('5:10PM',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                            SizedBox(height: 5,),
                            Container(
                              width:22,
                              height:22,
                              decoration: BoxDecoration(
                                color: 2 > 0 ? Color(0xFFFEA5A6) : Colors.white,
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: Center(
                                child: Text(
                                  '2', style: TextStyle(color: Colors.white, fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (context, index){
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      CircleAvatar(
                                      backgroundImage: AssetImage(users[index].imgUrl),
                                        radius: 35.0,
                                      ),
                                      SizedBox(width: 20,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(users[index].name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                          Text(users[index].shownMsg,style: TextStyle(color: Colors.grey,fontSize: 16))
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(users[index].Time,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                      SizedBox(height: 5,),
                                      Container(
                                        width:22,
                                        height:22,
                                        decoration: BoxDecoration(
                                          color: users[index].msgToSeen > 0 ? Color(0xFFFEA5A6) : Colors.white,
                                          borderRadius: BorderRadius.circular(13),
                                        ),
                                        child: Center(
                                          child: Text(
                                            users[index].msgToSeen.toString(), style: TextStyle(color: Colors.white, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
