flagAction = {
  [
      flagObj,                                                                           // Object the action is attached to
      "Take Flag",                                                                       // Title of the action
      "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_loadDevice_ca",                      // Idle icon shown on screen
      "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_loadDevice_ca",                      // Progress icon shown on screen
      "_this distance _target < 3",                                                        // Condition for the action to be shown
      "_caller distance _target < 3",                                                      // Condition for the action to progress
      {},                       // Code executed when action starts
      {},                                                                                  // Code executed on every progress tick
      {[] spawn grabFlag},                             // Code executed on completion
      {},                                                                                  // Code executed on interrupted
      [],                                                                                  // Arguments passed to the scripts as _this select 3
      5,                                                                                  // Action duration [s]
      0,                                                                                   // Priority
      true,                                                                                // Remove on completion
      false                                                                               // Show in unconscious state
  ] call BIS_fnc_holdActionAdd;
};
flagPlayerUID = getPlayerUID player;
playerDead = false;
call flagAction;
player disableCollisionWith flagObj;

player addEventHandler ["Killed", {
  playerDead = true;
}];

grabFlag = {
  hasFlag = true;
  publicVariableServer "flagPlayerUID";
  [] remoteExec ["removeFlagAction",2,false];
  [side player] remoteExec ["flagControlled",2,false];
  [] spawn flagLoop;
  dummyMark setPosATL (getPosATL player);
  dummyMark attachTo [player];
  flagObj attachTo [player, [0.1,0.4,1.45], "aiming_axis"];
  flagObj setVectorUp [0,0,1];
  player setAnimSpeedCoef 1.5;
  dropAction = player addAction ["Drop Flag", {[side player] remoteExec ["dropFlagServer",2,false]; call dropFlag},nil,1.5,false,true,"","player == _target"];
  sleep 2;
  player setAnimSpeedCoef 0.7;
};

dropFlag = {
  player removeAction dropAction;
  player setAnimSpeedCoef 1;
  hasFlag = false;
};

flagLoop = {
  while {hasFlag} do {
    if (playerDead) then {
      hasFlag = false;
      [side player] remoteExec ["dropFlagServer",2,false];
    };
    sleep 0.25;
  };
};
