private ["_ClosestDead"];

//AllDeadMen because, you know, WOMEN DONT EXIST IN THIS GAME... -_-
private _nearlyallDeadMen = allDeadMen select {!(_x  isKindOf "Animal")}; 
private _ClosestDead = [_nearlyallDeadMen,_this] call UO_FW_AI_fnc_ClosestObject;
if (isNil ("_ClosestDead")) then {_ClosestDead = [0,0,0];};
_ClosestDead