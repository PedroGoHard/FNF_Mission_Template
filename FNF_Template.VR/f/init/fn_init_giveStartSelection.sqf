if !(side player isEqualTo startLocationsSide) exitWith {};

_laptops = [lap_1,lap_2,lap_3,lap_4,lap_5];
_tables = [table1,table2,table3,table4,table5];

{_x addAction ["Go to start 1", {
  titleText ["Teleporting...", "BLACK OUT", 1];
  sleep 2;
  player setPos getMarkerPos "optStart_1";
  titleText ["Teleporting...", "BLACK IN", 1];
}] } forEach _laptops;
{_x addAction ["Go to start 2", {
  titleText ["Teleporting...", "BLACK OUT", 1];
  sleep 2;
  player setPos getMarkerPos "optStart_2";
  titleText ["Teleporting...", "BLACK IN", 1];
}] } forEach _laptops;
{_x addAction ["Go to start 3", {
  titleText ["Teleporting...", "BLACK OUT", 1];
  sleep 2;
  player setPos getMarkerPos "optStart_3";
  titleText ["Teleporting...", "BLACK IN", 1];
}] } forEach _laptops;
{_x addAction ["Go to start 4", {
  titleText ["Teleporting...", "BLACK OUT", 1];
  sleep 2;
  player setPos getMarkerPos "optStart_4";
  titleText ["Teleporting...", "BLACK IN", 1];
}] } forEach _laptops;
{_x addAction ["Go to start 5", {
  titleText ["Teleporting...", "BLACK OUT", 1];
  sleep 2;
  player setPos getMarkerPos "optStart_5";
  titleText ["Teleporting...", "BLACK IN", 1];
}] } forEach _laptops;

_areaMarkers = ["optStartMark_1","optStartMark_2","optStartMark_3","optStartMark_4","optStartMark_5"];
_teleportMarkers = ["optStart_1","optStart_2","optStart_3","optStart_4","optStart_5"];
{_x setMarkerAlphaLocal 1} forEach _areaMarkers;
{_x setMarkerAlphaLocal 1} forEach _teleportMarkers;
