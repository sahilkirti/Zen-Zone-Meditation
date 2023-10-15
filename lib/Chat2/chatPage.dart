// import 'package:chatappflutter/pages/group_info.dart';
// import 'package:chatappflutter/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

import 'DatabaseServices.dart';
import 'GroupInfo.dart';
import 'Messagetile.dart';
// import '../widgets/message_tile.dart';

class ChatPage extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String userName;
  const ChatPage(
      {Key? key,
        required this.groupId,
        required this.groupName,
        required this.userName})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  File? imageFile;

  Future getImage() async {
    ImagePicker _picker = ImagePicker();
    await _picker.pickImage(source: ImageSource.gallery).then((image) {
      if (image != null) {
        imageFile = File(image.path);
        uploadImage();
      }
    });
  }

  Future uploadImage() async {
    String fileName = Uuid().v1();
    int status = 1;
    sendImage(fileName);

    var ref =
    FirebaseStorage.instance.ref().child('images').child("${fileName}.jpg");

    var uploadTask = await ref.putFile(imageFile!).catchError(() async {
      await DatabaseService().deleteImage(widget.groupId, fileName);
      status = 0;
    });

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();
      DatabaseService().updateUrl(widget.groupId, fileName, imageUrl);
      print(imageUrl);
    }
  }

  Stream<QuerySnapshot>? chats;
  TextEditingController messageController = TextEditingController();
  String admin = "";

  @override
  void initState() {
    getChatandAdmin();
    super.initState();
  }

  getChatandAdmin() {
    DatabaseService().getChats(widget.groupId).then((val) {
      setState(() {
        chats = val;
      });
    });
    DatabaseService().getGroupAdmin(widget.groupId).then((val) {
      setState(() {
        admin = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor:Color(0xffeafddd) ,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new , color: Colors.black)),
        title: Text(widget.groupName , style: TextStyle(color: Colors.black),),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return GroupInfo(
                      groupName: widget.groupName,
                      groupId: widget.groupId,
                      adminName: admin);
                }));
              },
              icon: Icon(Icons.info , color: Colors.black,))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffeafddd), Color(0xffcff6e7) , Color(0xff41baf2)],
          ),
        ),
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: chatMessages(),
                  ),
                )),
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                margin: EdgeInsets.all(6),
                height: MediaQuery.of(context).size.height * 0.08,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.5),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                          controller: messageController,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            // enabledBorder: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: () => getImage(),
                                icon: Icon(Icons.photo , color: Colors.black, size: 28,),
                              ),
                              hintText: "Send a message...",
                              hintStyle:
                              TextStyle(color: Colors.black, fontSize: 16),
                              border: InputBorder.none),
                        )),
                    SizedBox(
                      width: 12,
                    ),
                    GestureDetector(
                      onTap: () {
                        sendMessage();
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                            )),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  chatMessages() {
    return StreamBuilder(
        stream: chats,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              return MessageTile(
                message: snapshot.data.docs[index]['message'],
                sender: snapshot.data.docs[index]['sender'],
                sentByMe: widget.userName ==
                    snapshot.data.docs[index]['sender'],
                messageType: snapshot.data.docs[index]['type'],
                messageTime: snapshot.data.docs[index]['time'],
              );
            },
          )
              : Container();
        });
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messageController.text,
        "sender": widget.userName,
        "time": DateTime.now(),
        "type": "text"
      };
      DatabaseService().sendMessage(widget.groupId, chatMessageMap);
      setState(() {
        messageController.clear();
      });
    }
  }

  sendImage(String fileName) {
    Map<String, dynamic> chatMessageMap = {
      "message": '',
      "sender": widget.userName,
      "time": DateTime.now(),
      "type": "image"
    };
    DatabaseService().sendImage(widget.groupId, chatMessageMap, fileName);
    setState(() {
      messageController.clear();
    });
  }
}
