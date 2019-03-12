/*
 * Author: Olsen
 *
 * If unit respawns as playable, register it spawning, if respawns as spectator, stop tracking.
 *
 * Arguments:
 * 0: unit to track <object>
 *
 * Return Value:
 * nothing
 *
 * Public: No
 */

#define COMPONENT Core
#include "\x\UO_FW\addons\Main\script_macros.hpp"
EXEC_CHECK(SERVER);

params ["_new","_corpse"];
SETVAR(_new,Body,_corpse);

if (GETVAR(_corpse,Tracked,false)) then {
    if (GETVAR(_new,Spectating,false)) then {
        _new call FUNC(UntrackUnit);
    } else {
        _new call FUNC(EventSpawned);
    };
};
