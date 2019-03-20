#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params ["_pos",["_radius",500,[0]],["_rbld",objNull,[objNull]]];
_rbld = selectRandom ([_pos,_radius] call FUNC(getBuildings));
_rbld
