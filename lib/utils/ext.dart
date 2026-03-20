import 'dart:ui';

import 'package:dvt_weather_app/utils/util.dart';

enum DVTColor {
  RAINY,
  SUNNY,
  CLOUDY,
}

extension ColorExtUtil on DVTColor {
  String buildUrl() {
    switch (this) {
      case DVTColor.CLOUDY:
        return Util.cloudyURL;
      case DVTColor.RAINY:
        return Util.rainyURL;
      case DVTColor.SUNNY:
        return Util.sunnyURL;
    }
  }

  Color buildColor() {
    switch (this) {
      case DVTColor.CLOUDY:
        return Util.CLOUDY;
      case DVTColor.RAINY:
        return Util.RAINY;
      case DVTColor.SUNNY:
        return Util.SUNNY;
    }
  }
}

extension StringExtUtil on String {
  String produceUrl() {
    final value = toLowerCase();
    if (value.contains('cloud')) {
      return DVTColor.CLOUDY.buildUrl();
    }
    if (value.contains('rain')) {
      return DVTColor.RAINY.buildUrl();
    }
    if (value.contains('sun') || value.contains('clear')) {
      return DVTColor.SUNNY.buildUrl();
    }
    return DVTColor.SUNNY.buildUrl();
  }

  Color produceColor() {
    final value = toLowerCase();
    if (value.contains('cloud')) {
      return DVTColor.CLOUDY.buildColor();
    }
    if (value.contains('rain')) {
      return DVTColor.RAINY.buildColor();
    }
    if (value.contains('sun') || value.contains('clear')) {
      return DVTColor.SUNNY.buildColor();
    }
    return DVTColor.SUNNY.buildColor();
  }
}
