#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(ALL);

private _hc = false;
GVAR(HC_isHC) = false;
GVAR(HC_ID) = false;

//listen server and SP
if ((!isMultiplayer) || {(isMultiplayer) && (isServer) && (hasinterface)}) then {
    _hc = true;
    GVAR(HC_isHC) = true;
    SETMPVAR(HC_ID,clientowner);
};

//headless client
if (!hasInterface && !isDedicated) then {
    _hc = true;
    UO_FW_var_isHC = true;
    SETMPVAR(HC_ID,clientowner);
};

//server or client
if (isServer) then {
    LOG("clientID: SERVER");
} else {
    LOG_1("clientID: %1",clientowner);
};
if (!isNil QGVAR(HC_ID)) then {
    LOG_1("GVAR(HC_ID): %1",GVAR(HC_ID));
};

_hc
