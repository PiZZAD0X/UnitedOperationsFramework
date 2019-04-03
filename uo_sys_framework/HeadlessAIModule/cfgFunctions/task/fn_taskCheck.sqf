#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params ["_grp","_check",["_init",false,[false]],["_syncedTasks",[],[[]]],["_task",objNull,[objNull]],["_taskCheck",[],[[]]],["_taskOrder",[],[[]]]];
if ((GETVAR(_grp,CurrentTaskEndTime,0) < CBA_MissionTime) || _init) then {
    if ( !isNull (_grp getVariable[QGVAR(CurrentTask),objNull]) ) then {[_grp,_check] call FUNC(setCompletedTasks);};
    private _groupTaskOrder = _grp getVariable [QGVAR(groupTaskOrder),[]];
    if (count _groupTaskOrder > 1) then {_taskOrder = _groupTaskOrder select 1;};
    if (count _taskOrder > 0) then {
        private _tasks = _taskOrder select {!(_x in (_grp getVariable[QGVAR(CompletedTasks),[]]))};
        if !(_tasks isEqualTo []) then {
            _tasks sort (_groupTaskOrder select 0);
            _task = (_tasks select 0 select 2);
            _taskCheck = [_task];
        } else {
            private _sort = if (_groupTaskOrder select 0) then {false} else {true};
            _taskOrder sort _sort;
            _grp setVariable[QGVAR(CompletedTasks),[]];
            [_grp,(_taskOrder select 0 select 2)] call FUNC(setCompletedTasks);
            private _tasks = _taskOrder select {!(_x in (_grp getVariable[QGVAR(CompletedTasks),[]]))};
            if !(_tasks isEqualTo []) then {
                _task = (_tasks select 0 select 2);
                _taskCheck = [_task];
                _grp setVariable [QGVAR(groupTaskOrder),[_sort,_taskOrder]];
            } else {
                _taskCheck = [(_grp getVariable[QGVAR(CurrentTask),objNull])];
            };
        };
    } else {
        if (_init) then {
            private _grpSet = [_grp] call FUNC(getGroupVariables);
            _syncedTasks = (_grpSet select 11);
        } else {
            if ((typeName _check) isEqualTo "GROUP") then {
                _syncedTasks = [(leader _check),[QGVAR(TaskModule)]] call FUNC(getSyncedModules);
            } else {
                _syncedTasks = [_check,[QGVAR(TaskModule)]] call FUNC(getSyncedModules);
            };
        };
        private _tasks = _syncedTasks select {!(_x in (_grp getVariable[QGVAR(CompletedTasks),[]]))};
        if (_tasks isEqualTo []) then {
            private _index = GVAR(taskedGroups) find [_grp];
            GVAR(taskedGroups) deleteAt _index;
        } else {
            private _activeTasks = [];
            {
                private _checkTask = _x;
                private _taskSet = _checkTask call FUNC(getTaskParams);
                _taskSet params ["_task","_cond","_prior","_time","_onComp","_taskId"];
                if (call _cond) then {
                    _activeTasks pushback [_taskId,_prior,_task];
                };
            } foreach _tasks;
            if (!(_activeTasks isEqualTo [])) then {
                _activeTasks sort true;
                _task = (_activeTasks select 0 select 2);
            };
            _taskCheck = [_task];
        };
    };
} else { _taskCheck = [objNull]; };
_taskCheck
