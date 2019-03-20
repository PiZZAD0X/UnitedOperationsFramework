#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

private _zones = [];
if ((_this select 0) isEqualType []) then {
    _zones = _this select 0;
} else {
    _zones = _this;
};
{
    ([_x,GVAR(Zones)] call FUNC(getDetails)) set [3, 0];
} forEach _zones;
true
