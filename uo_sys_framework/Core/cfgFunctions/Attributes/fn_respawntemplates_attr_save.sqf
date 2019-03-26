#define COMPONENT Respawn
#include "\x\UO_FW\addons\Main\script_macros.hpp"
EDEN_CHECK;

LOG_1("_this: %1",_this);
params ["_ctrl"];

private _value = [];
{
    private _ctrlListbox = _ctrl controlsGroupCtrl (100 + _x);
    if (ctrlshown _ctrlListbox) exitwith {
        for "_i" from 0 to (lbsize _ctrlListbox - 1) do {
            if (_ctrlListbox lbvalue _i > 0) then {_value pushback (_ctrlListbox lbdata _i);};
        };
    };
} foreach [0,1,2,3,4,5];
_value
