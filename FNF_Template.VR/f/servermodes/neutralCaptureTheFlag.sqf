if (!isServer) exitWith {};

instantCapture = true;
flagInVic = false;
flagCarrier = "";

captureTime = _this select 0;
if (isNil "captureTime") then {
  captureTime = 0;
};
if (captureTime > 0) then {
  instantCapture = false;
  flagInBlu = false;
  flagInOpf = false;
};
if (instantCapture) then {
  bluFlagTrig setTriggerStatements  ["flagObj inArea thisTrigger && !gameEnd", "
  ['BLUFOR has captured the flag.\nBLUFOR wins!'] remoteExec ['hint'];
  deleteVehicle flagObj;
  gameEnd = true;
  ['flagMark'] remoteExec ['deleteMarker',0,true];
  ['bluFlagTask','SUCCEEDED'] call BIS_fnc_taskSetState;
  ['opfFlagTask','FAILED'] call BIS_fnc_taskSetState;
  [] spawn {
  sleep 20;
  'end1' call BIS_fnc_endMissionServer;
  };
  ",""];

  opfFlagTrig setTriggerStatements ["flagObj inArea thisTrigger && !gameEnd", "
  ['OPFOR has captured the flag.\nOPFOR wins!'] remoteExec ['hint'];
  deleteVehicle flagObj;
  gameEnd = true;
  ['flagMark'] remoteExec ['deleteMarker',0,true];
  ['opfFlagTask','SUCCEEDED'] call BIS_fnc_taskSetState;
  ['bluFlagTask','FAILED'] call BIS_fnc_taskSetState;
  [] spawn {
  sleep 20;
  'end1' call BIS_fnc_endMissionServer;
  };
  ",""];
};

if (!instantCapture) then {
  bluFlagTrig setTriggerActivation ["NONE", "PRESENT", true];
  bluFlagTrig setTriggerStatements ["flagObj inArea thisTrigger && !gameEnd", "
  ['BLUFOR has the flag in their capture zone!'] remoteExec ['hint'];
  flagInBlu = true;
  [west] spawn flagInZone;
  ","
  if (!gameEnd) then {
    flagInBlu = false;
    ['The flag has left the BLUFOR capture zone!'] remoteExec ['hint'];
  };
  "];

  opfFlagTrig setTriggerActivation ["NONE", "PRESENT", true];
  opfFlagTrig setTriggerStatements ["flagObj inArea thisTrigger && !gameEnd", "
  ['OPFOR has the flag in their capture zone!'] remoteExec ['hint'];
  flagInOpf = true;
  [east] spawn flagInZone;
  ","
  if (!gameEnd) then {
    flagInOpf = false;
    ['The flag has left the OPFOR capture zone!'] remoteExec ['hint'];
  };
  "];
};

onPlayerDisconnected {
  if (_uid == flagPlayerUID && !flagInVic) then {
    call dropFlagServer;
  };
  if (_uid == flagPlayerUID && flagInVic) then {
    call flagVicKilled;
  };
};

"flagMark" setMarkerPos (getPos flagObj);

[east,["opfFlagTask"],["Capture the flag. Prevent the enemy from capturing the flag.","Capture the flag",""],[objNull],"ASSIGNED",1,true,"Capture"] call BIS_fnc_taskCreate;
[west,["bluFlagTask"],["Capture the flag. Prevent the enemy from capturing the flag.","Capture the flag",""],[objNull],"ASSIGNED",1,true,"Capture"] call BIS_fnc_taskCreate;

_bluCapArea = triggerArea bluFlagTrig;
_opfCapArea = triggerArea opfFlagTrig;

_capMarkerBlu = createMarker ["bluCapMarker", getPos bluFlagTrig];
_capMarkerOpf = createMarker ["opfCapMarker", getPos opfFlagTrig];

_capMarkerTextBlu = createMarker ["bluCapMarkerText", getPos bluFlagTrig];
"bluCapMarkerText" setMarkerType "hd_dot";
"bluCapMarkerText" setMarkerText "BLUFOR Capture Zone";

_capMarkerTextOpf = createMarker ["opfCapMarkerText", getPos opfFlagTrig];
"opfCapMarkerText" setMarkerType "hd_dot";
"opfCapMarkerText" setMarkerText "OPFOR Capture Zone";

_setupMarker = {
  params ["_markerName","_flagTrigger","_capArea","_side"];

  _markerName setMarkerSize [_capArea select 0, _capArea select 1];

  if (_capArea select 3) then {
    _markerName setMarkerShape "RECTANGLE";
  } else {
    _markerName setMarkerShape "ELLIPSE";
  };

  switch (_side) do {
    case east: {
      _markerName setMarkerColor "ColorRed";
    };
    case west: {
      _markerName setMarkerColor "ColorBlue";
    };
  };

  _markerName setMarkerDir (_capArea select 2);
};

["bluCapMarker",bluFlagTrig,_bluCapArea,west] call _setupMarker;
["opfCapMarker",opfFlagTrig,_opfCapArea,east] call _setupMarker;

[] spawn {
  while {!gameEnd} do {
    "flagMark" setMarkerPos (getPos flagObj);
    sleep 10;
  };
};

dummyMark = "Land_HelipadEmpty_F" createVehicle [0,0,0];

removeFlagAction = {
  [flagObj] remoteExec ["removeAllActions",0,false];
};
removePoleAction = {
  [flagPole] remoteExec ["removeAllActions",0,true];
  [flagBanner] remoteExec ["hideObject",0,true];
  [flagObj,false] remoteExec ["hideObject",0,true];
};

dropFlagServer = {
  params["_side"];
  detach flagObj;
  detach dummyMark;
  flagObj attachTo [dummyMark,[0,0.475,1.5]];
  [flagObj,[0,0,1]] remoteExec ["setVectorUp",0,false];
  detach flagObj;
  [] remoteExec ["flagAction",0,false];
  if !(flagObj inArea bluFlagTrig || flagObj inArea opfFlagTrig) then {
    ["The flag has been dropped!"] remoteExecCall ["phx_fnc__hintThenClear", 0];
    flagObj setFlagTexture "\A3\Data_F\Flags\flag_white_co.paa";
    "flagMark" setMarkerType "hd_flag";
  };
};


flagControlled = {
  params["_side","_player"];
  call removeFlagAction;
  flagCarrier = _player;
  dummyMark attachTo [_player,[0,0,0]];
  flagObj attachTo [_player, [0.1,0.4,1.45], "aiming_axis"];
  [flagObj,[0,0,1]] remoteExec ["setVectorUp",0,false];

  switch (_side) do {
    case east: {
      if !(flagObj inArea bluFlagTrig || flagObj inArea opfFlagTrig) then {
        ["OPFOR controls the flag!"] remoteExecCall ["phx_fnc__hintThenClear", 0];
        flagObj setFlagTexture "\A3\Data_F\Flags\flag_red_co.paa";
        "flagMark" setMarkerType "Faction_RU";
      };
    };
    case west: {
      if !(flagObj inArea bluFlagTrig || flagObj inArea opfFlagTrig) then {
        ["BLUFOR controls the flag!"] remoteExecCall ["phx_fnc__hintThenClear", 0];
        flagObj setFlagTexture "\A3\Data_F\Flags\flag_blue_co.paa";
        "flagMark" setMarkerType "Faction_US";
      };
    };
  };
};

flagVicEH = addMissionEventHandler ["EntityKilled",{
	params ["_killed", "_killer", "_instigator"];
  if !(_killed isKindOf "Man" && _killed == flagCarrier && flagInVic) exitWith {};

  call flagVicKilled;
}];

flagVicKilled = {
  detach flagObj;
  detach dummyMark;

  _pos = getPosATL flagObj;
  _newFlagPos = _pos findEmptyPosition [0.25, 15, "rhs_Flag_chdkz"];
  dummyMark setPosATL _newFlagPos;

  flagObj attachTo [dummyMark,[0,0.475,1.5]];
  [flagObj,[0,0,1]] remoteExec ["setVectorUp",0,false];
  detach flagObj;

  [] remoteExec ["flagAction",0,false];

  if !(flagObj inArea bluFlagTrig || flagObj inArea opfFlagTrig) then {
    ["The flag has been dropped!"] remoteExecCall ["phx_fnc__hintThenClear", 0];
    flagObj setFlagTexture "\A3\Data_F\Flags\flag_white_co.paa";
    "flagMark" setMarkerType "hd_flag";
  };
};

flagInVehicle = {
  params ["_vehicle","_unit"];
  flagVic = _vehicle;

  detach flagObj;
  detach dummyMark;

  switch (typeOf _vehicle) do {
    case "rhsusf_m1025_w_m2": {
      flagObj attachTo [_vehicle,[0,-1.5,0.75]];
    };
    case "rhsusf_m1025_w": {
      flagObj attachTo [_vehicle,[0,-1.5,0.75]];
    };
    case "rhsgref_ins_uaz_dshkm": {
      flagObj attachTo [_vehicle,[-0.8,-1.22,1.7]];
    };
    case "rhsgref_ins_uaz": {
      flagObj attachTo [_vehicle,[-0.8,-1.22,1.7]];
    };
    case "I_G_Quadbike_01_F": {
      flagObj attachTo [_vehicle,[-0.5,-0.6,1.1]];
    };
    case "rhsusf_m966_w": {
      flagObj attachTo [_vehicle,[0,-1.5,0.75]];
    };
    case "rhs_btr80a_msv": {
      flagObj attachTo [_vehicle,[-0.9,-3.5,1.85]];
    };
    case "RHS_M2A3_wd": {
      flagObj attachTo [_vehicle,[-0.75,-2,2]];
    };
    default {
      flagObj attachTo [_vehicle,[0,-0.5,1]];
    };
  };
};

flagOutVehicle = {
  params ["_player"];

  dummyMark attachTo [_player,[0,0,0]];
  flagObj attachTo [_player, [0.1,0.4,1.45], "aiming_axis"];
  [flagObj,[0,0,1]] remoteExec ["setVectorUp",0,false];
};

flagInZone = {
  params ["_side"];
  _captureTimeLeft = captureTime;

  sleep 3;

  _captureTimeLeft = _captureTimeLeft - 3;

  switch (_side) do {
    case east: {
      while {flagInOpf && !gameEnd} do {
        if (_captureTimeLeft <= 0) then {
          gameEnd = true;
          ["OPFOR has successfully held the flag.\nOPFOR wins!"] remoteExec ["hint"];
          sleep 15;
          "end1" call BIS_fnc_endMissionServer;
        };
        _captureTimeDisplay = format ["OPFOR capture time remaining: %1", [_captureTimeLeft, "MM:SS"] call BIS_fnc_secondsToString];
        [_captureTimeDisplay] remoteExec ["hintSilent"];

        _captureTimeLeft = _captureTimeLeft - 1;

        sleep 1;
      };
    };
    case west: {
      while {flagInBlu && !gameEnd} do {
        if (_captureTimeLeft <= 0) then {
          gameEnd = true;
          ["BLUFOR has successfully held the flag.\nBLUFOR wins!"] remoteExec ["hint"];
          sleep 15;
          "end1" call BIS_fnc_endMissionServer;
        };
        _captureTimeDisplay = format ["BLUFOR capture time remaining: %1", [_captureTimeLeft, "MM:SS"] call BIS_fnc_secondsToString];
        [_captureTimeDisplay] remoteExec ["hintSilent"];

        _captureTimeLeft = _captureTimeLeft - 1;

        sleep 1;
      };
    };
  };
};
