import 'package:facebook_audience_network/facebook_audience_network.dart';
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
    // adHelper.loadRewardedAd();
    super.initState();
    FacebookAudienceNetwork.init();

    UnityAds.init(
      gameId: "4217249",
      testMode: false,
    );
  }

  showInterf() {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: "406069140874705_406383484176604",
      listener: (result, value) {
        if (result == InterstitialAdResult.LOADED)
          FacebookInterstitialAd.showInterstitialAd(delay: 2000);
      },
    );
  }

  // void loadVideoAd() async {
  //   UnityAds.isReady(placementId: "Rewarded_Android").then((value) {
  //     if (value == true) {
  //       UnityAds.showVideoAd(
  //         placementId: "Rewarded_Android",
  //       );
  //     } else {
  //       print('ads not loaded');
  //     }
  //   });
  // }

  // AdHelper adHelper = new AdHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // bottomNavigationBar: Container(
      //   height: 75.0,
      //   padding: EdgeInsets.all(10.0),
      //   child: UnityBannerAd(placementId: "Banner_Android"),
      // ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.pink[50], Colors.pink[100]])),
        child: ListView(
          children: [
            // Container(
            //   height: 75.0,
            //   child: AdWidget(
            //     key: UniqueKey(),
            //     ad: AdHelper.createBannerAd()..load(),
            //   ),
            // ),

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
                    showInterf();
                    // adHelper.showRewardedAd();
                    // adHelper.loadRewardedAd();
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
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(child: Text('Live Chat')),
                      Icon(Icons.arrow_forward),
                    ],
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: FacebookBannerAd(
                keepAlive: true,
                placementId: "406069140874705_406095640872055",
              ),
            ),

            Container(
              child: FacebookBannerAd(
                keepAlive: true,
                placementId: "406069140874705_406094160872203",
              ),
            ),
            Center(
              child: Container(
                  child: UnityBannerAd(
                placementId: "Banner_Android",
              )),
            ),

            // Padding(
            //   padding: const EdgeInsets.fromLTRB(90.0, 10.0, 90.0, 10.0),
            //   child: ElevatedButton(
            //       onPressed: (){adHelper.showRewardedAd();},
            //       child: Container(child: Text('Support'))
            //   ),)
          ],
        ),
      ),
    );
  }
}
