#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params ["_logic",["_AllowedModules",[],[[]]],["_AllowedSynced",[],[[]]],["_Allowed",false,[false]]];
private _synced = synchronizedObjects _logic;
{
    private _syncModule = _x;
    if (_syncModule isKindOf "Logic") then {
        _Allowed = if (count _AllowedModules >= 1) then {
            (typeof _syncModule) in _AllowedModules
        } else {
            true
        };
        if (_Allowed) then {
            _AllowedSynced pushBack _syncModule;
        };
    };
} foreach _synced;
_AllowedSynced
