import'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';


//*******************************Bollywood Movie Screen*********************************************** */

class MarathiHits extends StatefulWidget {
  // static const _url = 'https://google.com';
  // void _launchURL() async =>
  //     await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

  @override
  _MarathiHitsState createState() => _MarathiHitsState();
}

class _MarathiHitsState extends State<MarathiHits> {


  final mdb = FirebaseFirestore.instance;

  final snackBar = SnackBar(content: Padding(
    padding: const EdgeInsets.all(10.0),
    child: Text(' Link Copied ',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
  )
    ,backgroundColor: Colors.lightBlue,
    behavior: SnackBarBehavior.floating,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff31112c),
      appBar: AppBar(
        title: Text('Marathi Hits'),
        elevation: 1.0,
        backgroundColor: Color(0xFF1B2C38),
        // actions: <Widget>[
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(Icons.search),
        //   ), //iconbutton
        // ], //action widget
      ), //appbar

      body: StreamBuilder<QuerySnapshot>(
        stream: mdb.collection('marathi').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            return ListView(

              children: snapshot.data.docs.map((doc) {
                return Card(
                  child: ListTile(
                    // leading: Image.network(doc['poster'], fit: BoxFit.fill,
                    //   width: 100.0,
                    //   height: 200.0,),
                    title: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
                      child: Text(doc['title']),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.send,
                      ),
                      iconSize: 25,
                      color: Colors.green,
                      splashColor: Colors.purple,
                      onPressed: () {
                        String _url = doc['dlink'];
                        void _launchURL() async =>
                            await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
                        _launchURL();

                        Clipboard.setData(ClipboardData(text: doc['dlink']));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 5.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(doc['rdate']),
                        ),

                      ],
                    ),
                  ),
                );
              }).toList(),
            );
        },
      ),
    ); //scaffold
  }
}


// ElevatedButton(onPressed: () {
// Clipboard.setData(ClipboardData(text: doc['DownloadLink']));
// label: Text('Get Link');
// },),