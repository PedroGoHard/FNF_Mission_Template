waitUntil {!isNil "serverVarsSetup"};

gameEnd = false;

if (satEnabled) then {
  switch (satEnabledSide) do {
    case west: {satMarker = "bluforSafeMarker"; publicVariable "satMarker";};
    case east: {satMarker = "opforSafeMarker"; publicVariable "satMarker";};
  };
};

if (startLocationsEnabled) then {
  switch (startLocationsSide) do {
    case east: {
      if !(getMarkerColor "opforSafeMarker" isEqualTo "") then {
        deleteMarker "opforSafeMarker";
      };
    };
    case west: {
      if !(getMarkerColor "bluforSafeMarker" isEqualTo "") then {
        deleteMarker "bluforSafeMarker";
      };
    };
  };
};

if (!startLocationsEnabled) then {
  _markers = ["optStartMark_1","optStartMark_2","optStartMark_3","optStartMark_4","optStartMark_5","optStart_1","optStart_2","optStart_3","optStart_4","optStart_5"];
  _objs = [lap_1,lap_2,lap_3,lap_4,lap_5,table1,table2,table3,table4,table5];

  {
    if (!(getMarkerColor _x isEqualTo "")) then {
      [_x] remoteExec ["deleteMarker",0,true];
    };
  } forEach _markers;
  {
    if (!isNil "_x") then {
      deleteVehicle _x;
    };
  } forEach _objs;
};

if (!satEnabled) then {
  if (!isNil "satLap") then {deleteVehicle satLap;};
  if (!isNil "table6") then {deleteVehicle table6;};
};

switch (activeMode) do {
  case "adUplink": {
    [] execVM "f\servermodes\adUplink.sqf";
    [[],"f\clientmodes\adUplink.sqf"] remoteExec ["BIS_fnc_execVM",0,true];
  };
  case "adDestroy": {
    modeParams execVM "f\servermodes\adDestroy.sqf";
  };
  case "adCapturetheFlag": {
    [] execVM "f\servermodes\adCapturetheFlag.sqf";
  };
  case "adVIP": {
    modeParams execVM "f\servermodes\adVIP.sqf";
  };
  case "neutralUplink": {
    [] execVM "f\servermodes\neutralUplink.sqf";
  };
  case "neutralTheGuy": {
    [] execVM "f\servermodes\neutralTheGuy.sqf";
  };
  case "neutralSector": {
    [] execVM "f\servermodes\neutralSector.sqf";
  };
  case "neutralCaptureTheFlag": {
    modeParams execVM "f\servermodes\neutralCaptureTheFlag.sqf";
    [[],"f\clientmodes\neutralCaptureTheFlag.sqf"] remoteExec ["BIS_fnc_execVM",0,true];
  };
  case "none": {};
  default {
    ["Game mode not configured correctly, check 'varSelection.sqf'"] remoteExec ["hint"];
  };
};

//Uplink
if (!(activeMode isEqualTo "adUplink") || !(activeMode isEqualTo "neutralUplink")) then {
  _terminals = [term1,term2,term3];
  _markers = ["term1Mark","term2Mark","term3Mark"];
  if (!(activeMode isEqualTo "adUplink") && !(activeMode isEqualTo "neutralUplink")) then {
    {
      if (!isNil "_x") then {
        deleteVehicle _x;
      };
    } forEach _terminals;
    {
      if (!(getMarkerColor _x isEqualTo "")) then {
        [_x] remoteExec ["deleteMarker",0,true];
      };
    } forEach _markers;
  };
  if ((activeMode isEqualTo "adUplink") && !(activeMode isEqualTo "neutralUplink")) then {
    {
      if (!isNil "_x") then {
        deleteVehicle _x;
      };
    } forEach [term2,term3];
    {
      if (!(getMarkerColor _x isEqualTo "")) then {
        [_x] remoteExec ["deleteMarker",0,true];
      };
    } forEach ["term2Mark","term3Mark"];
    "term1Mark" setMarkerText "Terminal";
  };
};

//VIP
if !(activeMode isEqualTo "adVIP") then {
  _markers = ["vip1Mark","vip2Mark"];
  {
    if (!(getMarkerColor _x isEqualTo "")) then {
      [_x] remoteExec ["deleteMarker",0,true];
    };
  } forEach _markers;
  _vips =[vip1,vip2];
  {
    if (!isNil "_x") then {
      deleteVehicle _x;
    };
  } forEach _vips;
};

//Destroy
if !(activeMode isEqualTo "adDestroy") then {
  _objs = [obj1,obj2];
  {
    if (!isNil "_x") then {
      deleteVehicle _x;
    };
  } forEach _objs;
  _markers = ["obj1Mark","obj2Mark"];
  {
    if (!(getMarkerColor _x isEqualTo "")) then {
      [_x] remoteExec ["deleteMarker",0,true];
    };
  } forEach _markers;
};

//Capture The Guy
if !(activeMode isEqualTo "neutralTheGuy") then {
  if (!isNil "theGuy") then {
    deleteVehicle theGuy;
  };
  if (!(getMarkerColor "theGuyMark" isEqualTo "")) then {
    deleteMarker "theGuyMark";
  };
};

//Neutral capture the flag
if !(activeMode isEqualTo "neutralCaptureTheFlag") then {
  if (!isNil "flagObj") then {
    deleteVehicle flagObj;
  };
  if (!(getMarkerColor "flagMark" isEqualTo "")) then {
    deleteMarker "flagMark";
  };
  if (!isNil "bluFlagTrig") then {
    deleteVehicle bluFlagTrig;
  };
  if (!isNil "opfFlagTrig") then {
    deleteVehicle opfFlagTrig;
  };
};
