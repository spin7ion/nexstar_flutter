enum NexstarCommandType{
  getRaDec("E"), //E
  getPreciseRaDec("e"), //e
  getAzmAlt("Z"), //Z
  getPreciseAzmAlt("z"),//z
  gotoRaDec("R"), //R
  gotoPreciseRaDec("r"), //r
  gotoAzmAlt("B"), //B
  gotoPreciseAzmAlt("b"), //b
  syncRaDec("S"), //S
  syncPreciseRaDec("s"), //s
  getTrackingMode("t"), //t
  setTrackingMode("T"), //T
  slewRate("P"), //P
  getLocation("w"), //w
  setLocation("W"), //W
  getTime("h"), //h
  setTime("H"), //H

  // GPS
  isGPSLinked("P"), //P
  getLatitude("P"), //P
  getLongitude("P"), //P
  getDate("P"), //P
  getYear("P"), //P
  getGPSTime("P"), //P
  // RTC
  getRTCDate("P"), //P
  getRTCYear("P"), //P
  getRTCTime("P"), //P
  setRTCDate("P"), //P
  setRTCYear("P"), //P
  setRTCTime("P"), //P

  //Misc
  getVersion("V"), //V
  getDeviceVersion("P"), //P
  getModel("m"), //m
  echo("K"), //K
  isAlignmentComplete("J"), //J
  isGotoInProgress("L"), //L
  cancelGoto("M"), //M
  passThrough("P"); //P

  const NexstarCommandType(this.firstChar);

  final String firstChar;
}

enum NexstarTrackingMode{
  off,
  altAz,
  eqNorth,
  eqSouth
}

enum NexstarRate{
  variable(3),
  fixed(2);

  const NexstarRate(this.byte);
  final int byte;
}

enum NexstarDirection{
  positive(6),
  negative(7);

  const NexstarDirection(this.byte);
  final int byte;
}

enum NexstarAxis{
  ra,
  dec,
  azm,
  alt
}

enum NexstarDevices{
  motorFocus(12),
  motorAzmRa(16),
  motorAltDec(17),
  gps(176),
  rtc(178);

  const NexstarDevices(this.id);
  final int id;
}

enum NexstarMotorMsg{
  MC_GET_POSITION	      (0x01, 3), // 3 byte answer. Position is a signed fraction of a full rotation.
  MC_GOTO_FAST			    (0x02, 3), // 3 byte answer. Goto position with rate = 9.
  MC_SET_POSITION			  (0x04, 0), // Position is a signed fraction of a full rotation.
  MC_SET_POS_GUIDERATE	(0x06, 0), // Set positive guiderate With 24 bits: value is rate. With 16 bits: 0xffff = sidereal; 0xfffe = solar; 0xfffd = lunar
  MC_SET_NEG_GUIDERATE	(0x07, 0), // Set negative guide rate With 24 bits: value is rate. With 16 bits: 0xffff = sidereal; 0xfffe = solar; 0xfffd = lunar.
  MC_LEVEL_START			  (0x0b, 0), // Start leveling process. Applicable to ALT only.
  MC_PEC_RECORD_START		(0x0c, 0), // Start recording PEC data.
  MC_PEC_PLAYBACK			  (0x0d, 0), // Start or stop PEC playback, where: 0x01 = start playback; 0x00 = stop playback
  MC_SET_POS_BACKLASH		(0x10, 0), // Set positive backlash. Valid range = 0-99.
  MC_SET_NEG_BACKLASH		(0x11, 0), // Set negative backlash. Valid range = 0-99.
  MC_LEVEL_DONE			    (0x12, 1), // Determines if scope has finished leveling, where: 0x00 = not done; 0xff = done Applicable to ALT only.
  MC_SLEW_DONE			    (0x13, 1), // Check if slew is complete, where: 0x00 = not done; 0xff = done
  MC_UNKHOWN 				    (0x14, 1), // Always returns 0xff. Purpose unknown.
  MC_PEC_RECORD_DONE		(0x15, 1), // Determine if PEC record is complete, where: 0x00 = not done; 0xff = done
  MC_PEC_RECORD_STOP		(0x16, 0), // Stops recording PEC data.
  MC_GOTO_SLOW			    (0x17, 0), // Goto position with slow, variable rate. Either 16 or 24 bit accuracy. Position is a signed fraction of a full rotation.
  MC_AT_INDEX				    (0x18, 1), // Determines if axis is at an index marker, where: 0x00 = not at index; 0xff = at index. Applicable to AZM only.
  MC_SEEK_INDEX			    (0x19, 0), // Seeks to the nearest index marker. Applicable to AZM only.
  MC_MOVE_POS				    (0x24, 0), // Move positive (up/right), where: value = rate(0 - 9); rate = 0 means stop
  MC_MOVE_NEG				    (0x25, 0), // Move positive (down/left) where: value = rate(0 - 9); rate = 0 means stop
  MC_ENABLE_CORDWRAP		(0x38, 0), // Enables cordwrap feature. Applicable to AZM only.
  MC_DISABLE_CORDWRAP		(0x39, 0), // Disables cordwrap feature. Applicable to AZM only.
  MC_SET_CORDWRAP_POS		(0x3a, 0), // Sets cordwrap position. Applicable to AZM only.
  MC_POLL_CORDWRAP		  (0x3b, 1), // Determines if cordwrap is enabled or disabled, where: 0x00 = disabled; 0xff = enabled. Applicable to AZM only.
  MC_GET_CORDWRAP_POS		(0x3c, 3), // Gets cordwrap position. Applicable to AZM only.
  MC_GET_POS_BACKLASH		(0x40, 1), // Get positive backlash.
  MC_GET_NEG_BACKLASH		(0x41, 1), // Get negative backlash.
  MC_SET_AUTOGUIDE_RATE	(0x46, 0), // Set autoguide rate (percent of sidereal). Uses the rate percentage formula: 100 * val / 256
  MC_GET_AUTOGUIDE_RATE	(0x47, 1), // Get autoguide rate (percent of sidereal). Uses the rate percentage formula: 100 * val / 256
  MC_PROGRAM_ENTER 		  (0x81, 1), // Enters program mode.
  MC_PROGRAM_INIT			  (0x82, 1), // Initializes programming sequence.
  MC_PROGRAM_DATA			  (0x83, 1), // Downloads firmware to the device.
  MC_PROGRAM_END			  (0x84, 1), // Completes programming sequence. See “Firmware Upgrade” on page 23 for details.
  MC_GET_APPROACH			  (0xfc, 1), // Get approach, where: 0 = positive, 1 = negative
  MC_SET_APPROACH			  (0xfd, 0), // Set approach, where: 0 = positive;1 = negative
  MC_GET_VER				    (0xfe, 2); // Get firmware version, where: MSB is major version # LSB is minor version #

const NexstarMotorMsg(this.id, this.respLenBytes);
  final int id;
  final int respLenBytes;
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