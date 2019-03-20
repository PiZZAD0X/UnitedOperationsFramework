#define COMPONENT AI
#include "\x\UO_FW\addons\Main\script_macros.hpp"

//Script control
#define AI_EXEC_CHECK(ARG)\
_argUpper = toUpper(#ARG);\
if (!UO_FW_Server_HCModule_Allowed) exitWith {};\
if !(GETMVAR(Enabled,false)) exitwith {};\
if (isNil QGVAR(HC_ID)) then {_nul = [] call FUNC(checkifHC);};\
EXEC_CHECK(_argUpper)

// Locality Check and Redirect
#define AI_LOC_CHECK(ARG1)\
_argUpper = toUpper(#ARG1);\
if (isNil QGVAR(HC_ID)) then {_nul = [] call FUNC(checkifHC);};\
if ((_argUpper isEqualto "HCONLY") && (!isMultiplayer)) exitWith {\
    LOG_1("script:%1 couldn't run, set to HC ONLY and in Singleplayer!",_fnc_scriptName);\
};\
if ((_argUpper isEqualto "HCONLY") && (hasInterface || isDedicated)) exitwith {\
    if (!isNil QGVAR(HC_ID)) then {\
        if (!(GVAR(HC_ID) isEqualto clientowner)) then {\
            _this remoteExec [_fnc_scriptName,GVAR(HC_ID)];\
        } else {\
            LOG_1("script:%1 couldn't run, set to HC ONLY and no HC detected!",_fnc_scriptName);\
        };\
    };\
};\
if ((_argUpper isEqualto "AUTO") && (!isNil QGVAR(HC_ID))) then {\
    if (isMultiplayer) exitwith {\
        if (!(GVAR(HC_ID) isEqualto clientowner)) then {\
            _this remoteExec [_fnc_scriptName,GVAR(HC_ID)];\
        };\
    };\
}
