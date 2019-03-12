/*
 * Author: Olsen
 *
 * Returns casualty percentage for set team
 *
 * Arguments:
 * 0: team <string>
 *
 * Return Value:
 * casualty percentage (1-100) <number>
 *
 * Public: Yes
 */

#define COMPONENT Core
#include "\x\UO_FW\addons\Main\script_macros.hpp"
EXEC_CHECK(ALL);

params ["_team"];
private _count = 0;
private _start = [_team, 3] call FUNC(GetTeamVariable);
private _current = [_team, 4] call FUNC(GetTeamVariable);
if (_start isEqualto 0) then {
    ERROR_1("Casualty count:<br></br>Warning no units on team ""%1"".", _team);
} else {
    _count = (_start - _current) / (_start * 0.01);
};

_count
