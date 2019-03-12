#define COMPONENT ShotCount
#include "\x\UO_FW\addons\Main\script_macros.hpp"
EXEC_CHECK(CLIENT);

[QGVAR(DisplayEvent), {
    if !(UO_FW_Server_ShotCountModule_Allowed) exitwith {};
    if !(MGETMVAR(ShotCount_Enabled,false)) exitwith {};
    LOG_1("Display_Event published with: %1",_this);
    [{!((uiNamespace getVariable [QMGVAR(EndScreen),""]) isEqualto "")}, {
        _this params ["_textBLU","_textOPF","_textIND","_textCIV"];
        private _endscreenDiag = (uiNamespace getVariable QMGVAR(EndScreen));
        LOG_1("_endscreenDiag: %1",_endscreenDiag);
        private _bottomLeft = 3004;
        private _bottomMiddleLeft = 3005;
        private _bottomMiddleRight = 3006;
        private _bottomRight = 3007;
        (_endscreenDiag displayCtrl _bottomLeft) ctrlSetStructuredText parseText _textBLU;
        (_endscreenDiag displayCtrl _bottomMiddleLeft) ctrlSetStructuredText parseText _textOPF;
        (_endscreenDiag displayCtrl _bottomMiddleRight) ctrlSetStructuredText parseText _textIND;
        (_endscreenDiag displayCtrl _bottomRight) ctrlSetStructuredText parseText _textCIV;
    }, _this] call CBA_fnc_waitUntilAndExecute;
}] call CBA_fnc_addEventHandler;
