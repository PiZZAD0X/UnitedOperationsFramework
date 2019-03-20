#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
EXEC_CHECK(SERVER);

[QGVAR(ServerEvent), {

}] call CBA_fnc_addEventHandler;

[QEGVAR(Core,SettingsLoaded), {

}] call CBA_fnc_addEventHandler;

if (isNil QGVAR(HC_ID)) then {
    [] call FUNC(initMain);
};
