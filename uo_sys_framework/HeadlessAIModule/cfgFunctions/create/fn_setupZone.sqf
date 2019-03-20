#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params ["_logic",["_delay",0,[0]],["_code",{},[{}]],["_initial",false],["_entitiesArray",[],[[]]]];
private ["_entities"];
LOG_1("setupZone started _logic: %1",_logic);
if !(_initial) then {
    if ((tolower(typeOf _logic)) in [QGVAR(controlmodule), QGVAR(controlmodule_r)]) then {
        [_logic] spawn {
            params ["_logic"];
            switch (GETVAR(_logic,ControlAction,0)) do {
                case 0 : {
                    // Enable Linked Zones
                    [([_logic,[QGVAR(ZoneModule),QGVAR(ZoneModule_R)]] call FUNC(getSyncedModules)),0] call FUNC(setZone);
                };
                case 1 : {
                    // Disable Linked Zones
                    [([_logic,[QGVAR(ZoneModule),QGVAR(ZoneModule_R)]] call FUNC(getSyncedModules)),1] call FUNC(setZone);
                };
                case 2 : {
                    // Toggle Linked Zones
                    [([_logic,[QGVAR(ZoneModule),QGVAR(ZoneModule_R)]] call FUNC(getSyncedModules)),2] call FUNC(setZone);
                };
            };
        };
    };
};
//TODO
//private _syncedFunctions = [_logic,GVAR(functions)] call FUNC(getSyncedModules);
//if (count _syncedFunctions > 0) then {
//    [_syncedFunctions,_delay] spawn FUNC(createFunctions);
//};
LOG_2("_logic: %1 _initial: %2",_logic,_initial);
if (_initial) then {
    _entities = _entitiesArray;
} else {
    _entities = (([_logic,GVAR(zoneEntities)] call FUNC(getDetails)) select 1);
};
LOG_2("_logic: %1 _entities: %2",_logic,_entities);
if !(_entities isEqualto []) then {
    if (!isMultiplayer) then {
        LOG("!isMultiplayer, createZone function executed");
        [[_logic,_entities,_delay,_code],_initial] call FUNC(createZone);
    } else {
        params ["_logic","_entities","_delay","_code","_initial"];
        LOG_1("sending createZone function to clientid %1",GVAR(HC_ID));
        [[[_logic,_entities,_delay,_code],_initial], {if (GVAR(HC_isHC)) then {_this call FUNC(createZone);};}] remoteExec ["bis_fnc_call", GVAR(HC_ID)];
    };
};

//private _entities = (([_logic,GVAR(zoneEntities)] call FUNC(getDetails)) select 1);
//if (count _entities > 0) then {
//    if (_initial) then {
//        [_logic,_entities,_code] call FUNC(createZoneInit);
//        _logic setvariable ["initiallyspawned",true];
//    } else {
//        [_logic,_entities,_delay,_code] call FUNC(createZone);
//    };
//};

{
    {
        [[_x,(_x getVariable QGVAR(Template)),_delay,_code]] spawn FUNC(createZone);
    } foreach ([_x,[QGVAR(TemplateModule)]] call FUNC(getSyncedModules));
} foreach ([_logic,[QGVAR(PositionModule)]] call FUNC(getSyncedModules));
//for "_p" from 0 to (count _posModules) step 1 do {
//    private _tempModules = [(_posModules select _p),[QGVAR(TemplateModule)]] call FUNC(getSyncedModules);
//    for "_t" from 0 to (count _tempModules) step 1 do {
//        [(_tempModules select _t),((_tempModules select _t) getVariable QGVAR(Template)),_delay,{}] spawn FUNC(createZone);
//    };
//};
{
    _x spawn FUNC(setRespawn);
} forEach ([_logic,[QGVAR(RespawnModule)]] call FUNC(getSyncedModules));
true
