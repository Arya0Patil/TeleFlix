import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class BollywoodSearch extends StatefulWidget {


  @override
  _BollywoodSearchState createState() => _BollywoodSearchState();
}

class _BollywoodSearchState extends State<BollywoodSearch> {
  final TextEditingController searchController = TextEditingController();
  final database = FirebaseFirestore.instance;
  String searchString;


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
      backgroundColor: Color(0xffFF616D),
      appBar: AppBar(
        title: Text('Bollywood Movies'),
        backgroundColor: Color(0xff303960),
      ),

      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  child: TextField(
                    controller: searchController,

                    decoration: InputDecoration(

                      suffixIcon: IconButton(onPressed: ()=> searchController.clear() ,
                          icon: Icon(Icons.clear)),
                      hintText: 'Search Movies',
                      filled: true,
                      fillColor: Colors.white,

                    ),
                    onChanged: (val){
                      setState(() {
                        searchString= val.toLowerCase();
                      });
                    },
                  )
              ),
            ),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: (searchString == null || searchString.trim()== '')
                    ? FirebaseFirestore.instance.collection('Movies').snapshots()
                    : FirebaseFirestore.instance.collection('Movies').where('searchIndex', arrayContains: searchString).snapshots(),

                builder: (context, snapshot){
                  if(snapshot.hasError){
                    return Text ("Oops, We ran Into error, Try again later${snapshot.error}");
                  }
                  switch(snapshot.connectionState){
                    case ConnectionState.waiting:
                      return SizedBox(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    case ConnectionState.none :
                      return Text('Check your Connection');

                    case ConnectionState.done:
                      return Text('Done!!');

                    default:
                      return new ListView(
                        children: snapshot.data.docs.map((DocumentSnapshot document){
                          return  Card(
                            child: new ListTile(
                              title: Text(document['Title']),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.send,
                                ),
                                iconSize: 25,
                                color: Colors.green,
                                splashColor: Colors.purple,
                                onPressed: () {
                                  String _url = document['DownloadLink'];
                                  void _launchURL() async =>
                                      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
                                  _launchURL();

                                  Clipboard.setData(ClipboardData(text: document['DownloadLink']));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                },
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10.0,0.0, 5.0),
                                child: Text(document['rdate']),
                              ),
                            ),
                          );
                        }).toList(),
                      );

                  }
                },

              ),
            ),
          ],
        ),
      ),
    );
  }
}
