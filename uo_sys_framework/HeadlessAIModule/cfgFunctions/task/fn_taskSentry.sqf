#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params [
    "_grp",
    "_pos",
    ["_radius",30,[0]],
    ["_wait",3,[0]],
    ["_behave","SAFE",[""]],
    ["_combat","RED",[""]],
    ["_speed","LIMITED",[""]],
    ["_formation","WEDGE",[""]],
    ["_Type","MOVE",[""]],
    ["_oncomplete",QUOTE(this call FUNC(taskSearchNearby)),[""]],
    ["_compradius",0,[0]],
    ["_wpcount",10,[0]],
    "_i"
];

{_x forcespeed -1; _x enableAI "Path";} foreach units _grp;
_grp call CBA_fnc_clearWaypoints;
private _wp1pos = (_pos vectorAdd((vectorDir (leader _grp)) vectorMultiply _radius));
private _this1 =+ _this;
_this1 set [1, _wp1pos];
_this1 call FUNC(createWaypoint);
_this call FUNC(createWaypoint);
private _this2 =+ _this;
_this2 set [8, "CYCLE"];
_this2 call FUNC(createWaypoint);

_grp setvariable ["InitialWPSet",true];
_grp setVariable [QGVAR(Mission),"SENTRY"];
true
