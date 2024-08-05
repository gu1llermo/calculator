import 'package:calculator_app/presentation/widgets/shared/landscape/landscape_view.dart';
import 'package:calculator_app/presentation/widgets/shared/portrait/portrait_view.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const iconStar = Icon(
  Icons.star,
  color: Colors.yellow,
);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String path = '/';
  static const String name = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  BannerAd? _bannerAd;
  bool _isBannerLoaded = false;

  // TODO: replace this test ad unit with your own ad unit.

  final adBannerUnitId =
      'ca-app-pub-3940256099942544/6300978111'; // bannerTestId

  @override
  void initState() {
    super.initState();
    // Load ads.

    loadBannerAd();
  }

  /// Loads a banner ad.
  void loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: adBannerUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          // debugPrint('$ad loaded.');
          // cuando se usa el setState no me gusta porque
          // setState(() {
          //   debugPrint('SetState');
          // });
          // me parece que tiene que hacer el setState
          // para que cambie el anuncio
          // _isBannerLoaded = true;
          // setState(() {
          //   _isBannerLoaded = true;
          // });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          // debugPrint('BannerAd failed to load: $err');
          // _isBannerLoaded = false;
          // setState(() {
          //   _isBannerLoaded = false;
          // });
          // ad.dispose();
        },
        // onAdImpression: (Ad ad) {
        //   debugPrint('Aqui dos');
        // },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // portrait es vertical
    // lanscape es horizontal cuando se gira el celular
    final mediaQuery = MediaQuery.of(context);

    // final orientation = mediaQuery.orientation;
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;
    bool isPortrait = width < 600;
    // bool isPortrait = orientation == Orientation.portrait;

    return SingleChildScrollView(
      child: Stack(
        // alignment: Alignment.bottomCenter,
        children: [
          const _GradientBackground(),
          SizedBox(
            height: height,
            width: width,
            child: Column(
              children: [
                AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  title: getBanner(),
                ),
                // Container(
                //   height: 40,
                //   color: Colors.red,
                // ),
                Expanded(
                    child: isPortrait
                        ? const PortraitView()
                        : const LandscapeView()),
              ],
            ),
          ),
          //Estrellas(height: height, width: width)
        ],
      ),
    );
  }

  Widget getBanner() {
    // print('getBanner() ok!');
    return (_bannerAd == null)
        ? const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              iconStar,
              iconStar,
              iconStar,
              iconStar,
              iconStar,
              // iconStar,
              // iconStar,
              // iconStar,
            ],
          )
        : SafeArea(
            child: SizedBox(
              width: _bannerAd!.size.width.toDouble(),
              height: _bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            ),
          );
  }
}

class Estrellas extends StatelessWidget {
  const Estrellas({super.key, required this.height, required this.width});
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: height / 3,
        ),
        getStars(60),
        getStars(150),
        getStars(240),
        getStars(330),
      ],
    );
  }

  SizedBox getStars(double width) {
    return SizedBox(
      width: width,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [iconStar, iconStar],
      ),
    );
  }
}

class _GradientBackground extends StatelessWidget {
  const _GradientBackground();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1)),
        //decoration: const BoxDecoration(gradient: primaryGradient),
      ),
    );
  }
}
