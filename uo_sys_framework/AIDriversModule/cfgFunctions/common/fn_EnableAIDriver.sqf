/*    Description: Gives AI Driver actions to vehicle
 *    Arguments:
 *         OBJECT - vehicle
 *    Return Value:
 *         ARRAY
 *    Author
 *        BlackHawk & PiZZADOX
 */

#define COMPONENT AIDrivers
#include "\x\UO_FW\addons\Main\script_macros.hpp"
EXEC_CHECK(ALL);

params ["_veh","_enableNV","_enableFlip"];
if (isNil QGVAR(Vehicle)) then {GVAR(Vehicle) = objNull;};

if (_veh getvariable ["UO_FW_hasAIDriversActions",false]) exitwith {};

//AI driver action
private _action = ["ai_driver","Add/Remove AI driver","",{
    [_target, _player] call FUNC(Toggle);
},{
    (vehicle _player == _target) && {((assignedVehicleRole _player) select 0) == "Turret"} && {GVAR(Vehicle) in [objNull, vehicle _player]}
}] call ace_interact_menu_fnc_createAction;

//unflip action
private _unflipAction = ["ai_driver_unflip","Unflip vehicle","",{
    [_target, surfaceNormal position _target] remoteExec ["setVectorUp", _target, false];
    _target setPos [getpos _target select 0, getpos _target select 1, (getpos _target select 2) + 2];
},{
    (vehicle _player == _target) && {((assignedVehicleRole _player) select 0) == "Turret"} && {(vectorUp _target) select 2 < 0}
}] call ace_interact_menu_fnc_createAction;

//engine off action
private _engineOffAction = ["ai_driver_engineoff","Turn off engine","",{
    [_target, false] remoteExec ["engineOn", _target];
},{
    (vehicle _player == _target) && {((assignedVehicleRole _player) select 0) == "Turret"} && {isEngineOn _target}
}] call ace_interact_menu_fnc_createAction;

//PIP action
private _pipAction = ["ai_driver_pip","Enable/Disable driver's view","",{
    (isNil QGVAR(DriverCam) || {isNull GVAR(DriverCam)}) call  FUNC(ToggleDriverCam);
},{
    (vehicle _player == _target) && {((assignedVehicleRole _player) select 0) == "Turret"} && {!isNull (GETVAR(_target,driver,objnull))}
}] call ace_interact_menu_fnc_createAction;

//toggle NV for PIP
private _pipNvAction = ["ai_driver_pip_nv","Enable/Disable NV in driver's view","",{
    if (isNil QGVAR(pipNvEnabled)) then {
        GVAR(pipNvEnabled) = false;
    };
    "FW_rtt" setPiPEffect ([[1], [0]] select GVAR(pipNvEnabled));
    GVAR(pipNvEnabled) = !GVAR(pipNvEnabled);
},{
    (vehicle _player == _target) &&
    {((assignedVehicleRole _player) select 0) == "Turret"} &&
    {(!isNil QGVAR(DriverCam) && {!isNull GVAR(DriverCam)})}
}] call ace_interact_menu_fnc_createAction;

[_veh, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;
[_veh, 1, ["ACE_SelfActions"], _engineOffAction] call ace_interact_menu_fnc_addActionToObject;
[_veh, 1, ["ACE_SelfActions"], _pipAction] call ace_interact_menu_fnc_addActionToObject;

if ( _enableFlip) then {
    [_veh, 1, ["ACE_SelfActions"], _unflipAction] call ace_interact_menu_fnc_addActionToObject;
};

if (_enableNV ) then {
    [_veh, 1, ["ACE_SelfActions"], _pipNvAction] call ace_interact_menu_fnc_addActionToObject;
};

SETPVAR(_veh,hasAIDriversActions,true);
