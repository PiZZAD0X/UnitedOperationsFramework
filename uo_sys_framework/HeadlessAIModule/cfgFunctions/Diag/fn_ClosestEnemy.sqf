private ["_UnitSide", "_Array1", "_ReturnedEnemy"];
//Created on ???
// Modified on : 8/19/14 - 8/3/15

params ["_Unit"];
_UnitSide = (side _Unit);
_Array1 = [];
{
	_TargetSide = side _x;
	if ([_UnitSide, _TargetSide] call BIS_fnc_sideIsEnemy) then {_Array1 pushback _x;};
} forEach allUnits;

_ReturnedEnemy = [_Array1,_Unit] call UO_FW_AI_fnc_ClosestObject;
if (isNil "_ReturnedEnemy") then {_ReturnedEnemy = [0,0,0]};

//_Unit setVariable ["UO_FW_AI_CLOSESTENEMY",_ReturnedEnemy,false];
_ReturnedEnemy