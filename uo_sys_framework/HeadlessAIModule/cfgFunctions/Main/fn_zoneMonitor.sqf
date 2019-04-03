/*  Zone Monitor monitors each zone for players and initiates the loading of the zone when activated (player in range).
 *     Arguments:
 *         NIL
 *     Return Value:
 *         BOOL    - True
 *    Author
 *        suits & PiZZADOX
 */
#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

GVAR(ZoneMonitorPFH) = [{
    params ["_args","_idPFH"];
    _args params ["_lastTimeChecked"];
    if (CBA_MissionTime < (_lastTimeChecked + 5)) exitwith {};
    LOG("Checking Zones");
    _args set [0,CBA_MissionTime];
    {
        _x params ["_zone","_loc","_radiusX","_isOn","_side","_Type","_cond","_delay","_code","_radiusY","_isRectangle","_direction","_suspended"];
        LOG_1("zone checked: %1",_x);
        private _shouldBeOn = false;
        private _area = [_loc,_radiusX,_radiusY,_direction,_isRectangle];
        private _aliveplayers = [] call EFUNC(Core,alivePlayers);
        _shouldBeOn = ({
            private _player = _x;
            (({(vehicle _player) isKindOf _x} count _Type) > 0)
            && {(side _player) in _side}
            && {_player inArea _area}
        } count _aliveplayers > 0);
        LOG_1("_shouldBeOn: %1",_shouldBeOn);
        if (_shouldBeOn && {!_isOn} && {(call _cond)}) exitwith {
            LOG_1("setup _zone: %1",_zone);
            [_zone,_delay,_code] spawn FUNC(setupZone);
            _isOn = true;
            _x set [3, _isOn];
            _zone setVariable [QGVAR(zone_activated),true];
        };
    } forEach GVAR(Zones);
}, 5, [CBA_MissionTime]] call CBA_fnc_addPerFrameHandler;
