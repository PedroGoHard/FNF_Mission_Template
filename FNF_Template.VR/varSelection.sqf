//Give access to start locations - If you don't want to use them, set 'startLocationsEnabled' to false
startLocationsEnabled = false; //Set to false to disable ability for side to select starting locations (generally use for attacking team on ATK/DEF missions)
publicVariable "startLocationsEnabled";
startLocationsSide = WEST; //Set to side you want to have access to the starting locations
publicVariable "startLocationsSide";
/*Possible values:
WEST
EAST
*/

//Sat feed vars
satEnabled = false; //Set to false to disable the defending team from being able to view a sat-view of their starting area
publicVariable "satEnabled";
satEnabledSide = EAST; // Defending side/whatever side you want to view the sat-view
publicVariable "satEnabledSide";
/*Possible values:
WEST
EAST
*/

endOnSideEliminated = true; //true/false to enable game ending when one side is eliminated

activeMode = "neutralCaptureTheFlag"; //Change this string to whatever game mode you want
modeParams = [];
/*
Values:
adUplink - attack/defend Uplink
params-

Required: defendingSide - string - east/west to set which side will be defending
////////////////////////////////////////////////////////////////////////////////////////////////////
adDestroy - attack/defend destory
params-

Required: defendingSide - string - east/west to set which side will be defending
Optional: objectivesNumber - integer - 1 or 2 - play with 1 or 2 objectives (if 1, obj1 will be chosen) - default: 2
////////////////////////////////////////////////////////////////////////////////////////////////////
adVIP - attack/defend VIP
params-

Required: defendingSide - string - east/west to set which side will be defending
Optional: vipMarkers - boolean - true/false to enable global markers following VIPs - defualt: true
Optional :vipMarkersUpdateTime - integer - how often the global markers will update - default: 30
////////////////////////////////////////////////////////////////////////////////////////////////////
adCapturetheFlag - attack/defend capture the flag
neutralUplink - neutral version of uplink
neutralSector - neutral sector control
neutralTheGuy - neutral The Guy objective (capture and hold VIP)
neutralCaptureTheFlag - neutral capture the flag objective
none - choose this if you want to create your own objectives and delete all the template objectives
*/

serverVarsSetup = true;
publicVariable "serverVarsSetup";
