import 'dart:typed_data';

import 'package:nexstar/src/nexstar_parser.dart';

import 'nexstar_constants.dart';
class NexstarCommand<ResponseType> {
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

  ResponseType parseResponse(Uint8List response){
    return NexstarResponseParser.parseResponse(this, response) as ResponseType;
  }
}

class PassThroughCommand<ResponseType> extends NexstarCommand{
  PassThroughCommand(Uint8List data) : super(NexstarCommandType.passThrough, data);

  int get msgLen=>arguments[0];
  int get destId=>arguments[1];
  int get msgId=>arguments[2];
  Uint8List get data=>arguments.sublist(3, 6);

  int get responseBytesLen=>arguments.last;
}