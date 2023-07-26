// import 'package:flutter/material.dart';

// @immutable
// class ImageConstants {
//    ImageConstants._();
//  final  String microphone = 'ic_microphone.png'.icontoPng;
// }

// extension _StringPath on String {
//   String get icontoPng => 'assets/icon/$this.png';
// }

import 'package:flutter/material.dart';

enum IconConstants {
  microphone('ic_microphone'),
  appIcon('app_logo'),
  ;

  final String value;

  const IconConstants(this.value);

  String get toPng => 'assets/icon/ic_$value.png';
  Image get toImage => Image.asset(toPng);
}
