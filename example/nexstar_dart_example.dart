
import 'package:nexstar/nexstar.dart';

void main() {
  NexstarCommand cmd=NexstarCommandFactory.buildGotoRaDecCommand(10, 88, false);
  print("Send to telescope: {$cmd.commandData}");
}
