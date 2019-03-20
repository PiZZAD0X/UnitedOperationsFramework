#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params ["_GroupUnits","_Group"];

{
    [_x] joinSilent _group;
    _x setVariable [QGVAR(LOITERING),false];
    if (_x isEqualTo (leader _x)) then {
        _x setVariable [QGVAR(FLANKING),false,false];
    };
    _x setVariable [QGVAR(MovedRecently),false,false];
} foreach _GroupUnits;

_Group setVariable [QGVAR(Mission),"DEFEND"];
