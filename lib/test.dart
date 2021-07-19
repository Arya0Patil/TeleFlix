import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:telemovies/bollywoodSearch.dart';
import 'package:url_launcher/url_launcher.dart';




//*******************************Bollywood Movie Screen*********************************************** */


class Bollywood_Scree extends StatefulWidget {

  @override
  _Bollywood_ScreeState createState() => _Bollywood_ScreeState();
}

class _Bollywood_ScreeState extends State<Bollywood_Scree> {

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

  final snackBar = SnackBar(content: Padding(
    padding: const EdgeInsets.all(10.0),
    child: Text(' Link Copied, Now paste in Browser ',
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

          child: Container(
            width: double.infinity,
            height: 200.0,

            child: Row(
              children: [

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
                            return ListView(scrollDirection: Axis.horizontal,

                              children:
                              snapshot.data.docs.map((doc) {
                                return InkWell(
                                  onTap: () {},
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children:<Widget> [
                                          Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8.0)),
                                            elevation: 0.0,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(8.0),
                                              child: Image.network(
                                                doc['Poster'],
                                                fit: BoxFit.fill,
                                                width: 130.0,
                                                height: 159.0,
                                              ), //imgasset
                                            ), //cliprect
                                          ),
                                        ],
                                      ), //card
                                      SizedBox(height: 5.0),
                                      Text(
                                        doc['Title'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                        ), //textstyle
                                        textAlign: TextAlign.start,
                                      ), //Text
                                      // SizedBox(height: 5.0), //Sizedbox
                                    ],
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

      ),
    ); //scaffold
  }
}



// ElevatedButton(onPressed: () {
// Clipboard.setData(ClipboardData(text: doc['DownloadLink']));
// label: Text('Get Link');
// },),