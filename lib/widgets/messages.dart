import 'package:telemovies/widgets/messageFormat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.value(FirebaseAuth.instance.currentUser),
        builder: (ctx, futureSnapshot) {
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .orderBy('time', descending: true)
                  .snapshots(),
              builder: (ctx, chatsSnapshot) {
                if (chatsSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                    reverse: true,
                    itemCount: chatsSnapshot.data.docs.length,
                    itemBuilder: (ctx, index) => MessageBubble(
                          chatsSnapshot.data.docs[index]['text'],
                          chatsSnapshot.data.docs[index]['username'],
                          chatsSnapshot.data.docs[index]['userId'] ==
                              '83XXUYAOAxU5IjMSBKgdyyUhkSA3',
                          //futureSnapshot.data.uid,

                          // key: ValueKey(
                          //     chatsSnapshot.data.docs[index].documentID),
                        ));
              });
        });
  }
}
