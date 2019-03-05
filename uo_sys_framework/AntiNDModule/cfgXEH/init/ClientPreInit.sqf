#define COMPONENT AntiND
#include "\x\UO_FW\addons\Main\script_macros.hpp"
UO_FW_EXEC_CHECK(CLIENT);

["UO_FW_AntiND_Event", {
    if !(UO_FW_Server_AntiNDModule_Allowed) exitwith {};
    if !(GVAR(Enabled)) exitwith {};
    ["UO_FW_RegisterModuleEvent", ["Anti ND", "Extra Safety for mission start", "Starfox64, PiZZADOX and Sacher"]] call CBA_fnc_localEvent;
    [{(!isNull player)}, {
        private _FiredEh = player addEventHandler ["Fired", {
            params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
            if (((EGETMVAR(Core,SpawnPos,(getpos player))) distance player) <= GVAR(Distance)) then {
                deleteVehicle _projectile;
                if (_magazine call BIS_fnc_isThrowable) then {
                    player addMagazine _magazine;
                } else {
                    player setAmmo [currentWeapon player, (player ammo currentWeapon player) + 1];
                };
                if (((EGETMVAR(Core,SpawnPos,(getpos player))) distance player) >= GVAR(Distance)) then {
                    [["Anti-ND protection active!<br/>Time Remaining: %1 seconds.",(round (GVAR(Time) - CBA_missionTime))]] call EFUNC(Core,parsedTextDisplay);
                } else {
                    [["Anti-ND protection active!<br/>Distance from Base: %1 out of %2 meters.<br/>Time Remaining: %1 seconds.",(round ((EGETMVAR(Core,SpawnPos,(getpos player))) distance player)),(round GVAR(Distance)),(round (GVAR(Time) - CBA_missionTime))]] call EFUNC(Core,parsedTextDisplay);
                };
            };
        }];
        SETPLVAR(ND_EHid,_FiredEh);
        SETPLVAR(ND_Active,true);
        //player setvariable [QEGVAR(AntiND,),];
        //player setvariable [QEGVAR(AntiND,ND_Active),true];
        [{(CBA_missionTime > GVAR(Time))},{player removeEventHandler ["Fired", _this]; SETPLVAR(ND_EHid,"DISABLED"); SETPLVAR(ND_Active,false);},_FiredEh] call CBA_fnc_waitUntilAndExecute;
    }] call CBA_fnc_waitUntilAndExecute;
}] call CBA_fnc_addEventHandler;

["UO_FW_SettingsLoaded", {
    ["UO_FW_AntiND_Event", []] call CBA_fnc_localEvent;
}] call CBA_fnc_addEventHandler;
