#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

private ["_Returned","_weapon"];
_weapon = nearestObject [(getposATL _this),"StaticWeapon"];
if !(isNull _weapon || {(_weapon distance _this) > 100}) then {
    _Returned = true;
} else {
    _Returned = false;
};
_Returned
