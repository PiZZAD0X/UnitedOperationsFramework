#define COMPONENT Core
#include "\x\UO_FW\addons\Main\script_macros.hpp"
EXEC_CHECK(ALL);

LOG("UO_FW_Respawned_Event called");
["UO_FW_Respawned_Event", _this] call CBA_fnc_serverEvent;