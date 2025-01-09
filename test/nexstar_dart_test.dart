import 'dart:typed_data';

import 'package:nexstar/nexstar.dart';
import 'package:nexstar/src/nexstar_response.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    NexstarCommand cmd = NexstarCommandFactory.buildGotoRaDecCommand(10, 88, false);
    Uint8List bytes = cmd.commandData;
    String cmdStr = String.fromCharCodes(bytes);
    print("Send to telescope: $bytes; \"$cmdStr\"");

    cmd = NexstarCommandFactory.buildGetVersionCommand();
    cmdStr = String.fromCharCodes(cmd.commandData);
    print("Send to telescope: $bytes; \"$cmdStr\"");

    GetVersionResponse version = NexstarResponseParser.parseResponse(cmd, Uint8List.fromList([1, 2, 35])) as GetVersionResponse;

    print(version.toString());

    var cmd2 =NexstarCommandFactory.buildGetVersionCommand();
    GetVersionResponse usableResp =cmd2.parseResponse(Uint8List.fromList([1, 2, 35]));
    print(usableResp.version);

    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () {
      var slewCmd = NexstarCommandFactory.buildDirectMotorCommand(
          NexstarDevices.motorAzmRa, NexstarMotorMsg.MC_SET_POS_GUIDERATE, Uint8List.fromList([2, 88])
      );
      print("Slew variable rate: ${slewCmd.commandData};");
      expect(slewCmd.commandData, equals(
          Uint8List.fromList(["P".codeUnits.first, 3, 16, 6, 2, 88, 0, 0]))
      );
    });
  });
}
