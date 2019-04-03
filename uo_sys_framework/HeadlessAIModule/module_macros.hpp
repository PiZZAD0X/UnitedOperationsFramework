#ifndef COMPONENT
    #define COMPONENT AI
#endif
#include "\x\UO_FW\addons\Main\script_macros.hpp"

//Script control
#define AI_EXEC_CHECK(ARG) \
private _argUpper = toUpper(#ARG);\
if !(MGVAR(Server_HCModule_Allowed)) exitWith {};\
if (isNil QEGVAR(Core,Enabled)) then {\
    EGVAR(Core,Enabled) = EGETMVALUE(Core,Enabled,false);\
};\
if !(EGETMVAR(Core,Enabled,false)) exitWith {};\
if (isNil QGVAR(Enabled)) then {\
    GVAR(Enabled) = GETMVALUE(Enabled,false);\
};\
if !(GETMVAR(Enabled,false)) exitwith {};\
if (isNil QGVAR(HC_ID)) then {\
    [] call FUNC(checkifHC);\
};\
if ((_argUpper isEqualto "SERVER") && {((!isServer) && isMultiplayer)}) exitWith {}; \
if ((_argUpper isEqualto "CLIENT") && {(!hasinterface)}) exitWith {};\
if ((_argUpper isEqualto "HC") && {((hasinterface || isServer) && isMultiplayer)}) exitWith {};\
if ((_argUpper isEqualto "CLIENTHC") && {((isDedicated) && isMultiplayer)}) exitWith {};\
if ((_argUpper isEqualto "SERVERHC") && {((hasinterface) && isMultiplayer)}) exitWith {};\
if ((_argUpper isEqualto "ALL") && {(!(EGVAR(Core,Enabled)))}) exitWith {};\
if (!(MGVAR(Server_Framework_Allowed))) exitWith {}


// Locality Check and Redirect
#define AI_LOC_CHECK(ARG1) \
private _argUpper = toUpper(#ARG1);\
if (isNil QGVAR(HC_ID)) then {_nul = [] call FUNC(checkifHC);};\
if ((_argUpper isEqualto "HCONLY") && {(!isMultiplayer)}) exitWith {\
    LOG_1("script:%1 couldn't run, set to HC ONLY and in Singleplayer!",_fnc_scriptName);\
};\
if ((_argUpper isEqualto "HCONLY") && {(hasInterface || isDedicated)}) exitwith {\
    if !(isNil QGVAR(HC_ID)) then {\
        if !(GVAR(HC_ID) isEqualto clientowner) then {\
            _this remoteExec [_fnc_scriptName,GVAR(HC_ID)];\
        } else {\
            LOG_1("script:%1 couldn't run, set to HC ONLY and no HC detected!",_fnc_scriptName);\
        };\
    };\
};\
if ((_argUpper isEqualto "AUTO") && {(!isNil QGVAR(HC_ID))}) then {\
    if (isMultiplayer) exitwith {\
        if !(GVAR(HC_ID) isEqualto clientowner) then {\
            _this remoteExec [_fnc_scriptName,GVAR(HC_ID)];\
        };\
    };\
}
