#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(HC);

if !(GETMVAR(Enabled,false)) exitWith {};

GVAR(ActiveHandlePFH) = [{
    if (isNil QGVAR(ActiveList)) then {GVAR(ActiveList) = [];};
    {
        if (isNull _x) then {
            GVAR(ActiveList) deleteAt _foreachIndex;
        };
    } foreach GVAR(ActiveList);
}, 60] call CBA_fnc_addPerFrameHandler;
