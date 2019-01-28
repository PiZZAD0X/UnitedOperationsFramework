#define COMPONENT Core
#include "\x\UO_FW\addons\Main\script_macros.hpp"
UO_FW_EXEC_CHECK(CLIENTHC);

LOG("ClientHC Post Init");

if (hasInterface) then {
    LOG("Client Post Init");

    ["endMission", {
        private _msg = "Mission ended by admin";
        if ((_this select 0) isEqualto []) then {
            _msg = _msg + ": " + (_this select 0);
        };
        _msg call UO_FW_fnc_EndMission;
    }, "admin"] call CBA_fnc_registerChatCommand;

    [{!(isNull player)}, {
        //Global client init including JiPs
        [{
            [{
                ["UO_FW_RegisterFrameworkEvent", []] call CBA_fnc_localEvent;
            }] call CBA_fnc_execNextFrame;
        }] call CBA_fnc_execNextFrame;

        if (didJIP && {(CBA_missionTime > ((GETMVAR(JIP_DENYTIME,5)) * 60))}) exitwith {
            ["UO_FW_JIP_PlayerEvent", []] call CBA_fnc_localEvent;
            ["UO_FW_JIP_ServerEvent", [player]] call CBA_fnc_serverEvent;
        };
        //Global client init excluding JiPs - init here should be replicated after JiP ability determined
        ["UO_FW_PlayerInit_Event", []] call CBA_fnc_localEvent;
        ["UO_FW_PlayerInitEH_Event", []] call CBA_fnc_localEvent;
    }] call CBA_fnc_WaitUntilAndExecute;
} else {
    LOG("HC Post Init");
    if (GETMVAR(AI_ViewDistance_Enforce,false)) then {
        setViewDistance GETMVAR(AI_ViewDistance,2500);
    };
};
