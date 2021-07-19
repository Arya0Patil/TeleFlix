
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
  
  @override initState(){
    super.initState();

    UnityAds.init(gameId: "4217249",
    testMode: false,
    );
  }

  void loadVideoAd()async{
    UnityAds.isReady(placementId: "Rewarded_Android").then((value) {
      if(value== true){
        UnityAds.showVideoAd(placementId: "Rewarded_Android",

        );
      }else{
        print('ads not loaded');
      }
    });
  }
  AdHelper adHelper = new AdHelper();
  @override

  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: Container(
        height: 75.0,
        padding: EdgeInsets.all(10.0),
        child: UnityBannerAd(placementId: "Banner_Android"),
      ),
      body: ListView(
          children: [
            Container(
             height: 50.0,
              decoration: BoxDecoration(
              color: Colors.orange,

            ),
            child: Center(
              child: Text('Live Chat Will Be Active Soon',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),),
            ),
          ),

          Container(
            height: 20.0,
            decoration: BoxDecoration(
              color: Colors.orange,
            ),
            child: Center(
              child: Text('Your Support Helps Us Build Faster',
              style: TextStyle(
                fontWeight: FontWeight.bold,

              ),),
            ),
          ),
            Container(

              height: 75.0,
              child: AdWidget(key: UniqueKey(),ad: AdHelper.createBannerAd()..load(),),
            ),

          Container(
            height: 300.0,
            width: 120.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://cdni.iconscout.com/illustration/premium/thumb/mobile-application-coding-3391184-2822002.png'),
                fit: BoxFit.fill,
              ),

            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(90.0, 10.0, 90.0, 10.0),
            child: ElevatedButton(
                onPressed: (){
                  loadVideoAd();
                },
                child: Container(child: Text('View Ad'))
            ),
          ),
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
