/*
 * Author: Olsen
 *
 * Ends mission in orderly fashion and displays end screen.
 * Sends the team stats, time limit, scenario and executes QEGVAR(Core,EndmissionEvent) on all players machines.
 *
 * Arguments:
 * 0: text to display in end screen <string>
 *
 * Return Value:
 * nothing
 *
 * Public: Yes
 */

#define COMPONENT Core
#include "\x\UO_FW\addons\Main\script_macros.hpp"
EXEC_CHECK(SERVER);

params ["_message"];

if (CBA_missiontime > (60 + (EGETMVAR(EndConditions,ConditionSleep,0)))) then {
    SETMPVAR(MissionEnded,true);
    //endmission hooks for modules
    if (EGETMVAR(ShotCount,Enabled,false)) then {
        LOG("Calculating ShotCount Data");
        [] call EFUNC(ShotCount,endCount);
    };
    {
        private _team = (_x select 0);
        private _assets = _team call FUNC(GetDamagedAssets);
        [_team, 5, _assets select 0] call FUNC(SetTeamVariable);
        [_team, 6, _assets select 1] call FUNC(SetTeamVariable);
    } forEach GVAR(Teams);
    [QGVAR(EndmissionEvent), [_message]] call CBA_fnc_globalEvent;
} else {
    ERROR_2("End Conditions have just been triggered. Mission might need to be ended manually! Time:%2 Safetime:%1",(60 + (EGETMVAR(EndConditions,ConditionSleep,0))),CBA_missiontime);
};
