onMapSingleClick
{
	if ([satMarker, _pos] call BIS_fnc_inTrigger) then {
		PXS_SatelliteTarget = "Logic" createVehicleLocal _pos;//PXS_SATCOM_Logic
	};
	if (!([satMarker, _pos] call BIS_fnc_inTrigger)) exitWith {};
	PXS_SatelliteTarget setDir 0;
	call PXS_viewSatellite;
};
hint "Click on the map to insert default satellite coordinates. Must be within starting area.";
openMap true;