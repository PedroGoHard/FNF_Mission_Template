_endAliveEH = addMissionEventHandler ["EntityKilled", {
  params ["_unit", "_killer", "_instigator", "_useEffects"];
  ["balls"] remoteExecCall ["phx_fnc__hintThenClear", 0];
  if (({(alive _x) and (side _x == west)}count playableUnits) < 1  && !gameEnd) then {
    gameEnd = true;
    ["BLUFOR eliminated.\nOPFOR wins!"] remoteExec ["hint"];
    [] spawn {
      sleep 15;
      "endl" call bis_fnc_endMissionServer;
    };
  };
  if (({(alive _x) and (side _x == east)}count playableUnits) < 1 && !gameEnd) then {
    gameEnd = true;
    ["OPFOR eliminated.\nBLUFOR wins!"] remoteExec ["hint"];
    [] spawn {
      sleep 15;
      "endl" call bis_fnc_endMissionServer;
    };
  };
}];
