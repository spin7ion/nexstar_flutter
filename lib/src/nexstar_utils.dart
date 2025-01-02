import 'dart:typed_data';

import 'package:sprintf/sprintf.dart';

import 'nexstar_constants.dart';

class NexstarUtils{
  static double stringToDoubleRad(String str, bool precise) => precise?double.parse(str)*360/65536:double.parse(str)*360/4294967296;
  static String doubleToStringRad(int value, bool precise) => precise?sprintf ("%08X", [value]):sprintf ("%04X", [value]);
  static Uint8List trackingRateToUint8List(int trackingRate) => Uint8List(2)..[0]=(trackingRate * 4 / 256) as int..[1]=trackingRate * 4 % 256;

  static double dmsToDeg(List<int> dms, NexstarCardinalDirections direction){

    double deg = dms[0] + dms[1]/60 + dms[2]/3600;

    if (direction == NexstarCardinalDirections.south || direction == NexstarCardinalDirections.west) {
      deg = deg * -1;
    }
    return deg;
  }

  static int convertDegreesToPreciseNexStar(double deg)
  {
    return (deg*4294967296/360).round();
  }

  static int convertDegreesToNexStar(double deg)
  {
    return (deg*65536/360).round();
  }


  static List<int> degToDms(double deg){
    int d = deg.toInt();
    double m = (deg - d) * 60;
    int mInt = m.toInt();
    double s = (m - mInt) * 60;
    int sInt = s.toInt();
    return [d, mInt, sInt];
  }

}