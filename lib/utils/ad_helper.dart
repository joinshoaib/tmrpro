import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
  // Test ad units (use these during development)
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111'; // Google test banner
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    }
    throw UnsupportedError('Unsupported platform');
  }

  // TODO: Replace with your REAL ad units before release
  // static String get realBannerAdUnitId {
  //   if (Platform.isAndroid) {
  //     return 'ca-app-pub-YOUR_PUBLISHER_ID/YOUR_AD_UNIT_ID';
  //   }
  //   throw UnsupportedError('Unsupported platform');
  // }
}
