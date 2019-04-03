#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVER);

LOG("HC Server Pre Init");

[QGVAR(ServerEvent), {

}] call CBA_fnc_addEventHandler;

[QEGVAR(Core,SettingsLoaded), {

}] call CBA_fnc_addEventHandler;

[] call FUNC(initMain);
