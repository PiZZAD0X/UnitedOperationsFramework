#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params ["_newPos","_grpldr","_unit",["_pos",[],[[]]]];
private _grpPos = getPosATL _grpldr;
private _unitPos = getpos _unit;
private _dist = _grpPos distance _unitPos;
private _dir = _grpPos getDir _unitPos;
_pos = [_newPos, _dist, _dir] call BIS_fnc_relPos;
_pos
