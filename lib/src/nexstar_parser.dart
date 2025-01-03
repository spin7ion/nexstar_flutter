import 'dart:typed_data';

import 'package:nexstar/nexstar.dart';
import 'package:nexstar/src/nexstar_command.dart';
import 'package:nexstar/src/nexstar_response.dart';

class NexstarResponseParser{
  static NexstarResponse parseResponse(NexstarCommand command, Uint8List response){
    return switch (command.commandType) {
      NexstarCommandType.getRaDec => GetPositionResponse(command, response),
      NexstarCommandType.getAzmAlt => GetPositionResponse(command, response),
      NexstarCommandType.getPreciseRaDec => GetPositionResponse(command, response),
      NexstarCommandType.getPreciseAzmAlt => GetPositionResponse(command, response),
      NexstarCommandType.getTrackingMode=>GetTrackingModeResponse(command, response),
      NexstarCommandType.getLocation => GetLocationResponse(command, response),
      NexstarCommandType.getTime => GetTimeResponse(command, response),
      NexstarCommandType.isGPSLinked => IsGPSLinkedResponse(command, response),
      NexstarCommandType.getLatitude => GetGPSLatitudeResponse(command, response),
      NexstarCommandType.getLongitude => GetGPSLongitudeResponse(command, response),
      NexstarCommandType.getDate => GetDateResponse(command, response),
      NexstarCommandType.getYear => GetYearResponse(command, response),
      NexstarCommandType.getGPSTime => GetGPSTimeResponse(command, response),
      NexstarCommandType.getRTCDate => GetDateResponse(command, response),
      NexstarCommandType.getRTCYear => GetYearResponse(command, response),
      NexstarCommandType.getRTCTime => GetTimeResponse(command, response),
      NexstarCommandType.getVersion => GetVersionResponse(command, response),
      NexstarCommandType.getDeviceVersion => GetVersionResponse(command, response),
      NexstarCommandType.getModel => GetModelResponse(command, response),
      NexstarCommandType.echo => EchoResponse(command, response),
      NexstarCommandType.isAlignmentComplete => IsAlignmentCompleteResponse(command, response),
      NexstarCommandType.isGotoInProgress => IsGotoInProgressResponse(command, response),
      _ => VoidResponse(command, response),
    };
  }
}