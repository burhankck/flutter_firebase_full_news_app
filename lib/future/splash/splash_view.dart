import 'package:flutter/material.dart';
import 'package:flutter_firebase_full_news_app/future/home/home_view.dart';
import 'package:flutter_firebase_full_news_app/future/splash/splash_provider.dart';
import 'package:flutter_firebase_full_news_app/product/constants/color_constants.dart';

import 'package:flutter_firebase_full_news_app/product/enums/image_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

import '../../product/widget/text/wavy_text.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>
    with _SplashViewListenMixin {
  final splashProvider =
      StateNotifierProvider<SplashProvider, SplashState>((ref) {
    return SplashProvider();
  });
  @override
  void initState() {
    super.initState();

    // ignore: deprecated_member_use
    ref.read(splashProvider.notifier).checkApplicationVersion(''.version);
  }

  @override
  Widget build(BuildContext context) {
    listenAndNavigate(splashProvider);
    return Scaffold(
      backgroundColor: ColorConstants.purpleDark,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconConstants.appIcon.toImage,
          const Padding(padding: EdgeInsets.only(top: 25)),
          const WavyText(),
        ]),
      ),
    );
  }
}

mixin _SplashViewListenMixin on ConsumerState<SplashView> {
  void listenAndNavigate(
      StateNotifierProvider<SplashProvider, SplashState> provider) {
    ref.listen(provider, (previous, next) {
      if (next.isRequiredForceUpdate ?? false) {
        showAboutDialog(context: context);
        return;
      }

      if (next.isRedirectHome != null) {
        if (next.isRedirectHome!) {
          // ignore: deprecated_member_use
          context.navigateToPage(const HomeView());
        } else {
          //false
        }
      }
    });
  }
}
