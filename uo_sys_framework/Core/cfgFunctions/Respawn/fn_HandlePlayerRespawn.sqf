#define COMPONENT Respawn
#include "\x\UO_FW\addons\Main\script_macros.hpp"
EXEC_CHECK(CLIENT);

private ["_delay","_templateSettings","_teamRespawnMarker","_newSideSetting","_respawnType"];

switch (side player) do {
    case west: {
        private _respawnTypeNum = GETMVAR(Type_BLUFOR,0);
        _respawnType = ["ONELIFE","UNLIMITED","INDTICK","TEAMTICK"] select _respawnTypeNum;
        _delay = GETMVAR(Delay_BLUFOR,5);
        _templateSettings = GETMVAR(Templates_BLUFOR,[]);
        private _newSideValue = GETMVAR(NewTeam_BLUFOR,0);
        _newSideSetting = [blufor,opfor,independent,civilian] select _newSideValue;
        _teamRespawnMarker = "UO_FW_RESPAWN_BLUFOR";
    };
    case east: {
        private _respawnTypeNum = GETMVAR(Type_OPFOR,0);
        _respawnType = ["ONELIFE","UNLIMITED","INDTICK","TEAMTICK"] select _respawnTypeNum;
        _delay = GETMVAR(Delay_OPFOR,5);
        _templateSettings = GETMVAR(Templates_OPFOR,[]);
        private _newSideValue = GETMVAR(NewTeam_OPFOR,1);
        _newSideSetting = [blufor,opfor,independent,civilian] select _newSideValue;
        _teamRespawnMarker = "UO_FW_RESPAWN_OPFOR";
    };
    case independent: {
        private _respawnTypeNum = GETMVAR(Type_Indfor,0);
        _respawnType = ["ONELIFE","UNLIMITED","INDTICK","TEAMTICK"] select _respawnTypeNum;
        _delay = GETMVAR(Delay_Indfor,5);
        _templateSettings = GETMVAR(Templates_Indfor,[]);
        private _newSideValue = GETMVAR(NewTeam_Indfor,2);
        _newSideSetting = [blufor,opfor,independent,civilian] select _newSideValue;
        _teamRespawnMarker = "UO_FW_RESPAWN_Indfor";
    };
    case civilian: {
        private _respawnTypeNum = GETMVAR(Type_Civilian,0);
        _respawnType = ["ONELIFE","UNLIMITED","INDTICK","TEAMTICK"] select _respawnTypeNum;
        _delay = GETMVAR(Delay_Civilian,5);
        _templateSettings = GETMVAR(Templates_Civilian,[]);
        private _newSideValue = GETMVAR(NewTeam_Civilian,3);
        _newSideSetting = [blufor,opfor,independent,civilian] select _newSideValue;
        _teamRespawnMarker = "UO_FW_RESPAWN_Civilian";
    };
};

// Reports Event & Function execution, confirm removed from queues.


if ((_respawnType isEqualto "INDTICK") || (_respawnType isEqualto "TEAMTICK") || (_respawnType isEqualto "UNLIMITED")) then {
    [{
        params ["_delay","_templateSettings","_teamRespawnMarker"];

        // Re call player init event
        ["UO_FW_PlayerInit_Event", []] call CBA_fnc_localEvent;

        // Remove Killed Displays
        if (GETMVAR(InstantDeath,true)) then {
            "UO_FW_KilledLayer" cutText ["","BLACK IN", 5];
            ["UO_FW_death", 0, false] call ace_common_fnc_setHearingCapability;
            0 fadeSound 1;
        } else {
            0 fadeSound 1;
            playSound ("Transition" + str (1 + floor random 3));
            [] call BIS_fnc_VRFadeIn;
        };

        // Handle Group Join
        if (QEGVAR(RTemplatesS,JoinGroup) in _templateSettings) then {
            private _oldGroup = GETMVAR(OLDGROUP,grpnull);
            [player] joinSilent _oldGroup;
        } else {
            if !(_newSideSetting isEqualto (side player)) then {
                [player] joinSilent (createGroup _newSideSetting);
            };
        };

        // Handle Teleport Locations
        if !(isNull (missionNamespace getVariable [_teamRespawnMarker, objNull])) then {
            [player,(getpos(missionNamespace getVariable _teamRespawnMarker)),10] call CBA_fnc_setPos;
        } else {
            [player,UO_FW_SpawnPos,30] call CBA_fnc_setPos;
        };

        // Handle Module and Gear Settings
        //CoverMap
        if ((QEGVAR(RTemplatesS,CoverMap)) in _templateSettings) then {
            [QEGVAR(CoverMap,InitEvent), []] call CBA_fnc_localEvent;
        };
        //SafeStart
        if ((QEGVAR(RTemplatesS,SafeStart)) in _templateSettings) then {
            [QEGVAR(SafeStart,Event), []] call CBA_fnc_localEvent;
        };
        //Team Colour
        if ((QEGVAR(RTemplatesS,TeamColour)) in _templateSettings) then {
            ["UO_FW_TeamColour_Event", []] call CBA_fnc_localEvent;
        };
        //Map and Compass Remover
        if ((QEGVAR(RTemplatesS,MapAndCompassRemover)) in _templateSettings) then {
            ["UO_FW_MapRemover_PlayerEvent", []] call CBA_fnc_localEvent;
        };
        //Gear
        if ((QEGVAR(RTemplatesS,Gear)) in _templateSettings) then {
            [QEGVAR(Gear,PlayerGearLoad), []] call CBA_fnc_localEvent;
        };
        //Acre
        if ((QEGVAR(RTemplatesS,Acre)) in _templateSettings) then {
            [QEGVAR(Acre,AddRadio_Event), []] call CBA_fnc_localEvent;
        };
        //StartInParachute
        if ((QEGVAR(RTemplatesS,StartInParachute)) in _templateSettings) then {
            [QEGVAR(StartInParachute,LocalEvent), []] call CBA_fnc_localEvent;
        };

    }, [_delay,_templateSettings,_teamRespawnMarker], _delay] call CBA_fnc_waitAndExecute;
};
