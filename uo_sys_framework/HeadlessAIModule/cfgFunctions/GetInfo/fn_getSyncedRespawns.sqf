#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params [["_syncedZones",[],[[]]],["_respawns",[],[[]]]];
{
    private _zone = _x;
    private _module = [_zone,[QGVAR(RespawnModule)]] call FUNC(getSyncedModules);
    {
        private _m = _x;
        _respawns pushBack _m;
    } forEach _module;
} forEach _syncedZones;
_respawns
