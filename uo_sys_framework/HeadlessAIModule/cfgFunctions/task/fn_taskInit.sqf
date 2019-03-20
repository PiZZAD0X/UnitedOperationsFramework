#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params ["_grp",["_tasks",[],[[]]],["_task",objNull,[objNull]],["_taskOrdered",false,[false]]];
private _activeTasks = [];
for "_i" from 0 to (count _tasks) do {
    private _taskSet = (_tasks select _i) call FUNC(getTaskParams);
    _taskSet params ["_task","_cond","_prior","_time","_onComp","_taskId"];
    if (call _cond) then {
        _taskOrdered = if (_taskId > 0) then {true} else {false};
        _activeTasks pushback [_taskId,_prior,_task];
    };
};
if (_activeTasks isEqualTo []) then {
    [_grp] call FUNC(taskGroup);
} else {
    _activeTasks sort true;
    if (_taskOrdered) then {
        _task = (_activeTasks select 0 select 2);
        _grp setVariable [QGVAR(groupTaskOrder),[true,_activeTasks]];
    } else {
        _task = (_activeTasks select 0 select 2);
    };
};
if (!isNull _task) then {
    [_grp,_task] call FUNC(taskSet);
};
true
