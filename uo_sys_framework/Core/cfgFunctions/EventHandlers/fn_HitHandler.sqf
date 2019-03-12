//IGNORE_PRIVATE_WARNING ["_thisType", "_thisID"];

#define COMPONENT Core
#include "\x\UO_FW\addons\Main\script_macros.hpp"
EXEC_CHECK(CLIENT);

params ["_unit", "_source", "_damage", "_instigator"];

LOG("HIT EH");
if ((vehicle _instigator != vehicle player) && {!isNull _instigator}) then {
    LOG("HIT EH VALID");
    if (_damage > 1) then {_damage = 1};
    //we store this information in case it's needed if killed EH doesn't fire
    private _hitArray = [_instigator,time,(ASLtoAGL eyePos _unit),(ASLtoAGL eyePos _instigator)];
    missionNamespace setVariable [QEGVAR(Spectator,Killcam_LastHit), _hitArray];
    missionNamespace setVariable [QEGVAR(Spectator,Killcam_LastHitDamage), _damage];
};
