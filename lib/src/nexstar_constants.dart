enum NexstarCommandType{
  getRaDec, //E
  getPreciseRaDec, //e
  getAzmAlt, //Z
  getPreciseAzmAlt,//z
  gotoRaDec, //R
  gotoPreciseRaDec, //r
  gotoAzmAlt, //B
  gotoPreciseAzmAlt, //b
  syncRaDec, //S
  syncPreciseRaDec, //s
  getTrackingMode, //t
  setTrackingMode, //T
  slewRate, //P
  getLocation, //w
  setLocation, //W
  getTime, //h
  setTime, //H

  // GPS
  isGPSLinked, //P
  getLatitude, //P
  getLongitude, //P
  getDate, //P
  getYear, //P
  getGPSTime, //P
  // RTC
  getRTCDate, //P
  getRTCYear, //P
  getRTCTime, //P
  setRTCDate, //P
  setRTCYear, //P
  setRTCTime, //P

  //Misc
  getVersion, //V
  getDeviceVersion, //P
  getModel, //m
  echo, //K
  isAlignmentComplete, //J
  isGotoInProgress, //L
  cancelGoto, //M
  passThrough //P
}

enum NexstarTrackingMode{
  off,
  altAz,
  eqNorth,
  eqSouth
}

enum NexstarRate{
  variable,
  fixed
}

enum NexstarDirection{
  positive,
  negative
}

enum NexstarAxis{
  ra,
  dec,
  azm,
  alt
}

enum NexstarDevices{
  motorFocus,
  motorAzmRa,
  motorAltDec,
  gps,
  rtc
}

enum NexstarCardinalDirections{
  north,
  south,
  east,
  west
}

enum NexstarNS{
  north,
  south
}

enum NexstarEW{
  east,
  west
}

enum NexstarModel{
  unknown,
  gpsSeries,
  iSeries,
  iSeriesSE,
  cge,
  advancedGT,
  slt,
  cpc,
  gt,
  fourFiveSe,
  sixEightSe,
}