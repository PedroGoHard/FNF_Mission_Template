//Make sure player stays inside safe start markers
_side = side player;
startMarkers = [];
safeZoneWarning = false;
playerInStart = true;

if (startLocationsEnabled && (startLocationsSide isEqualTo _side)) then {
  startMarkers = ["optStartMark_1","optStartMark_2","optStartMark_3","optStartMark_4","optStartMark_5"];
} else {
  switch (_side) do {
    case east: {
      startMarkers = ["opforSafeMarker"];
    };
    case west: {
      startMarkers = ["bluforSafeMarker"];
    };
  };
};

notInStart = {
  _timeAllowed = 30;
  while {!playerInStart && alive player && phx_safeStartEnabled} do {
    for [{_i=_timeAllowed}, {_i>0}, {_i=_i-1}] do {
      if (playerInStart || !phx_safeStartEnabled) exitWith {safeZoneWarning = false; hintSilent ""};
      hintSilent format ["You have %1 seconds to get back into the safe zone.", _i];
      sleep 1;
    };
    if (!playerInStart && phx_safeStartEnabled) then {
      safeZoneWarning = false;
      player setDamage 1;
      [] spawn phx_fnc_init_removeClientHandlers;
    };
  };
  hintSilent "";
};

safeStartZonePFH = [{
  _pos = getPos vehicle player;
  for [{_i=0}, {_i<=(count startMarkers)-1}, {_i=_i+1}] do {
    if (_pos inArea (startMarkers select _i)) then {
      playerInStart = true;
    } else {
      playerInStart = false;
    };
    if (playerInStart) exitWith {};
  };
  if (playerInStart) exitWith {};
  if (!playerInStart && !safeZoneWarning) then {
    [] spawn notInStart;
    safeZoneWarning = true;
  };
  }, 0.25, []] call CBA_fnc_addPerFrameHandler;
