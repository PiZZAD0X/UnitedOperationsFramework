#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params ["_args",["_initmode",false,[false]]];
_args params [["_zone",objNull,[objNull]],["_entities",[],[[]]],["_delay",0,[0]],"_code"];

LOG_2("CreateZone _args: %1 _initmode: %2",_args,_initmode);
if !(_initmode) then {
    sleep _delay;
};
_entities params [["_grps",[],[[]]],["_emptyvehs",[],[[]]],["_objs",[],[[]]]];
{
    private _veh = _x;
    private _vehicle = createVehicle [(_veh select 0),(_veh select 1),[],0,"CAN_COLLIDE"];
    _vehicle setPosATL (_veh select 1);
    _vehicle setVectorDirAndUp [_veh select 2,_veh select 3];
    _vehicle setDamage (_veh select 4);
    _vehicle setFuel (_veh select 5);
    {
        _x params [["_class","",[""]],["_path",[],[[]]],["_ammo",0,[0]]];
        _vehicle setMagazineTurretAmmo [_class,_ammo,_path];
    } forEach (_veh select 6);
    _vehicle lock (_veh select 7);
    if ((count (_veh select 9)) > 1) then {
        missionNamespace setVariable[(_veh select 9), _vehicle];
    };
    [_vehicle,(_veh select 10)] call FUNC(setPersistent);
    if !(_initmode) then {
        sleep 0.25;
        _vehicle spawn (_veh select 11);
    } else {
        _vehicle call (_veh select 11);
    };
} forEach _emptyvehs;
{
    private _obj = _x;
    private _object = createVehicle [(_obj select 0),(_obj select 1),[],0,"CAN_COLLIDE"];
    _object setVectorDirAndUp [_obj select 2,_obj select 3];
    _object setPosATL (_obj select 1);
    _object setVariable ["persistent",true,true];
    _object setDamage (_obj select 4);
    if ((count (_obj select 6)) > 1) then {
        missionNamespace setVariable[(_obj select 6), _object];
    };
    [_object,(_obj select 7)] call FUNC(setPersistent);
    _object spawn (_obj select 8);
    if !(_initmode) then {
        sleep 0.25;
    };
} forEach _objs;
{
    private _grpSet = _x select 1;
    if (((_grpSet select 15) > 0) && {!(_grpSet select 16)}) then {
        if (_initmode) then {
            [_x,true] call FUNC(createOccupyGroup);
        } else {
            [_x,false] spawn FUNC(createOccupyGroup);
        };
    } else {
        if (_initmode) then {
            [_x,true] call FUNC(createGroup);
        } else {
            [_x,false] spawn FUNC(createGroup);
        };
    };
    if !(_initmode) then {
        sleep 0.25;
    };
} forEach _grps;
if (_initmode) then {
    [_zone] call _code;
    ([_zone,[QGVAR(TaskModule)]] call FUNC(getSyncedModules)) call FUNC(taskActivate);
} else {
    [_zone] spawn _code;
    ([_zone,[QGVAR(TaskModule)]] call FUNC(getSyncedModules)) spawn FUNC(taskActivate);
};
true
