#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params ["_unit"];

private _Player = false;
if (isPlayer _Unit) then {_Player = true;};
//Determine if this AI should even execute new code
private _UseAI = _Unit getVariable [QGVAR(NOAI),false];
if (isNil ("_UseAI")) then {
    _UseAI = false;
};
private _BunkerAI = _Unit getVariable [QGVAR(BUNKER),false];
if (isNil ("_BunkerAI")) then {
    _BunkerAI = false;
};
private _Passarray = [_UseAI,_Player,_BunkerAI];
_Passarray
