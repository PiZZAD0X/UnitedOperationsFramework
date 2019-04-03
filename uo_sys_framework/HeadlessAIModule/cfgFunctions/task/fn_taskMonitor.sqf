#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

{
    _x params ["_grp"];
    if ({alive _x} count (units _grp) > 0 && _grp getVariable[QGVAR(isNotZoneActivated),true]) then {
        if (isNull (_grp getVariable[QGVAR(CurrentTask),objNull])) then {
            private _taskCheck = [_grp,_grp,true] call FUNC(taskCheck);
            _taskCheck params [["_task",objNull,[objNull]]];
            if (!isNull _task) then {
                [_grp,_task] call FUNC(taskSet);
            };
        } else {
            private _taskCheck = [_grp,(_grp getVariable[QGVAR(CurrentTask),objNull])] call FUNC(taskCheck);
            _taskCheck params [["_task",objNull,[objNull]]];
            if (GETVAR(_grp,CurrentTaskEndTime,0) < CBA_MissionTime && !isNull _task) then {
                [_grp,_task] call FUNC(taskSet);
            };
        };
    } else {
        _index = GVAR(taskedGroups) find [_grp];
        GVAR(taskedGroups) deleteAt _index;
    };
} forEach GVAR(taskedGroups);
true
