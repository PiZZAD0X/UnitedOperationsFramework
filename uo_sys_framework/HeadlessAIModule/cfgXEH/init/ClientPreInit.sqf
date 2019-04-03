#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(CLIENTHC);

LOG("HC Client Pre Init");

[QGVAR(ClientEvent), {

}] call CBA_fnc_addEventHandler;

if !(hasInterface) then {
    [] call FUNC(initMain);
};
