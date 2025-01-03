import 'dart:typed_data';

import 'nexstar_constants.dart';
class NexstarCommand {
  NexstarCommandType _command;
  Uint8List arguments;

  Uint8List _commandChar=Uint8List(1);

  NexstarCommand(this._command, this.arguments){
    _updateCommandChar();
  }

  NexstarCommandType get commandType => _command;

  set commandType(NexstarCommandType newCommand){
    _command=newCommand;
    _updateCommandChar();
  }

  void _updateCommandChar(){
    _commandChar = Uint8List.fromList(switch(_command) {
      NexstarCommandType.getRaDec => "E",
      NexstarCommandType.getPreciseRaDec => "e",
      NexstarCommandType.getAzmAlt => "Z",
      NexstarCommandType.getPreciseAzmAlt => "z",
      NexstarCommandType.gotoRaDec => "R",
      NexstarCommandType.gotoPreciseRaDec => "r",
      NexstarCommandType.gotoAzmAlt => "B",
      NexstarCommandType.gotoPreciseAzmAlt => "b",
      NexstarCommandType.syncRaDec => "S",
      NexstarCommandType.syncPreciseRaDec => "s",
      NexstarCommandType.getTrackingMode => "t",
      NexstarCommandType.setTrackingMode => "T",
      NexstarCommandType.slewRate => "P",
      NexstarCommandType.getLocation => "w",
      NexstarCommandType.setLocation => "W",
      NexstarCommandType.getTime => "h",
      NexstarCommandType.setTime => "H",
      NexstarCommandType.isGPSLinked => "P",
      NexstarCommandType.getLatitude => "P",
      NexstarCommandType.getLongitude => "P",
      NexstarCommandType.getDate => "P",
      NexstarCommandType.getYear => "P",
      NexstarCommandType.getGPSTime => "P",
      NexstarCommandType.getRTCDate => "P",
      NexstarCommandType.getRTCYear => "P",
      NexstarCommandType.getRTCTime => "P",
      NexstarCommandType.setRTCDate => "P",
      NexstarCommandType.setRTCYear => "P",
      NexstarCommandType.setRTCTime => "P",
      NexstarCommandType.getVersion => "V",
      NexstarCommandType.getDeviceVersion => "P",
      NexstarCommandType.getModel => "m",
      NexstarCommandType.echo => "K",
      NexstarCommandType.isAlignmentComplete => "J",
      NexstarCommandType.isGotoInProgress => "L",
      NexstarCommandType.cancelGoto => "M",

      // Pass-through commands meanings depends on next 7 bytes
      // P(?)(deviceId)(?)(?)(?)(?)(?)
      NexstarCommandType.passThrough => "P",
    }.codeUnits);
  }

  Uint8List get commandData{
    var b = BytesBuilder();
    b.add(_commandChar);
    b.add(arguments);
    return b.toBytes();
  }
}