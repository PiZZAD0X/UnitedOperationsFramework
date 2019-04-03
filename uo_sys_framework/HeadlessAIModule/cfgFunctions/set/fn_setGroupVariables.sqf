#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params ["_grp","_gpos",["_grpSet",[],[[]]]];
_grpSet params [
    /*0*/    "_side",
    /*1*/    "_pos",
    /*2*/    "_behave",
    /*3*/    "_combat",
    /*4*/    "_speed",
    /*5*/    "_formation",
    /*6*/    "_grpStance",
    /*7*/    "_grpInit",
    /*8*/    "_createRadius",
    /*9*/    "_taskRadius",
    /*10*/    "_wait",
    /*11*/    "_startBld",
    /*12*/    "_task",
    /*13*/    "_taskTimer",
    /*14*/    "_multi",
    /*15*/    "_occupyOption",
    /*16*/    "_vehAssigned",
    /*17*/    "_waypoints",
    /*18*/    "_onWater",
    /*19*/    "_tasks",
    /*20*/    "_fl",
    /*21*/    "_surrender",
    /*22*/    "_tracker"
    ];
_grp setVariable [QGVAR(GroupPos),_gpos];
_grp setVariable [QGVAR(behaviour),_behave];
_grp setVariable [QGVAR(combatMode),_combat];
_grp setVariable [QGVAR(speed),_speed];
_grp setVariable [QGVAR(formation),_formation];
_grp setVariable [QGVAR(patrolRadius),_taskRadius];
_grp setVariable [QGVAR(waypointWait),_wait];
_grp setVariable [QGVAR(task),_task];
_grp setVariable [QGVAR(TaskTimer),_taskTimer];
_grp setVariable [QGVAR(occupyOption),_occupyOption];
_grp setVariable [QGVAR(Waypoints),_waypoints];
_grp setVariable [QGVAR(tasks),_tasks];
_grp setVariable [QGVAR(forceLights),_fl];
_grp setVariable [QGVAR(surrender),_surrender];
_grp setVariable [QGVAR(Tracker),_tracker];
//_grp call CBA_fnc_clearWaypoints;
[_grp,_behave,_combat,_speed,_formation] call FUNC(setGroupBehaviour);
{
    _x setUnitPos _grpStance;
    if (!isNull(assignedVehicle _x)) then {[_x] orderGetIn true;};
} forEach (units _grp);
if (_fl) then {[_grp] call FUNC(setFlashlights);};
if (_surrender) then {[_grp] call FUNC(setSurrender);};
_grp spawn _grpinit;
true
