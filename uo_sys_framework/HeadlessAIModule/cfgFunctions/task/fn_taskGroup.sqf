#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params ["_grp","_i"];
([_grp] call FUNC(getGroupVariables)) params ["_pos","_behave","_combat","_speed","_formation","_taskRadius","_wait","_task","_taskTimer","_occupyOption","_waypoints","_tasks","_fl","_surrender","_tracker"];
if (_occupyOption > 0 && _task < 6) then {
    if (_task isEqualTo 2 || _task isEqualTo 4 || _task isEqualTo 5) then {
        for "_i" from 0 to (count(units _grp)) do {
            private _u = (units _group) select _i;
            _u setvariable[QGVAR(Occupy),true];
            private _blds = ["_spos","_taskRadius","_occupyOption","_grpcount"] call FUNC(getBuildingList);
            _blds params [["_bld",[],[[]]],["_bldPos",[],[[]]]];
            private _setBldPos = [_occupyOption,_i,_bld,_bldPos] call FUNC(setBuildingPos);
            _setBldPos params [["_spos",[],[[]]],["_uBld",objNull,[objNull]]];
            [_u,_uBld,_bldPos,_wait,[_behave,_combat,_speed,_formation]] spawn FUNC(taskBuildingPatrol);
        };
        _grp setVariable[QGVAR(CompletedTasks),[]];
        _grp setVariable[QGVAR(CurrentTaskEndTime),(CBA_MissionTime + _taskTimer)];
    };
    if (_task isEqualTo 0 || _task isEqualTo 1 || _task isEqualTo 3) then {
        {_x setvariable[QGVAR(Occupy),true]} forEach (units _grp);
        _grp setVariable[QGVAR(CompletedTasks),[]];
        _grp setVariable[QGVAR(CurrentTaskEndTime),(CBA_MissionTime + _taskTimer)];
        [{!((count waypoints (_this select 1)) isEqualto 0)},{
            _this call FUNC(taskAssign);
        },[_task,_grp,_pos,_taskRadius,_wait,_behave,_combat,_speed,_formation,_occupyOption]] call CBA_fnc_waitUntilAndExecute;
    };
} else {
    _grp setVariable[QGVAR(CompletedTasks),[]];
    _grp setVariable[QGVAR(CurrentTaskEndTime),(CBA_MissionTime + _taskTimer)];
    [{!((count waypoints (_this select 1)) isEqualto 0)},{
        _this call FUNC(taskAssign);
    },[_task,_grp,_pos,_taskRadius,_wait,_behave,_combat,_speed,_formation,_occupyOption]] call CBA_fnc_waitUntilAndExecute;
};
