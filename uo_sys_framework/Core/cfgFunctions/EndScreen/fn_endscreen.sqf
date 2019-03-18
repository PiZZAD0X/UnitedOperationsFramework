#define COMPONENT Core
#include "\x\UO_FW\addons\Main\script_macros.hpp"
EXEC_CHECK(CLIENT);

params ["_scenario"];

(vehicle player) enableSimulation false;
player enableSimulation false;
removeAllWeapons player;
private _displayLayerNum = QGVAR(EndScreenLayer) cutRsc [QGVAR(endScreen), "PLAIN"];
private _bg = 3000;
private _endTitle = 3001;
private _left = 3002;
private _right = 3003;
private _leftText = "";
private _rightText = "";
private _textSide = 0;

{
    _x params ["_name", "", "", "_start", "_current", "_disabled", "_destroyed"];
    if (_start > 0) then {
        private _temp = format ["%1<br />Casualties: %2 out of %3<br />", _name, (_start - _current), _start];
        if !(count _disabled isEqualto 0) then {
            _temp = _temp + "<br />Disabled assets:<br />";
            {
                _temp = _temp + format ["%1<br />", _x];
            } forEach _disabled;
        };
        if !(count _destroyed isEqualto 0) then {
            _temp = _temp + "<br />Destroyed assets:<br />";
            {
                _temp = _temp + format ["%1<br />", _x];
            } forEach _destroyed;
        };
        _temp = _temp + "<br />";
        if (_textSide isEqualto 0) then {
            _textSide = 1;
            _leftText = _leftText + _temp;
        } else {
            _textSide = 0;
            _rightText = _rightText + _temp;
        };
    };
} forEach GVAR(Teams);
private _endTitleText = _scenario;
if !((EGETMVAR(EndConditions,Timelimit,60)) isEqualto 0) then {
    private _time = ceil(CBA_missiontime / 60);
    if (_time >= (EGETMVAR(EndConditions,Timelimit,60))) then {
        _time = (EGETMVAR(EndConditions,Timelimit,60));
    };
    private _timeLimitText = format ["Mission duration: %1 out of %2 minutes", _time, (EGETMVAR(EndConditions,Timelimit,60))];
    _endTitleText = format ["%1<br />%2", _scenario, _timeLimitText];
};
private _dia = uiNamespace getVariable QGVAR(EndScreenDisplay);
(_dia displayCtrl _endTitle) ctrlSetStructuredText parseText _endTitleText;
(_dia displayCtrl _left) ctrlSetStructuredText parseText _leftText;
(_dia displayCtrl _right) ctrlSetStructuredText parseText _rightText;
[{
    params ["_args", "_idPFH"];
    _args params ["_dia","_bg","_startTime"];
    private _timeDifference = (CBA_missiontime - _startTime);
    if ((_timeDifference > 0) && {(_timeDifference <= 5)}) then {
        (_dia displayCtrl _bg) ctrlSetBackgroundColor [0, 0, 0, (0 + (_timeDifference / 5))];
    };
    if (_timeDifference < 30) exitwith {};
    [_idPFH] call CBA_fnc_removePerFrameHandler;
    endMission "END1";
}, 0, [_dia, _bg, CBA_missionTime]] call CBA_fnc_addPerFrameHandler;
