#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(HC);

GVAR(UnitQueue) = [];
GVAR(QueueHandlePFH) = [{
    if (GVAR(UnitQueue) isEqualTo []) exitwith {};
    private _ConsideringUnit = GVAR(UnitQueue) select 0;
    if ((isNull _ConsideringUnit)
        || (GETVAR(vehicle _ConsideringUnit,NoAI,false))
        || ((vehicle _ConsideringUnit) isKindOf "Plane")
        || (side _ConsideringUnit in GVAR(SideBasedExecution))
    ) exitwith {
        GVAR(UnitQueue) deleteAt 0;
        _ConsideringUnit forcespeed -1;
    };
    [_ConsideringUnit] execFSM "x\UO_FW\addons\Main\HeadlessAIModule\cfgFunctions\FSM\AIBEHAVIORTEST.fsm";
    GVAR(UnitQueue) deleteAt 0;
}, 1] call CBA_fnc_addPerFrameHandler;
