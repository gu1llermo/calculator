import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:calculator_app/presentation/providers/calc_provider.dart';

const Icon iconHistory = Icon(
  Icons.history_rounded,
  //color: Colors.white,
  size: 30,
);

class HistoryButton extends ConsumerStatefulWidget {
  const HistoryButton({super.key, required this.heightFactor});
  final double heightFactor;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryButtonState();
}

class _HistoryButtonState extends ConsumerState<HistoryButton> {
  RewardedAd? _rewardedAd;
  bool _isUserEarnedReward = false;
  // TODO: replace this test ad unit with your own ad unit.
  final adRewardUnitId = 'ca-app-pub-3940256099942544/5224354917'; // Test
  bool _isRewardedAd = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadRewardAd();
  }

  @override
  void dispose() {
    _rewardedAd?.dispose();
    super.dispose();
  }

  /// Loads a rewarded ad.
  void loadRewardAd() {
    RewardedAd.load(
        adUnitId: adRewardUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            // debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            _rewardedAd = ad;
            _isRewardedAd = true;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            // debugPrint('RewardedAd failed to load: $error');
            _isRewardedAd = false;
          },
        ));
  }

  void showRewardAd() {
    debugPrint('_isRewardedAd $_isRewardedAd');
    if (_isRewardedAd) {
      _rewardedAd?.show(
          onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
        // Reward the user for watching an ad.
        // la recompensa es que use la app
        // debugPrint('onUserEarnedReward!');
        _isUserEarnedReward = true;
        _rewardedAd?.dispose();
        loadRewardAd();
      });
    } else {
      loadRewardAd();
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          // muestra anuncio
          showRewardAd();
          displayHistorial(context, ref, widget.heightFactor);
        },
        icon: iconHistory);
  }
}

Future<void> displayHistorial(
    BuildContext context, WidgetRef ref, double heightFactor) async {
  final historial = ref.read(historialProvider);

  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: heightFactor,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: historial.length,
                  itemBuilder: (context, index) {
                    final data = historial[index].split(' ');
                    final title = data[0];
                    final subtitle = data[1];
                    return ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      title: Text(
                        title,
                        textAlign: TextAlign.end,
                      ),
                      subtitle: Text(subtitle, textAlign: TextAlign.end),
                    );
                  },
                ),
              ),
              IconButton(
                  onPressed: () {
                    ref.read(historialProvider.notifier).clear();
                    context.pop();
                  },
                  icon: const Icon(Icons.delete_forever_rounded))
            ],
          ),
        );
      });
}
