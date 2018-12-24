#include "\A3\ui_f\hpp\defineResinclDesign.inc"

_this spawn
{
	disableserialization;

	_display = _this select 0;
	_ctrlTitle = _display displayCtrl 1001;
	_ctrlTitleBG = _display displayCtrl 1002;
	_ctrlTime = _display displayCtrl 1003;

	_timecheckInit = serverTime;
	if (_timecheckInit isEqualto 0) then {_timecheckInit = time;};
	_endTime = _timecheckInit + (missionNamespace getVariable ["UO_FW_AOL_TimeLeft", 30]);
	_nextBeep = _endTime - 10;

	["AOLimitWarning"] call BIS_fnc_showNotification;

	missionNamespace setVariable ["UO_FW_AOL_DisplayOpen", true];

	_break = false;

	while {true} do {

		_shouldDisplay = missionNamespace getVariable ["UO_FW_AOL_Display", false];

		_timecheck = serverTime;
		if (_timecheck isEqualto 0) then {_timecheck = time;};

		if (_timecheck >= _nextBeep) then {
			_nextBeep = _nextBeep + 1;
			playSound "Beep_Target";
		};

		private "_timeLeft";
		_timeLeft = _endTime - _timecheck;

		_colorSet = ["IGUI","TEXT_RGB"];
		if (_timeLeft <= 10) then {
			_colorSet = ["IGUI","WARNING_RGB"];
		};

		if (_timeLeft <= 5) then {
			_colorSet = ["IGUI","ERROR_RGB"];
		};

		_color = _colorSet call bis_fnc_displaycolorget;
		_ctrlTime ctrlSetTextColor _color;

		if (_timeLeft > 0) then {
			_ctrlTime ctrlSetText ([_timeLeft,"MM:SS.MS"] call bis_fnc_secondsToString);
		} else {
			_ctrlTime ctrlSetText "00:00.000";
			player setDamage 1;
			sleep 3;
			_break = true;
		};

		if (_break || !_shouldDisplay) exitWith {
			missionNamespace setVariable ["UO_FW_AOL_DisplayOpen", false];
			_display closeDisplay 1;
		};

		sleep 0.08;
	};

};