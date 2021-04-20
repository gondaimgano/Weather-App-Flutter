import 'dart:ui';
import 'package:dvt_weather_app/utils/util.dart';

enum DVTColor{
  RAINY,
  SUNNY,
  CLOUDY

}

extension ColorExtUtil on DVTColor{

  String buildUrl(){
    switch(this){
      case DVTColor.CLOUDY:
        return Util.cloudyURL;
      case DVTColor.RAINY:
        return Util.rainyURL;
      case DVTColor.SUNNY:
        return Util.sunnyURL;
      default:
        return Util.sunnyURL;
    }
  }
  Color buildColor(){
    switch(this){
      case DVTColor.CLOUDY:
        return Util.CLOUDY;
      case DVTColor.RAINY:
        return Util.RAINY;
      case DVTColor.SUNNY:
        return Util.SUNNY;
      default:
        return Util.SUNNY;
    }
  }

}

extension StringExtUtil on String{

 String produceUrl(){
 var s= this.toLowerCase();
 if (s.contains("cloud"))
   return DVTColor.CLOUDY.buildUrl();
 if (s.contains("rain"))
   return DVTColor.RAINY.buildUrl();
 if (s.contains("sun")||s.contains("clear"))
   return DVTColor.SUNNY.buildUrl();
 return DVTColor.SUNNY.buildUrl();
 }

 Color produceColor(){
   var s= this.toLowerCase();
   if (s.contains("cloud"))
     return DVTColor.CLOUDY.buildColor();
   if (s.contains("rain"))
     return DVTColor.RAINY.buildColor();
   if (s.contains("sun")||s.contains("clear"))
     return DVTColor.SUNNY.buildColor();
   return DVTColor.SUNNY.buildColor();
 }
}