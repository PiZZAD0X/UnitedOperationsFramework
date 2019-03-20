#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params ["_pos",["_radius",500,[0]],["_amount",3,[0]]];
private _blds = [_pos,_radius,_amount] call FUNC(getRandomBuildings);
_blds
