/*    Description: Control Module performs three functions
 *        1) On initialisation can disable/enable/nothing to synced zone modules, configurable in settings under initiate action
 *        2) Creates a zone out of the control module which is fully functional as a zone
 *        3) When the control modules zone is activated can enable/disable any synced zone modules, configurable for either in settings under activate action
 *    Arguments:
 *         OBJECT    - Module (name, _logic)
 *        ARRAY    - Units (synced to module)
 *        BOOL    - Module Activated
 *     Return Value:
 *         BOOL    - True
 */
#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"

params [["_mode","",[""]],["_input",[],[[]]]];
    if (isNil QGVAR(initialised)) then {call FUNC(init);};
    switch _mode do {
        case "init": {
            AI_EXEC_CHECK(ALL);
            if !is3DEN then {
                _input params ["_logic",["_isActivated",true,[true]]];
                if !(_isActivated) exitWith {};
                AI_EXEC_CHECK(SERVERHC);
                //Check if should disable/enable linked zones or do nothing. default: do nothing
                switch (GETVAR(_logic,ControlInitAction,0)) do {
                    case 1 : {
                        // Disable Linked Zones
                        [([_logic,[QGVAR(ZoneModule),QGVAR(ZoneModule_R)]] call FUNC(getSyncedModules)),1] call FUNC(setZone);
                    };
                    case 2 : {
                        // Enable Linked Zones
                        [([_logic,[QGVAR(ZoneModule),QGVAR(ZoneModule_R)]] call FUNC(getSyncedModules)),0] call FUNC(setZone);
                    };
                    default {};
                };
                //Setup Control Module as Zone
                private _cond = _logic getVariable [QGVAR(ControlCondition),"false"];
                if (_cond isEqualType "STRING") then {_cond = compile _cond;};
                private _code = _logic getVariable [QGVAR(ControlCode),"true"];
                if (_code isEqualType "STRING") then {_code = compile _code;};
                private _isRectangle = if ((typeof _logic) isEqualTo QGVAR(ControlModule_R)) then {true} else {false};
                GVAR(Zones) pushBack [
                    _logic,
                    (getPosATL _logic),
                    (GETVAR(_logic,ControlRadiusX,200)),
                    (GETVAR(_logic,controlOn,0)),
                    ([GETVAR(_logic,ControlSide,0)] call FUNC(getSide)),
                    (GVAR(zoneTypes) select (GETVAR(_logic,ControlType,1))),
                    _cond,
                    (GETVAR(_logic,ControlDelay,0)),
                    _code,
                    (GETVAR(_logic,ControlRadiusY,200)),
                    _isRectangle,
                    (getDir _logic),
                    (GETVAR(_logic,ZoneHazard,false)),
                    (GETVAR(_logic,zoneSuspend,0))
                ];
                private _entities = [_logic] call FUNC(getSyncedObjects);
                GVAR(zoneEntities) pushBack [_logic,_entities];
                if (GETMVAR(Debug,false)) then {
                    private _syncedZoneModule = [_logic,[QGVAR(ZoneModule),QGVAR(ZoneModule_R)]] call FUNC(getSyncedModules);
                    if (_syncedZoneModule isEqualto []) then {
                        LOG_2("%1 a %2 has no Zone Modules linked.\nLink a Zone Module to the Enable/Disable the zone when the Control Module is activated.",_logic,typeof _logic);
                    };
                    [_logic] spawn FUNC(debugSyncedModules);
                };

            };
        };
        case "attributesChanged3DEN": {
            private _logic = _input param [0,objNull,[objNull]];
            private _radiusX = _logic getVariable [QGVAR(ControlRadiusX),_logic getVariable [QGVAR(ControlRadius), 100]];
            private _radiusY = _logic getVariable [QGVAR(ControlRadiusY),_logic getVariable [QGVAR(ControlRadius), 100]];
            set3DENAttributes [[[_logic],"size2",[_radiusX,_radiusY]]];
        };
        case "registeredToWorld3DEN": {};
        case "unregisteredFromWorld3DEN": {};
        case "connectionChanged3DEN": {};
        default {};
    };
    true
