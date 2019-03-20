#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params ["_unit","_LastCStance"];
private ["_NearestEnemy","_TimeShot"];

_NearestEnemy = _Unit call FUNC(ClosestEnemy);
if (isNil "_NearestEnemy") exitwith {};

_TimeShot = _Unit getVariable [QGVAR(FiredTime),0];

if ((diag_tickTime - _TimeShot) > 120 && {((_NearestEnemy distance _Unit) > 1000)}) then {
    _Unit setBehaviour (_LastCStance);
};
