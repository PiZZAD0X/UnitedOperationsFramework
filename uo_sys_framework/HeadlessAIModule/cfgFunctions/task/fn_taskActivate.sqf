#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

{
    private _task = _x;
    {
        private _grp = _x;
        _grp setVariable[QGVAR(isNotZoneActivated),false];
        _grp setVariable[QGVAR(CurrentTaskEndTime),CBA_missionTime - 1];
        [_grp,_task] call FUNC(taskSet);
    } forEach (_task getVariable [QGVAR(taskGroups), []]);
} forEach _this;
true
