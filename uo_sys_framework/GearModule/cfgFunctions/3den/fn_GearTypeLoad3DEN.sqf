#define COMPONENT Gear
#include "\x\UO_FW\addons\Main\script_macros.hpp"
UO_FW_EXEC_CHECK(ALL);
UO_FW_3DEN_CHECK;

params ["_object"];
LOG_1("_object: %1",_object);

if (_object isKindOf "CAManBase") then {
    private _systemType = GETVAR(_object,Gear_UnitSystemType,"NONE");
    LOG_1("_systemType: %1",_systemType);
    private _gearType = GETVAR(_object,Gear_UnitGearType,"NONE");
    LOG_1("_gearType: %1",_gearType);
    if (_systemType isEqualto "NONE") exitwith {};
    if (_gearType isEqualto "NONE") exitwith {
        ERROR_1("No loadout found for unit: %1",_object);
    };
    if (_gearType isEqualto "MANUAL") then {
        private _manualClass = GETVAR(_object,Gear_ManualUnitClass,"");
        if (_manualClass isEqualto "") exitwith {
            ERROR_1("Unit %1 is set to manual loadout but has none!, exiting gearscript.",_object);
        };
        switch (_systemType) do {
            case "ACEAR": {
                private _found = false;
                private _defaultloadoutsArray = missionNamespace getvariable ['ace_arsenal_defaultLoadoutsList',[]];
                {
                    _x params ["_name","_loadoutData"];
                    if (_manualClass == _name) exitwith {
                        _object setUnitLoadout _loadoutData;
                        LOG_2("Setting ace loadout: %1 for unit %2",_manualClass,_object);
                        _found = true;
                    };
                } foreach _defaultloadoutsArray;
                if !(_found) exitwith {
                    ERROR_1("Could not find %1 in Default Loadouts!",_manualClass);
                };
            };
            case "OLSEN": {
                LOG_2("Executing gear class: %1 for unit %2",_manualClass,_object);
                [_object,_manualClass] call UO_FW_fnc_OlsenGearScript;
            };
        };
    } else {
        private ["_SystemTag","_loadoutvarname"];
        switch (_systemType) do {
            case "ACEAR": {_SystemTag = "ACE_Arsenal"};
            case "OLSEN": {_SystemTag = "Olsen"};
        };
        switch (side _object) do {
            case west: {
                _loadoutvarname = format ["UO_FW_GearSettings_%1_LoadoutType_Blufor_%2",_SystemTag,_gearType];
            };
            case east: {
                _loadoutvarname = format ["UO_FW_GearSettings_%1_LoadoutType_Opfor_%2",_SystemTag,_gearType];
            };
            case independent: {
                _loadoutvarname = format ["UO_FW_GearSettings_%1_LoadoutType_Indfor_%2",_SystemTag,_gearType];
            };
            case civilian: {
                _loadoutvarname = format ["UO_FW_GearSettings_%1_LoadoutType_CIV_%2",_SystemTag,_gearType];
            };
        };
        private _loadoutName = missionNamespace getvariable [_loadoutvarname,"NONE"];
        if (_loadoutName isEqualto "NONE") exitwith {
            ERROR_2("No loadout found for unit: %1 and var %2",_object,_loadoutvarname);
        };
        switch (_systemType) do {
            case "ACEAR": {
                private _found = false;
                private _defaultloadoutsArray = missionNamespace getvariable ['ace_arsenal_defaultLoadoutsList',[]];
                {
                    _x params ["_name","_loadoutData"];
                    if (_loadoutName == _name) exitwith {
                        _object setUnitLoadout _loadoutData;
                        LOG_2("Setting ace loadout: %1 for unit %2",_loadoutName,_object);
                        _found = true;
                    };
                } foreach _defaultloadoutsArray;
                if !(_found) exitwith {
                    ERROR_1("Could not find %1 in Default Loadouts!",_loadoutName);
                };
            };
            case "OLSEN": {
                LOG_2("Executing gear class: %1 for unit %2",_loadoutName,_object);
                [_object,_loadoutName] call UO_FW_fnc_OlsenGearScript;
            };
        };
    };
    save3DENInventory [_object];
} else {
    private _systemType = GETVAR(_object,Gear_VehicleSystemType,"NONE");
    private _loadoutName = GETVAR(_object,Gear_VehicleGearManualType,"NONE");
    if (_systemType isEqualto "NONE") exitwith {};
    switch (_systemType) do {
        case "OLSEN": {
            if (_loadoutName isEqualto "") exitwith {
                ERROR_1("Vehicle %1 is set to manual loadout but has none!, exiting gearscript.",_object);
            };
            LOG_2("Executing gear of file: %1 for vehicle %2",_loadoutName,_object);
            [_object,_loadoutName] call UO_FW_fnc_OlsenGearScript;
        };
    };
    save3DENInventory [_object];
};