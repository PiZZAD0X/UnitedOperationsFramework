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
{
    _x setvariable [QGVAR(BUNKER),true];
} foreach (units _grp);
_grp setvariable ["InitialWPSet",true];
_grp setVariable [QGVAR(Mission),"BUNKER"];
true
