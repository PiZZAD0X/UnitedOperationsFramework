#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(CLIENT);

GVAR(PlayerFiredManEH) = player addEventHandler ["FiredMan",{
    params ["_firer","_weapon","_muzzle","_mode","_ammo","_magazine","_projectile","_gunner"];
    if (CBA_MissionTime < (missionNamespace getVariable [QGVAR(unitHandler_revealLockout),-1])) exitWith {};
    missionNamespace setVariable [QGVAR(unitHandler_revealLockout),(CBA_MissionTime + 5)];
    [QGVAR(PlayerShotEvent), [_firer,_weapon,_ammo]] call CBA_fnc_globalEvent;
}];
