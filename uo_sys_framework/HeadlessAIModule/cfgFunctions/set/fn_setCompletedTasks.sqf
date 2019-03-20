#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params ["_grp",["_compTask",objNull,[objNull]]];
private _completedTasks = _grp getVariable[QGVAR(CompletedTasks),[]];
private _taskSet = _compTask call FUNC(getTaskParams);
_taskSet params ["_task","_cond","_prior","_time","_onComp","_taskId"];
private _completedTask = [_taskId,_prior,_task];
if ( !(_completedTask IN _completedTasks)) then {
    _completedTasks append [_completedTask];
    _grp setVariable[QGVAR(CompletedTasks),_completedTasks];
};
true
