if (!isServer) exitWith {};

defendingSide = _this select 0;
objectivesNumber = _this select 1;
hackTimer = _this select 2;

term1Hacking = false;
publicVariable "term1Hacking";
term2Hacking = false;
publicVariable "term2Hacking";

if (isNil "defendingSide") then {
  systemChat "You have not configured 'varSelection.sqf' properly! You need to choose a defending side";
};
if (isNil "defendingSide") exitWith {};

if (isNil "objectivesNumber") then {
  objectivesNumber = 2;
} else {
  objectivesNumber = _this select 1;
};

if (isNil "hackTimer") then {
  hackTimer = 180;
} else {
  hackTimer = _this select 2;
};

switch (objectivesNumber) do {
  case 1: {
    term1Time = hackTimer;
  };
  case 2: {
    term1Time = hackTimer;
    term2Time = hackTimer;
  };
};

term1HackTimer = "";
term2HackTimer = "";

#include "adUplinkActions.sqf"

switch (objectivesNumber) do {
  case 1: {
    switch (defendingSide) do {
      case east: {
        call eastStopHack1;
        call westStartHack1;
      };
      case west: {
        call eastStartHack1;
        call westStopHack1;
      };
    };
  };
  case 2: {
    switch (defendingSide) do {
      case east: {
        call eastStopHack1;
        call eastStopHack2;
        call westStartHack1;
        call westStartHack2;
      };
      case west: {
        call eastStartHack1;
        call eastStartHack2;
        call westStopHack1;
        call westStopHack2;
      };
    };
  };
};

hacking = {
  waitUntil {term1Hacking || term2Hacking};

  sleep 3;

  if (term1Hacking) then {
    term1Time = term1Time - 3;
  };
  if (term2Hacking) then {
    term2Time = term2Time - 3;
  };

  while {(term1Hacking || term2Hacking) && !gameEnd} do {
    if (term1Hacking) then {
      if (term1Time <= 0) then {
        term1HackTimer = "Terminal 1 hack complete";
        term1Time = 0;
      } else {
        term1HackTimer = format ["Terminal 1 hack time remaining: %1", [term1Time, "MM:SS"] call BIS_fnc_secondsToString];
      };
    };

    if (term2Hacking) then {
      if (term2Time <= 0) then {
        term2HackTimer = "Terminal 2 hack complete";
        term2Time = 0;
      } else {
        term2HackTimer = format ["Terminal 2 hack time remaining: %1", [term2Time, "MM:SS"] call BIS_fnc_secondsToString];
      };
    };

    if (term1Hacking && !term2Hacking) then {
      [term1HackTimer] remoteExec ["hintSilent"];
    } else {
      if (term2Hacking && !term1Hacking) then {
        [term2HackTimer] remoteExec ["hintSilent"];
      } else {
        if (term1Hacking && term2Hacking) then {
          [term1HackTimer + "\n" + term2HackTimer] remoteExec ["hintSilent"];
        };
      };
    };

    sleep 1;

    if (term1Hacking) then {
      term1Time = term1Time - 1;
    };
    if (term2Hacking) then {
      term2Time = term2Time - 1;
    };
  };
  [] spawn hacking;
};

checkEnd = {
  switch (objectivesNumber) do {
    case 1: {
      [] spawn {
        while {!gameEnd} do {
          if (term1Time <= 0) then {
            gameEnd = true;
            publicVariable "gameEnd";
            switch (defendingSide) do {
              case east: {
                ["BLUFOR has completed the hack.\nBLUFOR wins!"] remoteExec ["hint"];
                sleep 15;
                "end1" call bis_fnc_endMissionServer;
              };
              case west: {
                ["OPFOR has completed the hack.\nOPFOR wins!"] remoteExec ["hint"];
                sleep 15;
                "end1" call bis_fnc_endMissionServer;
              };
            };
          };
        };
      };
    };
    case 2: {
      [] spawn {
        while {!gameEnd} do {
          if (term1Time <= 0 && term2Time <= 0) then {
            gameEnd = true;
            publicVariable "gameEnd";
            switch (defendingSide) do {
              case east: {
                ["BLUFOR has completed the hack.\nBLUFOR wins!"] remoteExec ["hint"];
                sleep 15;
                "end1" call bis_fnc_endMissionServer;
              };
              case west: {
                ["OPFOR has completed the hack.\nOPFOR wins!"] remoteExec ["hint"];
                sleep 15;
                "end1" call bis_fnc_endMissionServer;
              };
            };
          };
        };
      };
    };
  };
};

handleTerminals = {
  params["_term","_cond"];

  switch (_cond) do {
    case true: {
      switch (_term) do {
        case term1: {
          ["Terminal 1 hack started!"] remoteExec ["hint"];
          "term1Mark" setMarkerText "Terminal 1 - Hacking";
          sound1 = true;
          publicVariable "sound1";
          [term1,3] remoteExec ["BIS_fnc_dataTerminalAnimate", 0, true];
        };
        case term2: {
          ["Terminal 2 hack started!"] remoteExec ["hint"];
          "term2Mark" setMarkerText "Terminal 2 - Hacking";
          sound2 = true;
          publicVariable "sound1";
          [term2,3] remoteExec ["BIS_fnc_dataTerminalAnimate", 0, true];
        };
      };
    };
    case false: {
      switch (_term) do {
        case term1: {
          ["Terminal 1 hack paused!"] remoteExec ["hint"];
          "term1Mark" setMarkerText "Terminal 1";
          sound1 = false;
          publicVariable "sound1";
          [term1,0] remoteExec ["BIS_fnc_dataTerminalAnimate", 0, true];
        };
        case term2: {
          ["Terminal 2 hack paused!"] remoteExec ["hint"];
          "term2Mark" setMarkerText "Terminal 2";
          sound2 = false;
          publicVariable "sound2";
          [term2,0] remoteExec ["BIS_fnc_dataTerminalAnimate", 0, true];
        };
      };
    };
  };
};

[] spawn hacking;
call checkEnd;
