/*    Description: Enable Zone Module initialisation disables attached zones and creates a zone out of zone enable module that when activated enables the connected zones modules.
 *    Arguments:
 *         OBJECT    - Module (name, _logic)
 *        ARRAY    - Units (synced to module)
 *        BOOL    - Module Activated
 *     Return Value:
 *         BOOL    - True
 */
#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"

params [["_mode","",[""]],["_input",[],[[]]]];
    if (isNil QGVAR(initialised)) then {call FUNC(initMain);};
    switch _mode do {
        case "init": {
            AI_EXEC_CHECK(SERVERHC);
            _input params ["_logic",["_isActivated",true,[true]]];
            if !(_isActivated) exitWith {};
            // Disable Linked Zones
            private _syncedZoneModules = [_logic,[QGVAR(ZoneModule),QGVAR(ZoneModule_R)]] call FUNC(getSyncedModules);
            if (count _syncedZoneModules > 0) then {
                for "_z" from 0 to (count _syncedZoneModules) step 1 do {
                    private _syncedZoneModule = _syncedZoneModules select _z;
                    ([_syncedZoneModule,GVAR(Zones)] call FUNC(getDetails)) set [3, 1];
                };
            };
            //Setup Suspend Module as Zone
            private _cond = _logic getVariable [QGVAR(EnableZoneCondition),"false"];
            if (_cond isEqualType "STRING") then {_cond = compile _cond;};
            private _code = _logic getVariable [QGVAR(EnableZoneCode),"true"];
            if (_code isEqualType "STRING") then {_code = compile _code;};
            private _isRectangle = if ((typeof _logic) isEqualTo QGVAR(ZoneModule_R)) then {true} else {false};
            GVAR(Zones) pushBack [
                _logic,
                (getPosATL _logic),
                (GETVAR(_logic,EnableZoneRadiusX,200)),
                false,
                ([GETVAR(_logic,EnableZoneSide,0)] call FUNC(getSide)),
                (GVAR(zoneTypes) select (GETVAR(_logic,EnableZoneType,1))),
                _cond,
                (GETVAR(_logic,EnableZoneDelay,0)),
                _code,
                (GETVAR(_logic,EnableZoneRadiusY,200)),
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
                    (format["%1 a %2 has no Zone Modules linked.\nLink a Zone Module to the Enable Zone Module to suspend and enable Zones when the Enable Zone Module is activated.",_logic,typeof _logic]) call EFUNC(Debug,DebugMessage);
                };
                [_logic] spawn FUNC(debugSyncedModules);
            };
        };
        case "attributesChanged3DEN": {
            private _logic = _input param [0,objNull,[objNull]];
            private _radiusX = _logic getVariable [QGVAR(EnableZoneRadiusX),_logic getVariable [QGVAR(EnableZoneRadius), 100]];
            private _radiusY = _logic getVariable [QGVAR(EnableZoneRadiusY),_logic getVariable [QGVAR(EnableZoneRadius), 100]];
            set3DENAttributes [[[_logic],"size2",[_radiusX,_radiusY]]];
        };
        case "registeredToWorld3DEN": {};
        case "unregisteredFromWorld3DEN": {};
        case "connectionChanged3DEN": {};
        default {};
    };
    true
