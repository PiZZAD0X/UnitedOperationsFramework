#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

private ["_StartedInside"];
private _dgn_returnvariable = false;
private _Position = getposATL _this;
private _Array = lineIntersectsObjs [_Position,[_Position select 0,_Position select 1,(_Position select 2) + 10], objnull, objnull, true, 4];
{
    if (_x isKindof "Building") then {_dgn_returnvariable = true;};
} foreach _Array;

_Array = lineIntersectsObjs [_Position,[_Position select 0,_Position select 1,(_Position select 2) - 10], objnull, objnull, true, 4];
{
    if (_x isKindof "Building") then {_dgn_returnvariable = true;};
} foreach _Array;

if (_dgn_returnvariable) then  {
    _StartedInside = true;
    _this setVariable [QGVAR(StartedInside),true];
} else {
    _StartedInside = false;
};
_StartedInside
