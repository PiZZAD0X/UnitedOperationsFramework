#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params["_getBld","_bldTask","_grpSet"];
_grpSet params [["_bld",objNull,[objNull]],"_grp","_pos",["_radius",0,[0]],["_wait",3,[0]],["_behave","SAFE",[""]],["_combat","RED",[""]],["_speed","LIMITED",[""]],["_formation","WEDGE",[""]],["_Type","MOVE",[""]],["_oncomplete","",[""]],["_compradius",0,[0]],["_bldPos",[],[[]]],["_patrol",false,[false]]];
_grp call CBA_fnc_clearWaypoints;
{_x forcespeed -1; _x enableAI "Path";} foreach units _grp;
private _bpos = _pos;
if (isNull _bld) then {
    _bld = [_pos,_radius] call _getBld;
    if (isNull _bld) then {
        _bpos = _pos;
        _patrol = true;
    } else {
        _bpos = getposatl _bld;
        if (_bldPos isEqualto []) then {_bldPos = _bld buildingPos -1;};
    };
};
if (_patrol) then {
    if (_radius < 1) then {_radius = _radius + 30;};
    [_grp,_bpos,_radius,_wait,_behave,_combat,_speed,_formation] spawn FUNC(taskPatrol);
} else {
    [0,"OBJECT",1,_bpos,_this] call FUNC(createWaypointModified);
    deleteWaypoint ((waypoints _grp) select 0);
    while {{alive _x} count (units _grp) <= ((count (units _grp)) * 0.5) || (((getPosATL leader _grp) distance _pos) > 50)} do { sleep 5; };
    {
        _x setvariable[QGVAR(Occupy),true];
        [_x,_bld,_bldPos,_wait,[_behave,_combat,_speed,_formation]] spawn _bldTask;
    } forEach (units _grp);
};
if (GETMVAR(Debug,false)) then {
    if (_patrol) then {
        [_grp,_bpos,"BLD ERROR PATROL","ColorOPFOR"] call FUNC(debugCreateMarker);
    } else {
        [_grp,_bpos,"rBldP"] call FUNC(debugCreateMarker);
    };
};
_grp setvariable ["InitialWPSet",true];
_grp setVariable [QGVAR(Mission),"BLD MOVE"];
true
