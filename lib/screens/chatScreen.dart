import 'dart:io';

import 'package:telemovies/widgets/messages.dart';
import 'package:telemovies/widgets/newMessages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            DropdownButton(
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text('Logout')
                      ],
                    ),
                  ),
                  value: 'logout',
                ),
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            )
          ],
          title: Text('Chatzz'),
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: Messages(),
              ),
              NewMessage(),
            ],
          ),
        )

        // body: StreamBuilder(
        //     stream: FirebaseFirestore.instance
        //         .collection('chat/XJljm9UsUkfoMQwyT6lN/messages')
        //         .snapshots(),
        //     builder: (ctx, streamSnapshot) {
        //       if (streamSnapshot.connectionState == ConnectionState.waiting) {
        //         return Center(
        //           child: CircularProgressIndicator(),
        //         );
        //       }
        //       final docss = streamSnapshot.data.docs;
        //       return ListView.builder(
        //         itemCount: docss.length,
        //         itemBuilder: (ctx, index) => Container(
        //           padding: EdgeInsets.all(8.0),
        //           child: Text(docss[index]['text']),
        //         ),
        //       );
        //     })

        // ListView.builder(
        //   itemCount: 10,
        //   itemBuilder: (ctx, index) => Container(
        //     padding: EdgeInsets.all(8.0),
        //     child: Text('hii'),
        //   ),
        // ),
        );
  }
}