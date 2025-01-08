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

    arguments[0]=rate.byte;

    if(axis==NexstarAxis.azm || axis==NexstarAxis.ra) {
      arguments[1]=NexstarDevices.motorAzmRa.id;
    } else {
      arguments[1]=NexstarDevices.motorAltDec.id;
    }


    arguments[2]=direction.byte;


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

  static NexstarCommand buildGetGPSLinkedCommand() => NexstarCommand(NexstarCommandType.isGPSLinked, Uint8List.fromList([1, NexstarDevices.gps.id, 55, 0, 0, 0, 1]));
  static NexstarCommand buildGetLatitudeCommand() => NexstarCommand(NexstarCommandType.getLatitude, Uint8List.fromList([1, NexstarDevices.gps.id, 1, 0, 0, 0, 3]));
  static NexstarCommand buildGetLongitudeCommand() => NexstarCommand(NexstarCommandType.getLongitude, Uint8List.fromList([1, NexstarDevices.gps.id, 2, 0, 0, 0, 3]));
  static NexstarCommand buildGetGPSTimeCommand() => NexstarCommand(NexstarCommandType.getGPSTime, Uint8List.fromList([1, NexstarDevices.gps.id, 51, 0, 0, 0, 3]));

  static NexstarCommand buildGetVersionCommand() => NexstarCommand(NexstarCommandType.getVersion, Uint8List(0));

  static NexstarCommand buildGetDeviceVersion(NexstarDevices device) =>
      NexstarCommand(NexstarCommandType.getVersion, Uint8List.fromList([1, device.id, 254, 0, 0, 0, 2]));
  static NexstarCommand buildGetModelCommand() => NexstarCommand(NexstarCommandType.getModel, Uint8List(0));
  
  static NexstarCommand buildCancelGotoCommand() => NexstarCommand(NexstarCommandType.cancelGoto, Uint8List(0));

  static NexstarCommand buildPassThroughCommand(Uint8List args)=>NexstarCommand(NexstarCommandType.passThrough, args);

  static NexstarCommand buildDirectMotorCommand(NexstarDevices motId, NexstarMotorMsgId msg, Uint8List args){
    var len=2;
    List<int> cmd=[len, motId.id, msg.id,...args];

    return buildPassThroughCommand(args);
  }

  static _stringToUint8List(String str){
    return Uint8List.fromList(str.codeUnits);
  }
}