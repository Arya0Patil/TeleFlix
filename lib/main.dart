import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_audience_network/ad/ad_banner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:telemovies/bollywood.dart';
import 'package:telemovies/marathi.dart';
import 'package:telemovies/screens/auth_screen.dart';
import 'package:telemovies/screens/chatScreen.dart';
import 'package:unity_ads_plugin/unity_ads.dart';
import 'package:url_launcher/url_launcher.dart';
import 'chatscreen.dart';

import 'bollywoodSearch.dart';
import 'hollywoodSearch.dart';
import 'ad_helper.dart';
import 'regionalHits.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  // AdHelper.initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TeleFlix',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ), //themedata
      home: DefaultTabController(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 20.0,
            backgroundColor: Color(0xff303960),
            title: Text('TeleFlix '), //title
            // actions: <Widget>[
            //   IconButton(
            //     //search
            //     onPressed: () {},
            //     icon: Icon(Icons.search),
            //   ), //iconbutton
            // ], //action widget
            bottom: TabBar(
              indicatorColor: Colors.grey,
              labelColor: Color(0xffFF616D),
              unselectedLabelColor: Colors.grey,
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.movie),
                  text: 'Movies',
                ), //tab
                Tab(
                  icon: Icon(Icons.chat),
                  text: 'Request Movie',
                ), //tab
              ],
            ), //tabbar
          ),
          // drawer: Drawer(
          //   child: ListView(
          //     padding: EdgeInsets.zero,
          //     children: [
          //       DrawerHeader(
          //         child: Text(
          //           "Teleflix",
          //           style: TextStyle(
          //             fontSize: 25.0,
          //             color: Colors.white,
          //           ),
          //         ),
          //         decoration: BoxDecoration(
          //           color: Color(0xff303960),
          //         ),
          //       ),
          //       ListTile(
          //         title: Text(
          //           'Rate Us',
          //           style: TextStyle(fontSize: 20.0),
          //         ),
          //         onTap: () {
          //           const _url =
          //               'https://play.google.com/store/apps/details?id=com.telemovie.tech';
          //           void _launchURL() async => await canLaunch(_url)
          //               ? await launch(_url)
          //               : throw 'Could not launch $_url';
          //           _launchURL();
          //         },
          //       ),
          //       ListTile(
          //         title: Text(
          //           "Request Movie",
          //           style: TextStyle(fontSize: 20.0),
          //         ),
          //         onTap: () {
          //           Navigator.push(context,
          //               MaterialPageRoute(builder: (context) => MarathiHits()));
          //         },
          //       ),
          //       ListTile(
          //         title: DropdownButton(
          //           underline: SizedBox(),
          //           items: [
          //             DropdownMenuItem(
          //               child: Container(
          //                 width: 240,
          //                 child: Text(
          //                     "We incur costs to keep the app functional. Ads helps us to do so while keeping our app free to use."),
          //               ),
          //             ),
          //           ],
          //           onChanged: (ctx) {},
          //           hint: Text(
          //             "Why Ads",
          //             style: TextStyle(
          //                 color: Colors.black,
          //                 fontSize: 20.0,
          //                 fontWeight: FontWeight.w500),
          //           ),
          //           // icon: Icon(
          //           //   Icons.arrow_drop_down_circle,
          //           //   color: Colors.white,
          //           // ),
          //         ),
          //       )
          //     ],
          //   ),
          // ), //appbar
          body: TabBarView(
            children: <Widget>[
              MovieApp(),
              chatScreen(),
              // StreamBuilder(
              //     stream: FirebaseAuth.instance.authStateChanges(),
              //     builder: (ctx, userSnapshot) {
              //       if (userSnapshot.hasData) {
              //         return ChatScreen();
              //       }
              //       return AuthScreen1();
              //     }),
            ],
          ), //tabbarview
        ), //scaffold

        length: 2,
        initialIndex: 0,
      ), //tabcontrol
    ); //materialapp
  }
}

//***********movie screen******************movie screen************

class MovieApp extends StatefulWidget {
  @override
  _MovieAppState createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  @override
  initState() {
    final fbm = FirebaseMessaging;
    // When the app is completely closed (not in the background) and opened directly from the push notification
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      print('getInitialMessage data: ${message.data}');
    });

    //App is open and recievs notif
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
    });

    // replacement for onResume: When the app is in the background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessageOpenedApp data: ${message.data}');
    });
    super.initState();
    // adHelper.createInterAd();
    // UnityAds.init(
    //   gameId: "4217249",
    //   testMode: false,
    // );
  }

  // void loadVideoAd() async {
  //   UnityAds.isReady(placementId: "bmi").then((value) {
  //     if (value == true) {
  //       UnityAds.showVideoAd(
  //         placementId: "bmi",
  //       );
  //     } else {
  //       print('ads not loaded');
  //     }
  //   });
  // }

  final db = FirebaseFirestore.instance;
  // AdHelper adHelper = new AdHelper();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xff132743), Color(0xff31112c)])),
      child: Scaffold(
        bottomNavigationBar: FacebookBannerAd(
          keepAlive: true,
          placementId: "406069140874705_406094160872203",
        ),

        // AdWidget(
        //   key: UniqueKey(),
        //   ad: AdHelper.createBannerAd()..load(),s

        backgroundColor: Colors.transparent,
        //     The JKS keystore uses a proprietary format. It is recommended to migrate to PKCS12 which is an industry standard format using "keytool -importkeystore -
        // srckeystore c:\Users\one\upload-keystore.jks -destkeystore c:\Users\one\upload-keystore.jks -deststoretype pkcs12".

        body: Padding(
          padding: const EdgeInsets.only(top: 1.0),
          child: ListView(
            children: [
              SizedBox(height: 12.0), //sizedbox

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      "Featured ",
                      style: TextStyle(
                        color: Color(0xffFC8621),
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ), //textstyle
                      textAlign: TextAlign.start,
                    ), //text
                  ), //padding
                ],
              ), //row
              SizedBox(height: 11.0),
              Container(
                width: double.infinity,
                height: 200.0,
                child: Row(
                  children: [
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: db.collection('featured').snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else
                            return ListView(
                              scrollDirection: Axis.horizontal,
                              children: snapshot.data.docs.map((doc) {
                                return InkWell(
                                  onTap: () {
                                    String _url = doc['dlink'];
                                    void _launchURL() async =>
                                        await canLaunch(_url)
                                            ? await launch(_url)
                                            : throw 'Could not launch $_url';
                                    _launchURL();
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0)),
                                            elevation: 0.0,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                doc['poster'],
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
                                        doc['title'],
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

              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    elevation: 0,
                  ),
                  child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFcc0e74).withAlpha(60),
                          blurRadius: 6.0,
                          spreadRadius: 2.0,
                          offset: Offset(
                            0.0,
                            3.0,
                          ),
                        ),
                      ],
                      gradient: LinearGradient(colors: [
                        Color(0xff03506F),
                        Color(0xffFF616D)
                      ]), //gradient

                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ), //boxdecoration
                    child: Center(
                      child: Text(
                        'Bollywood Movies ',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'avenir',
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ), //textstyle
                      ), //text
                    ), //center
                  ),
                  onPressed: () {
                    // loadVideoAd();
                    // adHelper.createInterAd();

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BollywoodSearch()));
                  },
                ), //flatbutton
              ),

              //testing
              // Padding(
              //   padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
              //   child: ElevatedButton(
              //
              //     style: ElevatedButton.styleFrom(
              //       primary: Colors.transparent,
              //       elevation: 0,
              //     ),
              //
              //     child: Container(
              //
              //       height: 50.0,
              //       decoration: BoxDecoration(
              //         boxShadow: [
              //           BoxShadow(
              //             color: Color(0xFFcc0e74).withAlpha(60),
              //             blurRadius: 6.0,
              //             spreadRadius: 2.0,
              //             offset: Offset(
              //               0.0,
              //               3.0,
              //             ),
              //           ),
              //         ],
              //         gradient: LinearGradient(colors: [
              //           Color(0xff03506F),
              //           Color(0xffFF616D)
              //         ]), //gradient
              //
              //         borderRadius: BorderRadius.all(Radius.circular(10.0)),
              //       ), //boxdecoration
              //       child: Center(
              //         child: Text(
              //           'Test ',
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontFamily: 'avenir',
              //             fontWeight: FontWeight.bold,
              //             fontSize: 20.0,
              //           ), //textstyle
              //         ), //text
              //       ), //center
              //     ), //container ,
              //     onPressed: () {
              //
              //
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => Bollywood_Scree()));
              //     },
              //   ), //flatbutton
              // ),//padding//box ..//testing

              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    elevation: 0,
                  ),
                  child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFcc0e74).withAlpha(60),
                          blurRadius: 6.0,
                          spreadRadius: 2.0,
                          offset: Offset(
                            0.0,
                            3.0,
                          ),
                        ),
                      ],
                      gradient: LinearGradient(colors: [
                        Color(0xff03506F),
                        Color(0xffFF616D)
                      ]), //gradient

                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ), //boxdecoration
                    child: Center(
                      child: Text(
                        'Hollywood Movies ',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'avenir',
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ), //textstyle
                      ), //text
                    ), //center
                  ), //container ,
                  onPressed: () {
                    // adHelper.createInterAd();

                    // adHelper.showInterAd();

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HollywoodSearch()));
                  },
                ), //flatbutton
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    elevation: 0,
                  ),
                  child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFcc0e74).withAlpha(60),
                          blurRadius: 6.0,
                          spreadRadius: 2.0,
                          offset: Offset(
                            0.0,
                            3.0,
                          ),
                        ),
                      ],
                      gradient: LinearGradient(colors: [
                        Color(0xff03506F),
                        Color(0xffFF616D)
                      ]), //gradient

                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ), //boxdecoration
                    child: Center(
                      child: Text(
                        'Marathi Hits ',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'avenir',
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ), //textstyle
                      ), //text
                    ), //center
                  ), //container ,
                  onPressed: () {
                    // adHelper.createInterAd();
                    // adHelper.showInterAd();

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MarathiHits()));
                  },
                ), //flatbutton
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    elevation: 0,
                  ),
                  child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFcc0e74).withAlpha(60),
                          blurRadius: 6.0,
                          spreadRadius: 2.0,
                          offset: Offset(
                            0.0,
                            3.0,
                          ),
                        ),
                      ],
                      gradient: LinearGradient(colors: [
                        Color(0xff03506F),
                        Color(0xffFF616D)
                      ]), //gradient

                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ), //boxdecoration
                    child: Center(
                      child: Text(
                        'Regional Hits ',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'avenir',
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ), //textstyle
                      ), //text
                    ), //center
                  ), //container ,
                  onPressed: () {
                    // adHelper.createInterAd();
                    // adHelper.showInterAd();

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegionalSearch()));
                  },
                ), //flatbutton
              ),
            ], //listveiwchildren
          ), //listveiw
        ), //padding
      ),
    ); //cont for gradient
  }

  Widget MovieCard(String movieName, String imgPath) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            elevation: 0.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                imgPath,
                fit: BoxFit.fill,
                width: 130.0,
                height: 159.0,
              ), //imgasset
            ), //cliprect
          ), //card
          SizedBox(height: 5.0),
          Text(
            movieName,
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
    ); //inkwell
  }
} //moveiappstate class

//******************************************************************* */
class MoviesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.blue,
    );
  }
}

//****************************Hollywood movie screen************************************ */
// class Hollywood_Screen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Hollywood Movies'),
//         elevation: 1.0,
//         backgroundColor: Color(0xFF1B2C38),
//         actions: <Widget>[
//           IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.search),
//           ), //iconbutton
//         ], //action widget
//       ), //appbar
//     ); //scaffold
//   }
// }

// class SearchMovie extends SearchDelegate<MovieApp> {
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {},
//       )
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {},
//       icon: Icon(Icons.arrow_back),
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return null;
//   }

//   @override
//   List<Widget> buildSuggetions(BuildContext context) {
//     final myList= MyApp();
//     return ListView.builder(
//       itemCount: mylist.length,
//       itemBuilder: (context,index){
//         final MyApp listitem = myList[index];
//         return ListTitle(title: Text(MovieCard.movieName),);
//       });
//     }

//   }
// }
