import 'dart:typed_data';

import 'package:nexstar/nexstar.dart';

abstract class NexstarResponse {
  bool _success=false;

  NexstarResponse(NexstarCommand cmd, Uint8List response);

  bool get success=>_success;
}

class VoidResponse extends NexstarResponse {
  VoidResponse(NexstarCommand cmd, Uint8List response) : super(cmd, response){
    if (response.length==1 && response[0]=="#".codeUnits.first){
      _success=true;
    }
  }
}

class GetPositionResponse extends NexstarResponse {
  double _raAzm=0;
  double _decAlt=0;
  GetPositionResponse(NexstarCommand cmd, Uint8List response) : super(cmd, response){
    String str=String.fromCharCodes(response);

    if(str.endsWith("#")){
      _success=true;
      bool percise=false;

      if(cmd.commandType == NexstarCommandType.getPreciseRaDec || cmd.commandType == NexstarCommandType.getPreciseAzmAlt){
        percise=true;
      }

      List<String> parts=str.substring(0, str.length - 1).split(",");
      if(parts.length==2){
        _raAzm=NexstarUtils.stringToDoubleRad(parts[0], percise);
        _decAlt=NexstarUtils.stringToDoubleRad(parts[1], percise);
      }
    }
  }

  double get raAzm=>_raAzm;
  double get decAlt=>_decAlt;
}

class GetTrackingModeResponse extends NexstarResponse {
  NexstarTrackingMode _mode=NexstarTrackingMode.off;
  GetTrackingModeResponse(NexstarCommand cmd, Uint8List response) : super(cmd, response){
    String str=String.fromCharCodes(response);

    if(str.endsWith("#")){
      _success=true;
      if(str.length==2){
        int mode=int.parse(str.substring(0, 1));
        if(mode==0){
          _mode=NexstarTrackingMode.off;
        }else if(mode==1){
          _mode=NexstarTrackingMode.altAz;
        }else if(mode==2){
          _mode=NexstarTrackingMode.eqNorth;
        }else if(mode==3){
          _mode=NexstarTrackingMode.eqSouth;
        }
      }
    }
  }

  NexstarTrackingMode get mode=>_mode;
}

class GetLocationResponse extends NexstarResponse {

  int _latitudeDeg = 0;
  int _latitudeMin = 0;
  int _latitudeSec = 0;
  int _longitudeDeg = 0;
  int _longitudeMin = 0;
  int _longitudeSec = 0;
  NexstarNS _directionNS = NexstarNS.north;
  NexstarEW _directionEW = NexstarEW.east;

  GetLocationResponse(NexstarCommand cmd, Uint8List response) : super(cmd, response){
    response.last==35?_success=true:_success=false;

    if(_success){
      _latitudeDeg = response[0];
      _latitudeMin = response[1];
      _latitudeSec = response[2];
      _directionNS = response[3]==0?NexstarNS.north:NexstarNS.south;
      _longitudeDeg = response[4];
      _longitudeMin = response[5];
      _longitudeSec = response[6];
      _directionEW = response[7]==0?NexstarEW.east:NexstarEW.west;
    }
  }

  NexstarEW get directionEW => _directionEW;

  NexstarNS get directionNS => _directionNS;

  int get longitudeSec => _longitudeSec;

  int get longitudeMin => _longitudeMin;

  int get longitudeDeg => _longitudeDeg;

  int get latitudeSec => _latitudeSec;

  int get latitudeMin => _latitudeMin;

  int get latitudeDeg => _latitudeDeg;
}

class GetTimeResponse extends NexstarResponse {
  int _h = 0;
  int _m = 0;
  int _s = 0;
  int _month = 0;
  int _day = 0;
  int _year = 0;
  int _timezone = 0;
  int _dst = 0;

  GetTimeResponse(NexstarCommand cmd, Uint8List response) : super(cmd, response){
    response.last==35?_success=true:_success=false;

    if(_success){
      _h = response[0];
      _m = response[1];
      _s = response[2];
      _month = response[3];
      _day = response[4];
      _year = response[5];
      _timezone = response[6];
      _dst = response[7];
    }
  }

  int get dst => _dst;

  int get timezone => _timezone;

  int get year => _year;

  int get day => _day;

  int get month => _month;

  int get s => _s;

  int get m => _m;

  int get h => _h;
}

class IsGPSLinkedResponse extends NexstarResponse {
  bool _linked=false;
  IsGPSLinkedResponse(NexstarCommand cmd, Uint8List response) : super(cmd, response){
    if(response.length==2 && response.last==35){
      _success=true;
      _linked=response[0]==49;
    }
  }

  bool get linked=>_linked;
}

class GetGPSLatitudeResponse extends NexstarResponse {
  double _latitude=0;
  GetGPSLatitudeResponse(NexstarCommand cmd, Uint8List response) : super(cmd, response){
    if(response.length==4 && response.last==35){
      _success=true;
      _latitude=((response[0]*65536)+(response[1]*256)+response[2])*360/(2^24);
    }
  }

  double get latitude=>_latitude;
}

class GetGPSLongitudeResponse extends NexstarResponse {
  double _longitude=0;
  GetGPSLongitudeResponse(NexstarCommand cmd, Uint8List response) : super(cmd, response){
    if(response.length==4 && response.last==35){
      _success=true;
      _longitude=((response[0]*65536)+(response[1]*256)+response[2])*360/(2^24);
    }
  }

  double get longitude=>_longitude;
}


class GetGPSDateResponse extends NexstarResponse {
  int _month=0;
  int _day=0;
  GetGPSDateResponse(NexstarCommand cmd, Uint8List response) : super(cmd, response){
    if(response.length==3 && response.last==35){
      _success=true;
      _month=response[0];
      _day=response[1];
    }
  }

  int get month=>_month;
  int get day=>_day;
}

class GetGPSYearResponse extends NexstarResponse {
  int _year=0;
  GetGPSYearResponse(NexstarCommand cmd, Uint8List response) : super(cmd, response){
    if(response.length==3 && response.last==35){
      _success=true;
      _year=response[0]*256+response[1];
    }
  }

  int get year=>_year;
}

class GetGPSTimeResponse extends NexstarResponse {
  int _h=0;
  int _m=0;
  int _s=0;
  GetGPSTimeResponse(NexstarCommand cmd, Uint8List response) : super(cmd, response){
    if(response.length==4 && response.last==35){
      _success=true;
      _h=response[0];
      _m=response[1];
      _s=response[2];
    }
  }

  int get s=>_s;
  int get m=>_m;
  int get h=>_h;
}

// RTC

class GetDateResponse extends GetGPSDateResponse{
  GetDateResponse(super.cmd, super.response);
}

class GetYearResponse extends GetGPSYearResponse{
  GetYearResponse(super.cmd, super.response);
}

class GetRTCTimeResponse extends GetGPSTimeResponse {
  GetRTCTimeResponse(super.cmd, super.response);
}

class GetVersionResponse extends NexstarResponse {
  String _version="";
  GetVersionResponse(NexstarCommand cmd, Uint8List response) : super(cmd, response){
    if(response.length==3 && response.last==35){
      _success=true;
      _version="${response[0]}.${response[1]}";
    }
  }

  String get version=>_version;

  @override
  String toString() {
    return _version;
  }
}

class GetModelResponse extends NexstarResponse {
  NexstarModel _model=NexstarModel.unknown;
  GetModelResponse(NexstarCommand cmd, Uint8List response) : super(cmd, response){
    if(response.length==2 && response.last==35){
      _success=true;
      _model=switch(response[0]){
        1=>NexstarModel.gpsSeries,
        3=>NexstarModel.iSeries,
        4=>NexstarModel.iSeriesSE,
        5=>NexstarModel.cge,
        6=>NexstarModel.advancedGT,
        7=>NexstarModel.slt,
        9=>NexstarModel.cpc,
        10=>NexstarModel.gt,
        11=>NexstarModel.fourFiveSe,
        12=>NexstarModel.sixEightSe,
        int() => NexstarModel.unknown,
      };
    }
  }

  NexstarModel get model=>_model;
}

class EchoResponse extends NexstarResponse {
  String _echo="";
  EchoResponse(NexstarCommand cmd, Uint8List response) : super(cmd, response){
    if(response.length==2 && response.last==35){
      _success=true;
      _echo=String.fromCharCodes(response.sublist(0, 1));
    }
  }

  String get echo=>_echo;
}

class IsAlignmentCompleteResponse extends NexstarResponse {
  bool _complete=false;
  IsAlignmentCompleteResponse(NexstarCommand cmd, Uint8List response) : super(cmd, response){
    if(response.length==2 && response.last==35){
      _success=true;
      _complete=response[0]==1;
    }
  }

  bool get complete=>_complete;
}

class IsGotoInProgressResponse extends NexstarResponse {
  bool _inProgress=false;
  IsGotoInProgressResponse(NexstarCommand cmd, Uint8List response) : super(cmd, response){
    if(response.length==2 && response.last==35){
      _success=true;
      _inProgress=response[0]==49;
    }
  }

  bool get inProgress=>_inProgress;
}

