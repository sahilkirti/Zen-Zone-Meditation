// import 'package:chatappflutter/helper/helper_function.dart';
// import 'package:chatappflutter/pages/chat_page.dart';
// import 'package:chatappflutter/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'DatabaseServices.dart';
import 'Helper.dart';
import 'chatPage.dart';

class SearchPage1 extends StatefulWidget {
  const SearchPage1({Key? key}) : super(key: key);

  @override
  State<SearchPage1> createState() => _SearchPage1State();
}

class _SearchPage1State extends State<SearchPage1> {
  TextEditingController searchController = TextEditingController();
  QuerySnapshot? searchSnapshot;
  bool isLoading = false;
  bool hasUserSearched = false;
  String userName = "";
  User? user;
  bool isJoined = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUserIdandname();
  }

  getAdminName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  getCurrentUserIdandname() async {
    await HelperFunctions.getUserNameSF().then((value) {
      setState(() {
        userName = value!;
      });
    });
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffeafddd),
        centerTitle: true,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new , color: Colors.black)),
        elevation: 0,
        title: Text(
          "Search",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black),
        ),
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
            Container(
              color: Color(0xffeafddd),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        cursorColor: Colors.white,
                        controller: searchController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2)),
                            hintText: "Search groups",
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.9),
                              fontSize: 16,
                            )),
                      )),
                  GestureDetector(
                    onTap: () {
                      initializeSearchMethod();
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(40)),
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
            isLoading
                ? Center(
              child: CircularProgressIndicator(),
            )
                : groupList(),
          ],
        ),
      ),
    );
  }

  initializeSearchMethod() async {
    if (searchController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await DatabaseService()
          .searchByName(searchController.text)
          .then((snapShot) {
        setState(() {
          searchSnapshot = snapShot;
          isLoading = false;
          hasUserSearched = true;
        });
      });
    }
  }

  groupList() {
    return hasUserSearched
        ? ListView.builder(
      shrinkWrap: true,
      itemCount: searchSnapshot!.docs.length,
      itemBuilder: (context, index) {
        return groupTile(
          userName,
          searchSnapshot!.docs[index]['groupId'],
          searchSnapshot!.docs[index]['groupName'],
          searchSnapshot!.docs[index]['admin'],
        );
      },
    )
        : Container();
  }

  joinedOrNot(
      String userName, String groupId, String groupName, String admin) async {
    await DatabaseService(sid: user!.uid)
        .isUserJoined(groupName, groupId, userName)
        .then((value) {
      setState(() {
        isJoined = value;
      });
    });
  }

  Widget groupTile(
      String userName, String groupId, String groupName, String admin) {
    joinedOrNot(userName, groupId, groupName, admin);
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      leading: CircleAvatar(
        radius: 27,
        child: Text(
          groupName.substring(0, 1).toUpperCase(),
          style: TextStyle(color: Colors.white),
        ),
      ),
      title: Text(
        groupName,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text("Admin: ${getAdminName(admin)}"),
      trailing: InkWell(
        onTap: () async {
          await DatabaseService(sid: user!.uid)
              .toggleGroupJoin(groupId, userName, groupName);
          if (isJoined) {
            setState(() {
              isJoined = !isJoined;
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Successfully joined the group"),
              backgroundColor: Colors.green,
            ));

            Future.delayed(const Duration(seconds: 3), () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) {
                  return ChatPage(
                      groupId: groupId,
                      groupName: groupName,
                      userName: userName);
                },
              ));
            });
          } else {
            setState(() {
              isJoined = !isJoined;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Left the group $groupName"),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              ));
            });
          }
        },
        child: isJoined
            ? Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black,
            border: Border.all(color: Colors.white, width: 1),
          ),
          padding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: const Text(
            "Joined",
            style: TextStyle(color: Colors.white),
          ),
        )
            : Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).primaryColor,
          ),
          padding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: const Text("Join Now",
              style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
