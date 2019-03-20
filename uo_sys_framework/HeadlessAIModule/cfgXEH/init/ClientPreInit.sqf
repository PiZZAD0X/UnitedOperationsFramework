#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
EXEC_CHECK(CLIENTHC);

[QGVAR(ClientEvent), {

}] call CBA_fnc_addEventHandler;

if !(hasInterface) then {
    [] call FUNC(initMain);
};
