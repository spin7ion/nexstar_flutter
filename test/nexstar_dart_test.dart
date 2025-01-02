import 'dart:typed_data';

import 'package:nexstar/nexstar.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    NexstarCommand cmd = NexstarCommandFactory.buildGotoRaDecCommand(10, 88, false);
    Uint8List bytes = cmd.commandData;
    String cmdStr = String.fromCharCodes(bytes);
    print("Send to telescope: $bytes; \"$cmdStr\"");

    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () {
      //expect(awesome.isAwesome, isTrue);
    });
  });
}
