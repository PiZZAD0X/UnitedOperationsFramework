#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params [
    "_grp",
    ["_pos",[],[[]]],
    ["_radius",0,[0]],
    ["_wait",3,[0]],
    ["_behaviour", "UNCHANGED", [""]],
    ["_combat", "NO CHANGE", [""]],
    ["_speed", "UNCHANGED", [""]],
    ["_formation", "NO CHANGE", [""]],
    ["_Type","MOVE",[""]],
    ["_oncomplete","",[""]],
    ["_compradius",0,[0]]
];

private _timeout = [_wait*0.5,_wait,_wait*1.5];
_grp = _grp call CBA_fnc_getGroup;
_pos = _pos call CBA_fnc_getPos;
private _wp = _grp addWaypoint [_pos,_radius];
_wp setWaypointType _Type;
_wp setWaypointBehaviour _behaviour;
_wp setWaypointCombatMode _combat;
_wp setWaypointSpeed _speed;
_wp setWaypointFormation _formation;
_wp setWaypointStatements ["true", _oncomplete];
_wp setWaypointTimeout _timeout;
_wp setWaypointCompletionRadius _compradius;
_wp
