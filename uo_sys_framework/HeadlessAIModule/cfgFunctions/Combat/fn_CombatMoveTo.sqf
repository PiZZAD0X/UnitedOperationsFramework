#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params ["_Group","_currenttarget","_enemydir"];
private ["_position","_radius"];

_position = getposASL _currenttarget;
_radius = 100;

if ((random 2) > 1) then {_group setformation "LINE";} else {_group setformation "WEDGE";};
_group setformdir _enemydir;

[_Group] call CBA_fnc_clearWaypoints;
_Group setVariable [QGVAR(Mission),"ATTACK"];
[_group, _position, _radius, "SAD", "AWARE", "RED"] call CBA_fnc_addWaypoint;

//_NoFlanking = _Group getVariable [QGVAR(REINFORCE),false];
//if (_NoFlanking) then {
//    [_Group] call CBA_fnc_clearWaypoints;
//    _Group setVariable [QGVAR(Mission),"ATTACK"];
//    [_group, _position, _radius, "SAD", "COMBAT", "RED"] call CBA_fnc_addWaypoint;
//} else {
//    _Group setVariable [QGVAR(Mission),"FLANK"];
//    [_Group,false] spawn FUNC(FlankManeuver);
//};
