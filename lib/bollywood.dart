import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

//*******************************Bollywood Movie Screen*********************************************** */

class Bollywood_Screen extends StatefulWidget {
  @override
  _Bollywood_ScreenState createState() => _Bollywood_ScreenState();
}

class _Bollywood_ScreenState extends State<Bollywood_Screen> {
  // TextEditingController _searchController = TextEditingController();
  // Map<String, dynamic> userMap;
  //
  //
  // void onSearch() async{
  //   FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //   await _firestore.collection('HMovies')
  //       .where('Htitle', isEqualTo: _searchController.text)
  //       .get()
  //       .then((value){
  //     setState(() {
  //       userMap= value.docs[0].data();
  //     });
  //     print(userMap);
  //   });
  // }
  //
  // @override
  // // void initState(){
  // //
  // //   super.initState();
  // //   _searchController.addListener(_onSearchChanged);
  // // }
  // //
  // // @override
  // // void dispose(){
  // //   _searchController.removeListener(_onSearchChanged);
  // //   _searchController.dispose();
  // //   super.dispose();
  // // }
  // //
  // _onSearchChanged(){
  //   print(_searchController.text);
  // }

  final db = FirebaseFirestore.instance;

  final snackBar = SnackBar(
    content: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        ' Link Copied to Clipboard ',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
    backgroundColor: Colors.lightBlue,
    behavior: SnackBarBehavior.floating,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        title: Text('Bollywood Movies'),
        elevation: 1.0,
        backgroundColor: Color(0xFF1B2C38),
        // actions: <Widget>[
        //   IconButton(
        //     onPressed: () {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) => BollywoodSearch()));
        //     },
        //     icon: Icon(Icons.search),
        //   ), //iconbutton
        // ], //action widget
      ), //appbar

      body: Container(
        child: Column(
          children: <Widget>[
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
            //   child: TextField(
            //     controller: _searchController,
            //     decoration: InputDecoration(
            //       prefixIcon: Icon(Icons.search),
            //         suffixIcon: IconButton(
            //           icon: Icon(Icons.send),
            //           onPressed: (){
            //             onSearch();
            //           }
            //         ),
            //
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(50.0)),
            //       ),
            //       hintText: "Search Movie"
            //     ),
            //   ),
            // ),
            // userMap!= null
            // ? ListTile(
            //   title: Text(userMap['HTitle']),
            // ):Container(),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: db.collection('Movies').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else
                    return ListView(
                      children: snapshot.data.docs.map<Widget>((doc) {
                        return Card(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: ListTile(
                              // leading: Image.network(doc['Poster'], fit: BoxFit.fill,
                              //   width: 100.0,
                              //   height: 200.0,),
                              title: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(doc['Title']),
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.send,
                                ),
                                iconSize: 25,
                                color: Colors.green,
                                splashColor: Colors.purple,
                                onPressed: () {
                                  String _url = doc['DownloadLink'];
                                  void _launchURL() async =>
                                      await canLaunch(_url)
                                          ? await launch(_url)
                                          : throw 'Could not launch $_url';
                                  _launchURL();

                                  Clipboard.setData(
                                      ClipboardData(text: doc['DownloadLink']));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
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
                          ),
                        );
                      }).toList(),
                    );
                },
              ),
            ),
          ],
        ),
      ),
    ); //scaffold
  }
}



// ElevatedButton(onPressed: () {
// Clipboard.setData(ClipboardData(text: doc['DownloadLink']));
// label: Text('Get Link');
// },),