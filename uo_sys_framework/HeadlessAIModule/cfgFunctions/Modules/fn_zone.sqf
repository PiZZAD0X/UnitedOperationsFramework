/*    Description: Zone Module initialisation creates the zone.
 *    Arguments:
 *         OBJECT    - Module (name, _logic)
 *        ARRAY    - Units (synced to module)
 *        BOOL    - Module Activated
 *     Return Value:
 *         BOOL    - True
 *    Author
 *        suits & PiZZADOX
 */

#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"

params [["_mode","",[""]],["_input",[],[[]]]];
switch _mode do {
    case "init": {
        AI_EXEC_CHECK(SERVERHC);
        if (isNil QGVAR(initialised)) then {[] call FUNC(initMain);};
        _input params ["_logic",["_isActivated",true,[true]]];
        if !(_isActivated) exitWith {};
        {
            GVAR(respawns) pushBack _x;
        } forEach ([_logic,[QGVAR(RespawnModule)]] call FUNC(getSyncedModules));

        private _initial = GETVAR(_logic,zoneInitial,false);
        private _code = _logic getVariable [QGVAR(zoneCode),""];
        _code = compile _code;
        private _cond = _logic getVariable [QGVAR(zoneCondition),""];
        _cond = compile _cond;
        private _isRectangle = if ((typeof _logic) isEqualTo QGVAR(ZoneModule_R)) then {true} else {false};
        private _entities = [_logic] call FUNC(getSyncedObjects);
        LOG_1("_entities: %1",_entities);

        if (_initial) then {
            [_logic,0,_code,_initial,_entities] call FUNC(setupZone);
            _logic setVariable [QGVAR(zone_activated),true];
            LOG_1("_zone: %1 initially activated",_logic);
        } else {
            GVAR(Zones) pushBack [
                _logic,
                (getPosATL _logic),
                (GETVAR(_logic,zoneRadiusX,100)),
                false,
                ([GETVAR(_logic,Zoneside,4)] call FUNC(getSide)),
                (GVAR(zoneTypes) select (GETVAR(_logic,zoneType,1))),
                _cond,
                (GETVAR(_logic,zoneDelay,0)),
                _code,
                (GETVAR(_logic,zoneRadiusY,100)),
                _isRectangle,
                (getDir _logic),
                (GETVAR(_logic,ZoneHazard,false)),
                (GETVAR(_logic,zoneSuspend,0))
            ];

            LOG_1("_zone added to Zones array: %1",_logic);
            LOG_2("_zone: %1 entities: %2",_logic,_entities);
            GVAR(zoneEntities) pushBack [_logic,_entities];
            GVAR(zoneInit) pushBack _logic;
            if ((count GVAR(zoneInit)) >= (count (entities [[QGVAR(ZoneModule_R),QGVAR(ZoneModule)],[]])) && {!GVAR(templateCleanup)}) then {
                GVAR(templatesyncedObjects) = GVAR(templatesyncedObjects) arrayIntersect GVAR(templatesyncedObjects);
                [GVAR(templatesyncedObjects)] call FUNC(deleteVehicles);
                GVAR(templateCleanup) = true;
            };

            if (GETMVAR(Debug,false)) then {
                private _syncedModules = [_logic,[]] call FUNC(getSyncedModules);
                _entities params [["_grps",[],[[]]],["_emptyvehs",[],[[]]],["_objs",[],[[]]]];
                if ((_syncedModules isEqualto [])
                    && {({(count _x) > 0 } count _grps) == 0}
                    && {({(count _x) > 0 } count _emptyvehs) == 0}
                    && {({(count _x) > 0 } count _objs) == 0}
                ) then {
                    LOG_2("%1 a %2 has nothing linked.\nYou can link Units, Groups, Objects or other modules to a Zone Module.",_logic,typeof _logic);
                };
                [_logic] spawn FUNC(debugSyncedModules);
            };
        };
    };
    case "attributesChanged3DEN": {
        private _logic = _input param [0,objNull,[objNull]];
        private _radiusX = _logic getVariable [QGVAR(zoneRadiusX),_logic getVariable [QGVAR(zoneRadiusX), 100]];
        private _radiusY = _logic getVariable [QGVAR(zoneRadiusY),_logic getVariable [QGVAR(zoneRadiusY), 100]];
        set3DENAttributes [[[_logic],"size2",[_radiusX,_radiusY]]];
    };
    default {};
};
true
