Map<String, int> HexValues = {
  "zero": 0x30,
  "one": 0x31,
  "two": 0x32,
  "three": 0x33,
  "four": 0x34,
  "five": 0x35,
  "six": 0x36,
  "seven": 0x37,
  "eight": 0x38,
  "nine": 0x39,
  "a": 0x61,
  "b": 0x62,
  "c": 0x63,
  "d": 0x64,
  "A": 0x41,
  "B": 0x42,
  "C": 0x43,
  "D": 0x44,
  "E": 0x45,
  "F": 0x46,
  "H": 0x48,
  "L": 0x4C,
  "M": 0x4D,
  "S": 0x53,
  "T": 0x54,
  "Z": 0x5A
};

Map<String, List> OBDRequests = {
  "speedRequest": [
    0x21,
    HexValues["zero"],
    HexValues["one"],
    HexValues["zero"],
    HexValues["d"],
    0xd
  ], //Request in format [format,numByte1,numByte2,service1,serive2,carrigereturn] => 01 0d request serive 1 pid hex of od => speed request
  "HybridBatteryReqest": [
    0x21,
    HexValues["zero"],
    HexValues["one"],
    HexValues["five"],
    HexValues["b"],
    0xd
  ], //Request in format [format,numByte1,numByte2,service1,serive2,carrigereturn] => 01 5A request serive 1 pid hex of 5A => EV hybrid battery request
  "EVSystemBatteryRequest": [
    0x21,
    HexValues["zero"],
    HexValues["one"],
    HexValues["nine"],
    HexValues["a"],
    0xd
  ], //Request in format [format,numByte1,numByte2,service1,serive2,carrigereturn] => 01 9A request serive 1 pid hex of 9A => EV system,battery request
  "requestSupportedPIDs1": [
    0x21,
    HexValues["zero"],
    HexValues["one"],
    HexValues["zero"],
    HexValues["zero"],
    0xd
  ], //Request in format [format,numByte1,numByte2,service1,serive2,carrigereturn] => 01 00 request serive 1 pid hex of 00 => supported PIDs for 01-20 for checking if speed is supported
  "requestSupportedPIDs2": [
    0x21,
    HexValues["zero"],
    HexValues["one"],
    HexValues["two"],
    HexValues["zero"],
    0xd
  ], //Request in format [format,numByte1,numByte2,service1,serive2,carrigereturn] => 01 00 request serive 1 pid hex of 00 => supported PIDs for 01-20 for checking if hybrid battery life is supported
  "requestSupportedPIDs3": [
    0x21,
    HexValues["zero"],
    HexValues["one"],
    HexValues["four"],
    HexValues["zero"],
    0xd
  ], //Request in format [format,numByte1,numByte2,service1,serive2,carrigereturn] => 01 00 request serive 1 pid hex of 00 => supported PIDs for 01-20 for checking if hybrid battery life is supported
  "requestSupportedPIDs4": [
    0x21,
    HexValues["zero"],
    HexValues["one"],
    HexValues["six"],
    HexValues["zero"],
    0xd
  ], //Request in format [format,numByte1,numByte2,service1,serive2,carrigereturn] => 01 00 request serive 1 pid hex of 00 => supported PIDs for 01-20 for checking if hybrid battery life is supported
  "requestSupportedPIDs5": [
    0x21,
    HexValues["zero"],
    HexValues["one"],
    HexValues["eight"],
    HexValues["zero"],
    0xd
  ], //Request in format [format,numByte1,numByte2,service1,serive2,carrigereturn]":> 01 00 request serive 1 pid hex of 00":> supported PIDs for 01-20 for checking if ev vehicle system data is supoported
  "leafATCommand1": [HexValues["A"], HexValues["T"], HexValues["Z"], 0xd],
  "leafATCommand2": [
    HexValues["A"],
    HexValues["T"],
    HexValues["E"],
    HexValues["zero"],
    0xd
  ],
  "leafATCommand3": [
    HexValues["A"],
    HexValues["T"],
    HexValues["H"],
    HexValues["one"],
    0xd
  ],
  "leafATCommand4": [
    HexValues["A"],
    HexValues["T"],
    HexValues["L"],
    HexValues["one"],
    0xd
  ],
  "leafATCommand5": [
    HexValues["A"],
    HexValues["T"],
    HexValues["S"],
    HexValues["one"],
    0xd
  ],
  "leafATCommand6": [
    HexValues["A"],
    HexValues["T"],
    HexValues["A"],
    HexValues["L"],
    0xd
  ],
  "leafATCommand7": [
    HexValues["A"],
    HexValues["T"],
    HexValues["C"],
    HexValues["M"],
    HexValues["seven"],
    HexValues["F"],
    HexValues["F"],
    0xd
  ],
  "leafATCommandODO": [
    HexValues["A"],
    HexValues["T"],
    HexValues["C"],
    HexValues["F"],
    HexValues["five"],
    HexValues["C"],
    HexValues["five"],
    0xd
  ],
  "leafATCommandSpeed": [
    HexValues["A"],
    HexValues["T"],
    HexValues["C"],
    HexValues["F"],
    HexValues["three"],
    HexValues["five"],
    HexValues["four"],
    0xd
  ],
  "leafATCommandBatterySOC": [
    HexValues["A"],
    HexValues["T"],
    HexValues["C"],
    HexValues["F"],
    HexValues["five"],
    HexValues["five"],
    HexValues["B"],
    0xd
  ],
  "leafATCommandBatteryRemainingKW": [
    HexValues["A"],
    HexValues["T"],
    HexValues["C"],
    HexValues["F"],
    HexValues["one"],
    HexValues["D"],
    HexValues["C"],
    0xd
  ],
  "leafATCommand9": [
    HexValues["A"],
    HexValues["T"],
    HexValues["M"],
    HexValues["A"],
    0xd
  ],
};

var BLE_OBD_NAME = "OBDII";
//BLE Manager (Module)
//FlutterBlue BleManager = FlutterBlue.instance;
//BLE Manager (Emitter)
//Global Timer

var unitID = '-1';
var isConnecting = false;
var isConnected = false;
var characteristicUUID = [];
var hasRetrivedServices = false;
var scanning = false;
var numAttemptsReconnect = 1;
var isWaitingCheckRequest = true;
var safeToRequestOBD = false;
var isListening = false;
var responseModeCheck = "41";
var numAttemtedRequests = 0;
var numAttemptedConnections = 0;
var requiredOBDRequests = [
  OBDRequests["leafATCommand1"],
  OBDRequests["leafATCommand2"],
  OBDRequests["leafATCommand3"],
  OBDRequests["leafATCommand4"],
  OBDRequests["leafATCommand5"],
  OBDRequests["leafATCommand6"],
  OBDRequests["leafATCommand7"],
  OBDRequests["leafATCommandBatterySOC"],
  OBDRequests["leafATCommand9"],
];
var checkOBDRequests = [
  OBDRequests["leafATCommand1"],
  OBDRequests["leafATCommand2"],
  OBDRequests["leafATCommand3"],
  OBDRequests["leafATCommand4"],
  OBDRequests["leafATCommand5"],
  OBDRequests["leafATCommand6"],
  OBDRequests["leafATCommand7"],
  OBDRequests["leafATCommandBatterySOC"],
  OBDRequests["leafATCommand9"],
];
var endCommunicationData = OBDRequests["leafATCommand1"];
var checkOBDrequstsLocation = [13];
var supportedRequsts = [false];
var currentCheckingIndex = 0;
var finishedExtracting = false;
var extractedData = -1.0;
var accumulativeString = "";
var hasRecivedUpdate = false;
var formattingATCommands = true;
var isInNavigation = false;
var scannerHasIntiated = false;
var isNavigatingMode = false;
var navigationRequestsData = false;
var leafLogRequets = [
  OBDRequests["leafATCommand1"],
  OBDRequests["leafATCommand2"],
  OBDRequests["leafATCommand3"],
  OBDRequests["leafATCommand4"],
  OBDRequests["leafATCommand5"],
  OBDRequests["leafATCommand6"],
  OBDRequests["leafATCommand7"],
  OBDRequests["leafATCommandBatterySOC"],
  OBDRequests["leafATCommand9"],
];
var stoppedExtractingData = false;
var numDataPacketsRecived = 100;
