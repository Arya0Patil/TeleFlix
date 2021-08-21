import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:telemovies/screens/auth_screen.dart';
import 'package:telemovies/screens/chatScreen.dart';
import 'package:unity_ads_plugin/unity_ads.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:telemovies/ad_helper.dart';

class chatScreen extends StatefulWidget {
  @override
  _chatScreenState createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {
  @override
  initState() {
    super.initState();

    UnityAds.init(
      gameId: "4217249",
      testMode: false,
    );
  }

  void loadVideoAd() async {
    UnityAds.isReady(placementId: "Rewarded_Android").then((value) {
      if (value == true) {
        UnityAds.showVideoAd(
          placementId: "Rewarded_Android",
        );
      } else {
        print('ads not loaded');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: Container(
      //   height: 75.0,
      //   padding: EdgeInsets.all(10.0),
      //   child: UnityBannerAd(placementId: "Banner_Android"),
      // ),
      body: ListView(
        children: [
          Container(
            height: 75.0,
            child: AdWidget(
              key: UniqueKey(),
              ad: AdHelper.createBannerAd()..load(),
            ),
          ),

          Container(
            height: 250,
            width: 300,
            child: Center(
              child: Lottie.asset('animations/chatAnim.json'),
            ),
          ),

          // ListView(
          //   children:[ Container(
          //     child: Lottie.asset('animations/chatAnim.json'),),]
          //
          //     ),

          Padding(
            padding: const EdgeInsets.fromLTRB(90.0, 10.0, 90.0, 10.0),
            child: ElevatedButton(
                onPressed: () async {
                  loadVideoAd();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StreamBuilder(
                            stream: FirebaseAuth.instance.authStateChanges(),
                            builder: (ctx, userSnapshot) {
                              if (userSnapshot.hasData) {
                                return ChatScreen();
                              }
                              return AuthScreen1();
                            }),
                      ));
                  ;
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(child: Text('Live Chat')),
                    Icon(Icons.arrow_forward),
                  ],
                )),
          ),
          Container(
            height: 100,
            child: AdWidget(
              key: UniqueKey(),
              ad: BannerAd2.createBannerAd()..load(),
            ),
          ),
          // Container(
          //   child: AdWidget(
          //     key: UniqueKey(),
          //     ad: AdHelper.createBannerAd()..load(),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(90.0, 10.0, 90.0, 10.0),
          //   child: ElevatedButton(
          //       onPressed: (){adHelper.showRewardedAd();},
          //       child: Container(child: Text('Support'))
          //   ),
          // )
        ],
      ),
    );
  }
}
