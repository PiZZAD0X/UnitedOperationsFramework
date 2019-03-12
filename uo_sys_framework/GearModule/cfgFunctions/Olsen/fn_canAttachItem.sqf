/*
 * Author: Olsen
 *
 * Check if accessory can be attached.
 *
 * Arguments:
 * 0: unit <object>
 * 1: type <string>
 *
 * Return Value:
 * can attach <bool>
 *
 * Public: No
 */

#define COMPONENT Gear
#include "\x\UO_FW\addons\Main\script_macros.hpp"
EXEC_CHECK(ALL);

params [
    ["_weapon", "", [""]],
    ["_item", "", [""]]
];

private _result = false;
{
    if (_item == _x) exitWith {
        _result = true;
    };
} forEach ([_weapon] call BIS_fnc_compatibleItems);

_result
