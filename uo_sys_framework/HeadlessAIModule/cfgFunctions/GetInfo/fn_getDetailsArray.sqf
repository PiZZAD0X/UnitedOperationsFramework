#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params [
    "_classname",
    "_array",
    ["_keycolumn",0,[0]],
    ["_value",-1,[0]]
];
{
    if ((_x select _keycolumn) isEqualTo _classname) exitwith {
        _value = _foreachIndex;
    };
} foreach _array;
_value
