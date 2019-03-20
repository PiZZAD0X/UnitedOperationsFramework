#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

private ["_ClosestDead"];

//AllDeadMen because, you know, WOMEN DONT EXIST IN THIS GAME... -_-
private _nearlyallDeadMen = allDeadMen select {!(_x  isKindOf "Animal")};
private _ClosestDead = [_nearlyallDeadMen,_this] call FUNC(ClosestObject);
if (isNil ("_ClosestDead")) then {_ClosestDead = [0,0,0];};
_ClosestDead
