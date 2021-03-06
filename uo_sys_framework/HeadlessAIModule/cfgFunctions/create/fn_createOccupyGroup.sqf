#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params ["_args",["_initmode",false,[false]]];
_args params ["","_grpSet","_grpMem",["_blds",[],[[]]],["_bldPos",[],[[]]],["_uBld",objNull,[objNull]]];
_grpSet params ["_side","_gpos","_behave","_combat","_speed","_formation","","","","_taskRadius","_wait","_startBld","_task","_taskTimer","","_occupyOption","","","","_tasks",""];
private _spos = _gpos;
_blds = [_spos,_taskRadius,_occupyOption,(count _grpMem)] call FUNC(getBuildingList);
_blds params [["_bld",[],[[]]],["_bldPos",[],[[]]]];
private _ngrp = createGroup _side;
{
    if !(_bld isEqualto []) then {
        private _setBldPos = [_occupyOption,_foreachIndex,_bld,_bldPos] call FUNC(setBuildingPos);
        _setBldPos params [["_hpos",[],[[]]]];
        _spos = _hpos;
    };
    private _u = [true,_ngrp,_spos,_startBld,_foreachIndex,_x,_taskRadius] call FUNC(createUnit);
    if ((count (units _ngrp)) isEqualTo 1) then { _gpos = _spos; };
    _u enableAI "Path";
    if (_task isEqualTo 2 || _task isEqualTo 4 || _task isEqualTo 5) then {
        _u setvariable[QGVAR(Occupy),true];
        [_u,_uBld,_bldPos,_wait,[_behave,_combat,_speed,_formation]] spawn FUNC(taskBuildingPatrol);
    };
    if !(_initmode) then {
        sleep 0.25;
    };
} foreach _grpMem;
[_ngrp,_gpos,_grpSet] call FUNC(setGroupVariables);
if !(_tasks isEqualTo []) then {
    [_ngrp,_tasks] call FUNC(taskRegister);
    _tasks = _tasks call FUNC(taskRemoveZoneActivated);
};
if !(_tasks isEqualTo []) then {GVAR(taskedGroups) pushBack [_ngrp];};
if (!(_tasks isEqualTo []) && {_taskTimer isEqualTo 0}) then {
    [_ngrp,_tasks] call FUNC(taskInit);
} else {
    if (_task isEqualTo 0 || _task isEqualTo 1 || _task isEqualTo 3) then {
        {_x setvariable[QGVAR(Occupy),true]} forEach (units _ngrp);
        _ngrp setVariable[QGVAR(CurrentTaskEndTime),(CBA_MissionTime + _taskTimer)];
        private _passarray = [_task,_ngrp,_spos,_taskRadius,_wait,_behave,_combat,_speed,_formation];
        [{!((count waypoints (_this select 1)) isEqualto 0)},{
            _this call FUNC(taskAssign);
        },_passarray] call CBA_fnc_waitUntilAndExecute;
    };
};
if (_blds isEqualTo []) then {
    LOG_2("Group %1 was unable to detect an enterable buildings. The group is located at %2. Increase Task Radius or move group closer to more buildings.",_ngrp,_spos);
};
true
