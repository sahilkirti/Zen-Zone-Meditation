// import 'package:chatappflutter/pages/chat_page.dart';
import 'package:flutter/material.dart';

import 'chatPage.dart';

class GroupTile extends StatefulWidget {
  final String userName;
  final String groupId;
  final String groupName;
  const GroupTile(
      {Key? key,
        required this.groupId,
        required this.userName,
        required this.groupName})
      : super(key: key);

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return ChatPage(
              groupId: widget.groupId,
              groupName: widget.groupName,
              userName: widget.userName);
        }));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20)),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Text(
                widget.groupName.substring(0, 1).toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            title: Text(
              widget.groupName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text("Join the conversation as ${widget.userName}"),
          ),
        ),
      ),
    );
  }
}
