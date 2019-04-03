#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params ["_name"];
private _return = "NotAClass";
if ((typeName _name) isEqualTo "STRING") then {
  _return = (configFile >> "cfgVehicles" >> _name);
};
_return
