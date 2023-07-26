import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';
import '../../constants/string_constants.dart';

class WavyText extends StatelessWidget {
  const WavyText({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      repeatForever: true,
      animatedTexts: [
        WavyAnimatedText(
          StringConstants.appName,
          textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: ColorConstants.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
