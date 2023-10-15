import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final2/Setting/Setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class NavDrawer extends StatefulWidget {
  final String Name;
  final String email;
  final String Image;

  NavDrawer(
      {Key? key, required this.Name, required this.email, required this.Image})
      : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shadowColor: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              widget.Name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(
              widget.email,
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
            decoration: BoxDecoration(
              color: Colors.black, // set the color of the header
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  widget.Image,
                  fit: BoxFit.cover,
                  height: 80,
                  width: 80,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle_outlined),
            title: Text('Account'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Setting'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.share_rounded),
            title: Text('Share With Friends'),
            onTap: () {
              Share.share('com.example.final2');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Exit'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                        title: new Text("Logging Out"),
                        content: new Text("Are you sure you want to log out?"),
                        actions: <Widget>[
                          CupertinoDialogAction(
                              isDefaultAction: true,
                              child: Text('Yes'),
                              onPressed: () {
                                SystemNavigator.pop();
                              }),
                          CupertinoDialogAction(
                            child: Text('No'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ));
            },
          ),
        ],
      ),
    );
  }
}
