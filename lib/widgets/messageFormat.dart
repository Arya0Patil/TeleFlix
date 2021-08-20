import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:linkable/linkable.dart';
import 'dart:math';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message, this.userName, this.isMe, {this.key});

  final Key key;
  final String message;
  final String userName;
  bool isMe;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          constraints: BoxConstraints(minWidth: 50, maxWidth: 250),
          // width: 140.0,
          margin: EdgeInsets.fromLTRB(5.0, 1.5, 5.0, 0.0),
          padding: EdgeInsets.all(7.0),
          decoration: BoxDecoration(
            color: isMe ? Colors.grey[200] : Colors.green[50],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
              bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(8.0),
              bottomRight: isMe ? Radius.circular(0) : Radius.circular(8.0),
            ),
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                userName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: !isMe
                        ? Colors.primaries[
                            Random().nextInt(Colors.primaries.length)]
                        : Colors.pinkAccent[700]),
              ),
              Linkable(
                text: message,
                style: TextStyle(
                  fontSize: 17.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
