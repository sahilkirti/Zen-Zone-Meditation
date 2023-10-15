// import 'package:chatappflutter/helper/helper_function.dart';
// import 'package:chatappflutter/pages/homePage.dart';
// import 'package:chatappflutter/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'DatabaseServices.dart';
import 'Helper.dart';
import 'HomePage.dart';

class GroupInfo extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String adminName;

  const GroupInfo(
      {Key? key,
        required this.groupName,
        required this.groupId,
        required this.adminName})
      : super(key: key);

  @override
  State<GroupInfo> createState() => _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {
  Stream? members;
  @override
  void initState() {
    // TODO: implement initState
    getMembers();
    super.initState();
    getUserName();
  }

  getMembers() async {
    DatabaseService(sid: FirebaseAuth.instance.currentUser!.uid)
        .getGroupMembers(widget.groupId)
        .then((val) {
      setState(() {
        members = val;
      });
    });
  }

  String userName = "";
  getUserName() async {
    await HelperFunctions.getUserNameSF().then((value) {
      setState(() {
        userName = value!;
      });
    });
    print(userName);
  }

  getAdminName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  String getName(String r) {
    return r.substring(r.indexOf("_") + 1);
  }

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
          elevation: 0,
          backgroundColor:Color(0xffeafddd) ,
          leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_new , color: Colors.black)),
          title: Text("Group Info" , style: TextStyle(color: Colors.black),),
         actions: [
        IconButton(
            onPressed: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Exit!!"),
                    content: Text("Are you sure you want to exit the group?"),
                    backgroundColor: Theme.of(context).primaryColor,
                    titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    alignment: Alignment.center,
                    actions: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.cancel)),
                      IconButton(
                          onPressed: () async {
                            DatabaseService(
                                sid: FirebaseAuth.instance.currentUser!.uid)
                                .toggleGroupJoin(
                                widget.groupId, userName, widget.groupName)
                                .whenComplete(() {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (_) {
                                  return HomePage();
                                },
                              ));
                            });
                          },
                          icon: Icon(Icons.done))
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.exit_to_app , color: Colors.black,))
      ]),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffeafddd), Color(0xffcff6e7) , Color(0xff41baf2)],
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).primaryColor.withOpacity(0.2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Text(
                      widget.groupName.substring(0, 1).toUpperCase(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Group:  ${widget.groupName}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Admin:  ${getAdminName(widget.adminName)}"),
                    ],
                  )
                ],
              ),
            ),
            memberList(),
          ],
        ),
      ),
    );
  }

  memberList() {
    return StreamBuilder(
      stream: members,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['members'] != null) {
            if (snapshot.data['members'].length != 0) {
              // print("length=${snapshot.data['members'].length}");
              return ListView.builder(
                itemCount: snapshot.data['members'].length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(
                          getName(snapshot.data['members'][index])
                              .substring(0, 1)
                              .toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(getName(snapshot.data['members'][index])),
                      subtitle:
                      Text("ID: ${getId(snapshot.data['members'][index])}"),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text("NO MEMBERS"),
              );
            }
          } else {
            return const Center(
              child: Text("NO MEMBERS"),
            );
          }
        } else {
          return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ));
        }
      },
    );
  }
}
