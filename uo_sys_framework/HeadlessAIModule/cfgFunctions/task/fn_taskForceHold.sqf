#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params["_grp",["_behave","SAFE",[""]],["_combat","RED",[""]],["_speed","LIMITED",[""]],["_formation","WEDGE",[""]]];
{_x forcespeed -1; _x enableAI "Path";} foreach units _grp;
_grp setBehaviour _behave;
_grp setCombatMode _combat;
_grp setSpeedMode _speed;
_grp setFormation _formation;
private _units = units _grp;
for "_i" from 0 to (count _units) do {
    private _u = _units select _i;
    _u doWatch ((getPosATL _u) vectorAdd((vectorDir _u) vectorMultiply 100));
    _u disableAI "Path";
};
_grp setvariable ["InitialWPSet",true];
_grp setVariable [QGVAR(Mission),"FORCE HOLD"];
true
