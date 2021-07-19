import'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'hollywoodSearch.dart';


//*******************************Bollywood Movie Screen*********************************************** */

class Hollywood_Screen extends StatefulWidget {

  @override
  _Hollywood_ScreenState createState() => _Hollywood_ScreenState();
}

class _Hollywood_ScreenState extends State<Hollywood_Screen> {
  // Map<String, dynamic> userMap;
  //
  // final TextEditingController _searchController = TextEditingController();
  // void onSearch() async{
  //   FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // await _firestore.collection('HMovies')
  //     .where('Htitle', isEqualTo: _searchController.text)
  //     .get()
  //   .then((value){
  //     setState(() {
  //       userMap= value.docs[0].data();
  //     });
  //     print(userMap);
  // });
  // }

  final hdb = FirebaseFirestore.instance;

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
    behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
          label:'Click',
        onPressed:(){}
  ),);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff31112c),
      appBar: AppBar(

        title: Text('Hollywood Movies'),
        elevation: 1.0,
        backgroundColor: Color(0xFF1B2C38),
        actions: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HollywoodSearch()));
          },
          icon: Icon(Icons.search),
        ), //iconbutton
        ], //action widget
      ), //appbar

      body: StreamBuilder<QuerySnapshot>(
        stream: hdb.collection('HMovies').snapshots(),
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
                    // leading: Image.network(doc['HPoster'], fit: BoxFit.fill,
                    //   width: 100.0,
                    //   height: 200.0,),
                    title: Text(doc['Htitle']),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.send,
                      ),
                      iconSize: 25,
                      color: Colors.green,
                      splashColor: Colors.purple,
                      onPressed: () {
                        String _url = doc['HDownloadLink'];
                        void _launchURL() async =>
                            await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
                        _launchURL();

                        Clipboard.setData(ClipboardData(text: doc['HDownloadLink']));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(doc['Hdate']),
                        ),
                        Text('Copy Link And Paste In Browser'),
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