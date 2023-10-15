import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageTile extends StatefulWidget {
  final String message;
  final String sender;
  final bool sentByMe;
  final String messageType;
  final Timestamp messageTime;

  const MessageTile(
      {Key? key,
        required this.message,
        required this.sender,
        required this.sentByMe,
        required this.messageType,
        required this.messageTime})
      : super(key: key);

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    return widget.messageType == 'text'
        ? Container(
      padding: EdgeInsets.only(
          top: 4,
          bottom: 4,
          left: widget.sentByMe ? 0 : 24,
          right: widget.sentByMe ? 24 : 0),
      alignment:
      widget.sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: widget.sentByMe
            ? EdgeInsets.only(left: 30)
            : EdgeInsets.only(right: 30),
        padding:
        EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: Offset(2, 2),
                  spreadRadius: 0.1,
                  color: Colors.black)
            ],
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: widget.sentByMe
                ? BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            )
                : BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            color: widget.sentByMe
                ? Color(0xffaec2fa)
                : Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.sender.toUpperCase(),
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: (-0.5),
                )),
            const SizedBox(
              height: 8,
            ),
            Text(widget.message,
                textAlign: TextAlign.start,
                style:
                const TextStyle(fontSize: 16, color: Colors.black)),
            Text(DateTime.fromMillisecondsSinceEpoch(
                widget.messageTime.seconds)
                .toString())
          ],
        ),
      ),
    )
        : Container(
      padding: EdgeInsets.only(
          top: 4,
          bottom: 4,
          left: widget.sentByMe ? 0 : 24,
          right: widget.sentByMe ? 24 : 0),
      alignment:
      widget.sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
          margin: widget.sentByMe
              ? EdgeInsets.only(left: 30)
              : EdgeInsets.only(right: 30),
          padding: EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    offset: Offset(2, 2),
                    spreadRadius: 0.1,
                    color: Colors.black)
              ],
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: widget.sentByMe
                  ? BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              )
                  : BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: widget.sentByMe
                  ? Color(0xffaec2fa)
                  : Colors.white),
          child: widget.message != ''
              ? Column(
            children: [
              Text(widget.sender.toUpperCase(),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: (-0.5),
                  )),
              const SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),),
                child: Image.network(
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.4,
                    widget.message),
              ),
              Text(DateTime.utc(widget.messageTime.seconds)
                  .toString())
            ],
          )
              : CircularProgressIndicator()),
    );
  }
}
