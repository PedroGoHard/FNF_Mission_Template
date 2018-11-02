if (!isServer) exitWith {};

onPlayerDisconnected {
  if (_uid == flagPlayerUID) then {
    call dropFlagServer;
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

dropFlagServer = {
  params["_side"];
  detach flagObj;
  detach dummyMark;
  [] remoteExec ["flagAction",0,false];
  flagObj setFlagTexture "\A3\Data_F\Flags\flag_white_co.paa";
  flagObj setPosATL (getPosATL dummyMark);
  flagObj setVectorUp [0,0,1];
  "flagMark" setMarkerType "hd_flag";

  ["The flag has been dropped!"] remoteExecCall ["phx_fnc__hintThenClear", 0];
};


flagControlled = {
  params["_side"];

  switch (_side) do {
    case east: {
      ["OPFOR controls the flag!"] remoteExecCall ["phx_fnc__hintThenClear", 0];
      flagObj setFlagTexture "\A3\Data_F\Flags\flag_red_co.paa";
      "flagMark" setMarkerType "Faction_RU";
    };
    case west: {
      ["BLUFOR controls the flag!"] remoteExecCall ["phx_fnc__hintThenClear", 0];
      flagObj setFlagTexture "\A3\Data_F\Flags\flag_blue_co.paa";
      "flagMark" setMarkerType "Faction_US";
    };
  };
};
