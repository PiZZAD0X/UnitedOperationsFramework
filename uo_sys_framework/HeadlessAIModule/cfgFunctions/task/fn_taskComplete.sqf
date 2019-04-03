#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params ["_grp",["_task",objNull,[objNull]]];
private _taskSet = _task call FUNC(getTaskParams);
_taskSet params ["_task","_cond","_prior","_time","_onComp"];
[_grp,_task] call _onComp;
[_grp,_task] call FUNC(setCompletedTasks);
true
