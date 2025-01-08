import 'dart:typed_data';

import 'package:nexstar/src/nexstar_parser.dart';
import 'package:nexstar/src/nexstar_response.dart';

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
    _commandChar = Uint8List.fromList(_command.firstChar.codeUnits);
  }

  Uint8List get commandData{
    var b = BytesBuilder();
    b.add(_commandChar);
    b.add(arguments);
    return b.toBytes();
  }

  NexstarResponse parseResponse(Uint8List response){
    return NexstarResponseParser.parseResponse(this, response);
  }
}