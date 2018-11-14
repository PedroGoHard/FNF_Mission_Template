flagPoleAction = {
  [
      flagPole,                                                                           // Object the action is attached to
      "Take Flag",                                                                       // Title of the action
      "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_loadDevice_ca",                      // Idle icon shown on screen
      "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_loadDevice_ca",                      // Progress icon shown on screen
      "_this distance _target < 5",                                                        // Condition for the action to be shown
      "_caller distance _target < 5",                                                      // Condition for the action to progress
      {},                       // Code executed when action starts
      {},                                                                                  // Code executed on every progress tick
      {
        [] spawn grabFlag; remoteExec ["removePoleAction",2,false]
        },                             // Code executed on completion
      {},                                                                                  // Code executed on interrupted
      [],                                                                                  // Arguments passed to the scripts as _this select 3
      10,                                                                                  // Action duration [s]
      0,                                                                                   // Priority
      true,                                                                                // Remove on completion
      false                                                                               // Show in unconscious state
  ] call BIS_fnc_holdActionAdd;
};

flagAction = {
  [
      flagObj,                                                                           // Object the action is attached to
      "Take Flag",                                                                       // Title of the action
      "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_loadDevice_ca",                      // Idle icon shown on screen
      "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_loadDevice_ca",                      // Progress icon shown on screen
      "_this distance _target < 4",                                                        // Condition for the action to be shown
      "_caller distance _target < 4",                                                      // Condition for the action to progress
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
call flagPoleAction;
player disableCollisionWith flagObj;

player addEventHandler ["Killed", {
  playerDead = true;
}];

grabFlag = {
  hasFlag = true;
  publicVariableServer "flagPlayerUID";
  [side player,player] remoteExec ["flagControlled",2,false];
  [] spawn flagLoop;
  dropAction = player addAction ["Drop Flag", {[side player] remoteExec ["dropFlagServer",2,false]; call dropFlag},nil,1.5,false,true,"","player == _target"];
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
