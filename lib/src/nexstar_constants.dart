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

enum NexstarMotorMsgId{
  MC_GET_POSITION	(0x01), // 3 byte answer. Position is a signed fraction of a full rotation.
  MC_GOTO_FAST			(0x02), // 3 byte answer. Goto position with rate = 9.
  MC_SET_POSITION			(0x04), // Position is a signed fraction of a full rotation.
  MC_SET_POS_GUIDERATE	(0x06), // Set positive guiderate With 24 bits: value is rate. With 16 bits: 0xffff = sidereal; 0xfffe = solar; 0xfffd = lunar
  MC_SET_NEG_GUIDERATE	(0x07), // Set negative guide rate With 24 bits: value is rate. With 16 bits: 0xffff = sidereal; 0xfffe = solar; 0xfffd = lunar.
  MC_LEVEL_START			(0x0b), // Start leveling process. Applicable to ALT only.
  MC_PEC_RECORD_START		(0x0c), // Start recording PEC data.
  MC_PEC_PLAYBACK			(0x0d), // Start or stop PEC playback, where: 0x01 = start playback; 0x00 = stop playback
  MC_SET_POS_BACKLASH		(0x10), // Set positive backlash. Valid range = 0-99.
  MC_SET_NEG_BACKLASH		(0x11), // Set negative backlash. Valid range = 0-99.
  MC_LEVEL_DONE			(0x12), // Determines if scope has finished leveling, where: 0x00 = not done; 0xff = done Applicable to ALT only.
  MC_SLEW_DONE			(0x13), // Check if slew is complete, where: 0x00 = not done; 0xff = done
  MC_UNKHOWN 				(0x14), // Always returns 0xff. Purpose unknown.
  MC_PEC_RECORD_DONE		(0x15), // Determine if PEC record is complete, where: 0x00 = not done; 0xff = done
  MC_PEC_RECORD_STOP		(0x16), // Stops recording PEC data.
  MC_GOTO_SLOW			(0x17), // Goto position with slow, variable rate. Either 16 or 24 bit accuracy. Position is a signed fraction of a full rotation.
  MC_AT_INDEX				(0x18), // Determines if axis is at an index marker, where: 0x00 = not at index; 0xff = at index. Applicable to AZM only.
  MC_SEEK_INDEX			(0x19), // Seeks to the nearest index marker. Applicable to AZM only.
  MC_MOVE_POS				(0x24), // Move positive (up/right), where: value = rate(0 - 9); rate = 0 means stop
  MC_MOVE_NEG				(0x25), // Move positive (down/left) where: value = rate(0 - 9); rate = 0 means stop
  MC_ENABLE_CORDWRAP		(0x38), // Enables cordwrap feature. Applicable to AZM only.
  MC_DISABLE_CORDWRAP		(0x39), // Disables cordwrap feature. Applicable to AZM only.
  MC_SET_CORDWRAP_POS		(0x3a), // Sets cordwrap position. Applicable to AZM only.
  MC_POLL_CORDWRAP		(0x3b), // Determines if cordwrap is enabled or disabled, where: 0x00 = disabled; 0xff = enabled. Applicable to AZM only.
  MC_GET_CORDWRAP_POS		(0x3c), // Gets cordwrap position. Applicable to AZM only.
  MC_GET_POS_BACKLASH		(0x40), // Get positive backlash.
  MC_GET_NEG_BACKLASH		(0x41), // Get negative backlash.
  MC_SET_AUTOGUIDE_RATE	(0x46), // Set autoguide rate (percent of sidereal). Uses the rate percentage formula: 100 * val / 256
  MC_GET_AUTOGUIDE_RATE	(0x47), // Get autoguide rate (percent of sidereal). Uses the rate percentage formula: 100 * val / 256
  MC_PROGRAM_ENTER 		(0x81), // Enters program mode.
  MC_PROGRAM_INIT			(0x82), // Initializes programming sequence.
  MC_PROGRAM_DATA			(0x83), // Downloads firmware to the device.
  MC_PROGRAM_END			(0x84), // Completes programming sequence. See “Firmware Upgrade” on page 23 for details.
  MC_GET_APPROACH			(0xfc), // Get approach, where: 0 = positive, 1 = negative
  MC_SET_APPROACH			(0xfd), // Set approach, where: 0 = positive;1 = negative
  MC_GET_VER				(0xfe); // Get firmware version, where: MSB is major version # LSB is minor version #

const NexstarMotorMsgId(this.id);
  final int id;

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