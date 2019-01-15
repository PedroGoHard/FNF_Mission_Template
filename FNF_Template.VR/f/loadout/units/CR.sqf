// Add clothing
call phx_fnc_loadout_handleClothing; // Add clothing variables above this line!

// Add gear
[phx_loadout_aid, "uniform"] call phx_fnc_loadout_handleGear;
[phx_loadout_smoke, "uniform"] call phx_fnc_loadout_handleGear;
[phx_loadout_grenade, "uniform"] call phx_fnc_loadout_handleGear;
[phx_loadout_cuffs, "item"] call phx_fnc_loadout_handleGear;
[phx_loadout_rifle_mag, "vest"] call phx_fnc_loadout_handleGear;
player addWeapon phx_loadout_rifle_weapon;

// Add items
call phx_fnc_loadout_handleItems; // Add binocular/nvg variables above this line!

/*[] spawn {
};

switch (side player) do {
  case west: {
    waitUntil {!isNil "bluVics"};
    {
      _x lockDriver false;
      _x lockTurret [[0],false];
    } forEach bluVics;
  };
  case east: {
    {
      _x lockDriver false;
      _x lockTurret [[0],false];
    } forEach opfVics;
  };
};*/

missionNamespace setVariable ["phx_loadoutAssigned",true]; //Place this at the end of the loadout script so other scripts can tell when the player's loadout has been set.

/*

this lockTurret [[0],true];
this lockDriver true;

if (isServer) then {
  this spawn {
    waitUntil {!isNil "bluVics"};
    bluVics pushBack _this;
    publicVariable "bluVics";
  };
};
*/
