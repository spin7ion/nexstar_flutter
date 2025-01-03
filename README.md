<!-- 
Celestron's NexStar Communication protocol implementation for Dart and Flutter.

This package is a work in progress!

The NexStar protocol is used to communicate with Celestron's NexStar telescopes.
This package focuses on building the commands and parsing the responses from the telescope.
The communications layer is not implemented in this package as it can bu UART, TCP/IP, Bluetooth SPP or BLE.

Any issues can be posted to the [GitHub repository](
(https://github.com/spin7ion/nexstar_flutter/issues)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages). 
-->


## Features

Creating Nexstar commands to send them to the telescope and parsing the responses.

## Getting started

install by adding the package to your pubspec.yaml file or by command

```bash
pub add nexstar
```

## Usage

Most commands are implemented in the NexstarCommandFactory class.
Use it to build the command you want to send to the telescope.

This example shows how to send a command to the telescope to move to a specific RA/DEC position.

```dart
import 'package:nexstar/nexstar.dart';

void main() {
  NexstarCommand cmd=NexstarCommandFactory.buildGotoRaDecCommand(10, 88, false);
  print("Send to telescope: {$cmd.commandData}");
  VoidResponse response = cmd.parseResponse("#") as VoidResponse;
  print("Response success: ${response.success}");
}
```

## Additional information

As this package is a work in progress, the command set can be not complete.
Please refer to the NexStar Communication Protocol commands list for more information.
Any questions can be asked by email: [spin7ion@gmail.com](mailto:spin7ion@gmail.com)  or by opening an issue on the GitHub repository.