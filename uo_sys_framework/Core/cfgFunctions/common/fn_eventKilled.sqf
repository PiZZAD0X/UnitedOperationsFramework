/*
 * Author: Olsen
 *
 * Triggered by unit death. Decreases number of alive units on a set side in UO_FW_Teams.
 *
 * Arguments:
 * 0: unit that has died <object>
 * 1: killer of the unit <object> (OPTIONAL)
 *
 * Return Value:
 * nothing
 *
 * Public: No
 */

#define COMPONENT Core
#include "\x\UO_FW\addons\Main\script_macros.hpp"
EXEC_CHECK(SERVER);

params [["_unit", objNull, [objNull]],["_killer", objNull, [objNull]]];

if (GETVAR(_unit,Tracked,false)) then {
    {
        _x params ["", "_side", "_Type", "", "_current"];
        if (!(GETVAR(_unit,HasDied,false)) && {!(GETVAR(_unit,Dead,false))} && {(GETVAR(_unit,Side,sideUnknown) isEqualto _side)} && {((_Type isEqualto "player" && {isPlayer _unit}) || (_Type isEqualto "ai" && !(isPlayer _unit)) || (_Type isEqualto "both"))}) exitWith {
            SETPVAR(_unit,HasDied,true);
            SETPVAR(_unit,Dead,true);
            _x set [4, (_current - 1)];
        };
    } forEach GVAR(Teams);
};
