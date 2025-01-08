import 'dart:typed_data';

import 'nexstar_constants.dart';
import 'nexstar_command.dart';
import 'nexstar_utils.dart';

class NexstarCommandFactory {
  static NexstarCommand buildCommand(NexstarCommandType type, Uint8List arguments) {
    return NexstarCommand(type, arguments);
  }

  static NexstarCommand buildGetRaDecCommand(bool precise) {
    return NexstarCommand(precise?NexstarCommandType.getPreciseRaDec:NexstarCommandType.getRaDec, Uint8List(0));
  }

  static NexstarCommand buildGetAzmAltCommand(bool precise) {
    return NexstarCommand(precise?NexstarCommandType.getPreciseAzmAlt:NexstarCommandType.getAzmAlt, Uint8List(0));
  }

  static NexstarCommand buildGotoRaDecCommand(double ra, double dec, bool precise) {
    int raInt = precise?NexstarUtils.convertDegreesToPreciseNexStar(ra):NexstarUtils.convertDegreesToNexStar(ra);
    int decInt = precise?NexstarUtils.convertDegreesToPreciseNexStar(dec):NexstarUtils.convertDegreesToNexStar(dec);
    String arguments = "${NexstarUtils.intToStringRad(raInt, precise)},${NexstarUtils.intToStringRad(decInt, precise)}#";

    return NexstarCommand(precise?NexstarCommandType.gotoPreciseRaDec:NexstarCommandType.gotoRaDec, _stringToUint8List(arguments));
  }

  static NexstarCommand buildGotoAzmAltCommand(double azm, double alt, bool precise) {
    int azmInt = precise?NexstarUtils.convertDegreesToPreciseNexStar(azm):NexstarUtils.convertDegreesToNexStar(azm);
    int altInt = precise?NexstarUtils.convertDegreesToPreciseNexStar(alt):NexstarUtils.convertDegreesToNexStar(alt);
    String arguments = "${NexstarUtils.intToStringRad(azmInt, precise)},${NexstarUtils.intToStringRad(altInt, precise)}#";

    return NexstarCommand(precise?NexstarCommandType.gotoPreciseRaDec:NexstarCommandType.gotoRaDec, _stringToUint8List(arguments));
  }

  static NexstarCommand buildSyncRaDecCommand(double ra, double dec, bool precise) {
    int raInt = precise?NexstarUtils.convertDegreesToPreciseNexStar(ra):NexstarUtils.convertDegreesToNexStar(ra);
    int decInt = precise?NexstarUtils.convertDegreesToPreciseNexStar(dec):NexstarUtils.convertDegreesToNexStar(dec);
    String arguments = "${NexstarUtils.intToStringRad(raInt, precise)},${NexstarUtils.intToStringRad(decInt, precise)}#";

    return NexstarCommand(precise?NexstarCommandType.syncPreciseRaDec:NexstarCommandType.syncRaDec, _stringToUint8List(arguments));
  }

  static NexstarCommand buildGetTrackingModeCommand() => NexstarCommand(NexstarCommandType.getTrackingMode, Uint8List(0));
  static NexstarCommand buildSetTrackingModeCommand(NexstarTrackingMode mode) =>
      NexstarCommand(NexstarCommandType.getTrackingMode, Uint8List(1)..[0]=_stringToUint8List(mode.index.toString()));


  static NexstarCommand buildSlewCommand(NexstarRate rate, NexstarAxis axis, NexstarDirection direction, int rateValue) {
    Uint8List arguments=Uint8List(7);

    if(rate==NexstarRate.variable) {
      arguments[0]=3;
    } else {
      arguments[0]=2;
    }

    if(axis==NexstarAxis.azm || axis==NexstarAxis.ra) {
      arguments[1]=deviceId(NexstarDevices.motorAzmRa);
    } else {
      arguments[1]=deviceId(NexstarDevices.motorAltDec);
    }

    if(direction==NexstarDirection.positive) {
      arguments[2]=6;
    } else {
      arguments[2]=7;
    }

    if(rate==NexstarRate.variable){
      Uint8List rateBytes=NexstarUtils.trackingRateToUint8List(rateValue);
      arguments[3]=rateBytes[0];
      arguments[4]=rateBytes[1];
    } else {
      arguments[3]=rateValue;
      arguments[4]=0;
    }

    arguments[5]=0;
    arguments[6]=0;

    return NexstarCommand(NexstarCommandType.slewRate, arguments);
  }

  static NexstarCommand buildGetLocationCommand() => NexstarCommand(NexstarCommandType.getLocation, Uint8List(0));

  static NexstarCommand buildSetLocationDMSCommand(
      int latitudeDeg, int latitudeMin, int latitudeSec,
      int longitudeDeg, int longitudeMin, int longitudeSec,
      NexstarNS directionNS, NexstarEW directionEW) {

    Uint8List arguments=Uint8List.fromList([
      latitudeDeg, latitudeMin, latitudeSec, directionNS.index,
      longitudeDeg, longitudeMin, longitudeSec, directionEW.index
    ]);

    return NexstarCommand(NexstarCommandType.setLocation, arguments);
  }

  static NexstarCommand buildGetTimeCommand() => NexstarCommand(NexstarCommandType.getTime, Uint8List(0));

  static NexstarCommand buildSetTimeCommand(int h, int m, int s, int month, int day, int year, int timezone, int dst) {
    if(timezone<0){
      timezone=256+timezone;
    }
    Uint8List arguments=Uint8List.fromList([h, m, s, month, day, year, timezone, dst]);
    return NexstarCommand(NexstarCommandType.setTime, arguments);
  }

  static NexstarCommand buildGetGPSLinkedCommand() => NexstarCommand(NexstarCommandType.isGPSLinked, Uint8List.fromList([1, deviceId(NexstarDevices.gps), 55, 0, 0, 0, 1]));
  static NexstarCommand buildGetLatitudeCommand() => NexstarCommand(NexstarCommandType.getLatitude, Uint8List.fromList([1, deviceId(NexstarDevices.gps), 1, 0, 0, 0, 3]));
  static NexstarCommand buildGetLongitudeCommand() => NexstarCommand(NexstarCommandType.getLongitude, Uint8List.fromList([1, deviceId(NexstarDevices.gps), 2, 0, 0, 0, 3]));
  static NexstarCommand buildGetGPSTimeCommand() => NexstarCommand(NexstarCommandType.getGPSTime, Uint8List.fromList([1, deviceId(NexstarDevices.gps), 51, 0, 0, 0, 3]));

  static NexstarCommand buildGetVersionCommand() => NexstarCommand(NexstarCommandType.getVersion, Uint8List(0));

  static NexstarCommand buildGetDeviceVersion(NexstarDevices device) =>
      NexstarCommand(NexstarCommandType.getVersion, Uint8List.fromList([1, deviceId(device), 254, 0, 0, 0, 2]));
  static NexstarCommand buildGetModelCommand() => NexstarCommand(NexstarCommandType.getModel, Uint8List(0));
  
  static NexstarCommand buildCancelGotoCommand() => NexstarCommand(NexstarCommandType.cancelGoto, Uint8List(0));

  static _stringToUint8List(String str){
    return Uint8List.fromList(str.codeUnits);
  }

  static int deviceId(NexstarDevices device) {
    return switch(device){
      NexstarDevices.motorFocus => 12,
      NexstarDevices.motorAzmRa => 16,
      NexstarDevices.motorAltDec => 17,
      NexstarDevices.gps => 176,
      NexstarDevices.rtc => 178,
    };
  }

}