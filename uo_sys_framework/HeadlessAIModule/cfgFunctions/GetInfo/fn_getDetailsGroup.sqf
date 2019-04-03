#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params ["_unit",["_pos",[],[[]]]];
private _group = (group _unit);
private _groupInit = _group getVariable [QGVAR(groupInit),""];
private _occupy = _group getVariable [QGVAR(occupyOption),0];
if (_occupy isEqualTo 1) then {_occupy = floor(random [2,5,7])};
if (typename _groupInit isEqualTo "STRING") then {_groupInit = compile _groupInit;};
private _vehAssigned = if ((assignedVehicleRole _unit) isEqualTo []) then {false} else {true};
[side _unit,
_pos,
_group getVariable [QGVAR(behaviour),'safe'],
_group getVariable [QGVAR(combatMode),'red'],
_group getVariable [QGVAR(speed),'limited'],
_group getVariable [QGVAR(formation),'wedge'],
_group getVariable [QGVAR(groupStance),'auto'],
_groupInit,
_group getVariable [QGVAR(createRadius),0],
_group getVariable [QGVAR(patrolRadius),30],
_group getVariable [QGVAR(waypointWait),3],
_group getVariable [QGVAR(startBuilding),false],
_group getVariable [QGVAR(task),4],
_group getVariable [QGVAR(TaskTimer),0],
_group getVariable [QGVAR(multiplier),1],
_occupy,
_vehAssigned,
([(waypoints _unit)] call FUNC(getWaypointDetails)),
(surfaceIsWater (getposATL _unit)),
([_group,[QGVAR(TaskModule)]] call FUNC(getTasks)),
_group getVariable [QGVAR(forceLights),false],
_group getVariable [QGVAR(surrender),false],
_group getVariable [QGVAR(Tracker),false]
]
