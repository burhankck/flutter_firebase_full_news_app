// import 'package:flutter/material.dart';

// @immutable
// class ImageConstants {
//    ImageConstants._();
//  final  String microphone = 'ic_microphone.png'.icontoPng;
// }

// extension _StringPath on String {
//   String get icontoPng => 'assets/icon/$this.png';
// }

enum IconConstants {
  microphone('ic_microphone');

  final String value;

  const IconConstants(this.value);

  String get toPng => 'assets/icon/$value.png';
}
