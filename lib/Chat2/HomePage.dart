// import 'package:chatappflutter/helper/helper_function.dart';
// import 'package:chatappflutter/pages/auth/login_page.dart';
// import 'package:chatappflutter/pages/profilePage.dart';
// import 'package:chatappflutter/pages/searchPage.dart';
// import 'package:chatappflutter/services/auth_services.dart';
// import 'package:chatappflutter/widgets/group_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'DatabaseServices.dart';
import 'Grouptile.dart';
import 'Helper.dart';
import 'SearchPage.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = "";
  String email = "";
 // AuthService authService = AuthService();
  Stream? groups;
  bool _isLoading = false;
  String groupName = "";
  @override
  void initState() {
    //TODO: implement initState
   super.initState();

   gettingUserData();
   print('jj');
  }

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1, res.length);
  }

  gettingUserData() async {
    print('uiy');
    await HelperFunctions.getUserEmailFromSF().then((value) {
      print('rrrr');
      setState(() {
        print('eee');
        email = value!;
        print('qqq');
      });
    });
    print('hhhh');

    await HelperFunctions.getUserNameSF().then((value) {
      setState(() {
        userName = value!;
        print(userName);
      });
    });

    // gettng the list of snapshot
    await DatabaseService(sid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroups()
        .then((snapshot) {
          print(snapshot);
      setState(() {
        groups = snapshot;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Chats" , style: TextStyle(color: Colors.black),),
        backgroundColor:Color(0xffeafddd) ,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back_ios_new , color: Colors.black)),
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return SearchPage1();
                }));
              },
              icon: Icon(Icons.search , color: Colors.black,)),
        ],
      ),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.symmetric(vertical: 50),
      //     children: [
      //       Icon(
      //         Icons.account_circle,
      //         size: 150,
      //         color: Theme.of(context).primaryColor,
      //       ),
      //       SizedBox(
      //         height: 10,
      //       ),
      //       Text(
      //         userName,
      //         textAlign: TextAlign.center,
      //         style: TextStyle(fontWeight: FontWeight.bold),
      //       ),
      //       Divider(
      //         thickness: 2,
      //       ),
      //       ListTile(
      //         selectedColor: Theme.of(context).primaryColor,
      //         selected: true,
      //         leading: Icon(Icons.groups),
      //         title: Text("Groups"),
      //         onTap: () {
      //           HomePage();
      //         },
      //       ),
      //       // ListTile(
      //       //   leading: Icon(Icons.account_circle),
      //       //   title: Text("Profile"),
      //       //   onTap: () {
      //       //     Navigator.pushReplacement(context,
      //       //         MaterialPageRoute(builder: (_) {
      //       //           return ProfilePage(userName, email);
      //       //         }));
      //       //   },
      //       // ),
      //       ListTile(
      //         leading: Icon(Icons.logout),
      //         title: Text("Logout"),
      //         onTap: () async {
      //           showDialog(
      //             barrierDismissible: false,
      //             context: context,
      //             builder: (context) {
      //               return AlertDialog(
      //                 title: Text("Logout"),
      //                 content: Text("Are you sure you want to logout?"),
      //                 backgroundColor: Theme.of(context).primaryColor,
      //                 titleTextStyle: TextStyle(
      //                   color: Colors.white,
      //                   fontWeight: FontWeight.bold,
      //                   fontSize: 20,
      //                 ),
      //                 alignment: Alignment.center,
      //                 actions: [
      //                   IconButton(
      //                       onPressed: () {
      //                         Navigator.pop(context);
      //                       },
      //                       icon: Icon(Icons.cancel)),
      //                   IconButton(
      //                       onPressed: () async {
      //                         await authService.signOut();
      //                         Navigator.pushAndRemoveUntil(context,
      //                             MaterialPageRoute(builder: (_) {
      //                               return LoginPage();
      //                             }), (route) => false);
      //                       },
      //                       icon: Icon(Icons.done))
      //                 ],
      //               );
      //             },
      //           );
      //         },
      //       )
      //     ],
      //   ),
      // ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffeafddd), Color(0xffcff6e7) , Color(0xff41baf2)],
          ),
        ),
        child: Center(
          child: groupList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          popUpDialog(context);
        },
        elevation: 0,
        child: Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }

  popUpDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Create a group",
              textAlign: TextAlign.left,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _isLoading == true
                    ? Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                )
                    : TextField(
                  onChanged: (val) {
                    setState(() {
                      groupName = val;
                    });
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancel",
                ),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (groupName != "") {
                    setState(() {
                      _isLoading = true;
                    });
                    DatabaseService(sid: FirebaseAuth.instance.currentUser!.uid)
                        .createGroup(userName,
                        FirebaseAuth.instance.currentUser!.uid, groupName)
                        .whenComplete(() {
                      _isLoading = false;
                    });
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Group created Successfully"),
                      backgroundColor: Colors.green,
                    ));
                  }
                },
                child: Text(
                  "Create",
                ),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor),
              ),
            ],
          );
        });
  }

  groupList() {
    print('ff');
    return StreamBuilder(
      stream: groups,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          print('this 1 if');
          if (snapshot.data['groups'] != null) {
            if (snapshot.data['groups'].length != 0) {
              int len = snapshot.data['groups'].length;
              return ListView.builder(
                  physics: BouncingScrollPhysics(
                      decelerationRate: ScrollDecelerationRate.normal),
                  itemCount: len,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GroupTile(
                          groupId:
                          getId(snapshot.data['groups'][len - index - 1]),
                          userName: snapshot.data['name'],
                          groupName:
                          getName(snapshot.data['groups'][len - index - 1])),
                    );
                  });
            } else {
              return noGroupWidget();
            }
          } else {
            return noGroupWidget();
          }
        } else {
          return Center(
            child: Text('Hi'),
            // child: CircularProgressIndicator(
            //     color: Theme.of(context).primaryColor),
          );
        }
      },
    );
  }

  noGroupWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              popUpDialog(context);
            },
            child: Icon(
              Icons.add_circle,
              color: Colors.grey[700],
              size: 60,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
              "You've not joined ant groups,tap on the add icon to create a group or also search from top search icon")
        ],
      ),
    );
  }
}
