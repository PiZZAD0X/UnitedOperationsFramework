#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

private _arr = [];
private _trts = (configFile >> "CfgVehicles" >> (typeOf _this) >> "Turrets");
for "_i" from 0 to (count _trts - 1) do {
    _arr set [count _arr, [_i]];
    for "_j" from 0 to (count (_trts >> (configName (_trts select _i)) >> "Turrets") - 1) do {
        _arr set [count _arr, [_i, _j]];
    };
};
_arr
