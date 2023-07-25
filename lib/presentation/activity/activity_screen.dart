import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:what_sholud_i_do_now/data/source/remote/bored_api.dart';
import 'package:what_sholud_i_do_now/presentation/activity/activity_state.dart';
import 'package:what_sholud_i_do_now/presentation/activity/activity_view_model.dart';
import 'package:what_sholud_i_do_now/presentation/home/home_screen.dart';
import 'package:what_sholud_i_do_now/utils/app_colors.dart';
import 'package:what_sholud_i_do_now/utils/util_widget/shrink_button.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {


  String admobFrontId = 'ca-app-pub-2807201744264927/3115399997'; //전면광고 ID
  String admobBannerId = 'ca-app-pub-2807201744264927/8709409970'; //배너광고 ID

  // String admobTestId = 'ca-app-pub-3940256099942544/1033173712'; //테스트 ID
  // String admobBannerTestId = 'ca-app-pub-3940256099942544/6300978111'; //테스트 ID

  InterstitialAd? _interstitialAd;
  BannerAd? banner;

  @override
  void initState() {
    super.initState();
    loadAd();
    initBanner();
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  /// 광고 초기화
  void loadAd() {

    InterstitialAd.load(
        adUnitId: admobFrontId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
              // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});

            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));

  }

  initBanner() {
    banner = BannerAd(
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError error) {},
        onAdLoaded: (_) {},
      ),
      size: AdSize.banner,
      adUnitId: admobBannerId,
      request: const AdRequest(),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ActivityViewModel>();
    final state = viewModel.state;

    return Scaffold(
      backgroundColor: AppColors.homeBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.black,
            height: 50,
            child: AdWidget(
              ad: banner!,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 16),
            child: Text(
              "랜덤으로 활동을 받아보세요!",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          !state.isActivity ?
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: () async {
                  viewModel.getActivity('', '', '', '');
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 300,
                  height: 300,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          "오늘 뭐하지?",
                          style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 50,
                        child: DefaultTextStyle(
                          style: const TextStyle(fontSize: 30, color: AppColors.homeBackgroundColor, fontWeight: FontWeight.bold),
                          child: AnimatedTextKit(
                            repeatForever: true,
                            animatedTexts: [
                              ScaleAnimatedText('누르기'),
                            ],
                            onTap: () {
                              viewModel.getActivity('', '', '', '');
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ) : state.isLoading ? loadingWidget() : activityWidget(state, viewModel, context)
        ],
      ),
    );
  }

  Widget loadingWidget() {
    return const Expanded(
      child: Center(
        child: Image(
            width: 250,
            height: 250,
            image: AssetImage('assets/images/gift.gif')),
      ),
    );
  }

  Widget activityWidget(ActivityState state, ActivityViewModel viewModel, BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment:  MainAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(  //모서리를 둥글게 하기 위해 사용
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 3.0, //그림자 깊이
              child: Material(
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  onTap: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('즐겨찾기에 추가하시겠습니까?', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w300),),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, '아니요'),
                          child: const Text('아니요', style: TextStyle(color: Colors.black),),
                        ),
                        TextButton(
                          onPressed: ()  {
                            viewModel.addFavoriteList(context);
                            // Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(
                            //   builder: (context) =>
                            //   const HomeScreen(pageIndex: 1),
                            // ), (route) => false);
                          },
                          child: const Text('네', style: TextStyle(color: Colors.blue),),
                        ),
                      ],
                    ),
                  ),
                  splashColor: Colors.grey,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    width: 300,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      state.activity.activity,
                      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: ShrinkButton(
                onPressed: () {
                  Future.delayed(const Duration(milliseconds: 300), () async {

                    if(viewModel.getActivityCount >= 5 ){

                      loadAd();

                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('더 많은 활동을 뽑기위해 광고를 시청하시겠습니까?', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w300),),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, '아니요'),
                              child: const Text('아니요', style: TextStyle(color: Colors.black),),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.pop(context, '네');

                                viewModel.getActivityCount = 0;

                                _interstitialAd?.show();

                              },
                              child: const Text('네', style: TextStyle(color: Colors.blue),),
                            ),
                          ],
                        ),
                      );

                    }else{
                      viewModel.getActivity('', '', '', '');
                    }

                  });
                },
                child: const Text(
                  '다시 뽑기',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
