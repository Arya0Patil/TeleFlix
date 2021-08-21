import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _messageData = '';
  final _controller = TextEditingController();

  // void _submitAuthForm(
  //   String email,
  //   String password,
  //   String username,
  //   bool isLogin,
  //   BuildContext ctx,
  // ) async {
  //   FirebaseFirestore.instance.collection('chats').add({
  //     'userName': username,
  //   });
  // }

  void _sendMsg() async {
    FocusScope.of(context).unfocus();

    final user = await FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    FirebaseFirestore.instance.collection('chats').add({
      'text': _messageData,
      'time': Timestamp.now(),
      'userId': user.uid,
      'username': userData['username']
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        padding: EdgeInsets.all(5.0),
        child: Row(
          children: [
            Expanded(
                child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                  borderSide: new BorderSide(),
                ),
                contentPadding: EdgeInsets.fromLTRB(10.0, 8.0, 5.0, 5.0),
                labelText: 'Request Movie',
              ),
              onChanged: (value) {
                setState(() {
                  _messageData = value;
                });
              },
            )),
            IconButton(
                onPressed: _messageData.trim().isEmpty ? null : _sendMsg,
                icon: Icon(
                  Icons.send,
                  color: Colors.green,
                )),
          ],
        ));
  }
}
