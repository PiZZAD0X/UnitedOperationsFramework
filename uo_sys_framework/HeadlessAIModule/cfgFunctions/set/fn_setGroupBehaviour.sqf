#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params ["_grp",["_behave","SAFE",[""]],["_combat","RED",[""]],["_speed","LIMITED",[""]],["_formation","WEDGE",[""]]];
_grp setBehaviour _behave;
_grp setCombatMode _combat;
_grp setSpeedMode _speed;
_grp setFormation _formation;
true
