#include "\A3\ui_f\hpp\defineResinclDesign.inc"

	_this spawn {
		disableserialization;

		_display = _this select 0;
		_ctrlTitle = _display displayCtrl 1001;
		_ctrlTitleBG = _display displayCtrl 1002;
		_ctrlTime = _display displayCtrl 1003;

		_timecheckStart = serverTime;
		if (_timecheckStart isEqualto 0) then {_timecheckStart = time;};

		_endTime = _timecheckStart + (missionNamespace getVariable ["UO_FW_ST_TimeLeft", 0]);
		_nextBeep = _endTime - 10;

		_break = false;
		_run = true;

		while {_run} do {

			_timecheck = serverTime;
			if (_timecheck isEqualto 0) then {_timecheck = time;};

			if (_timecheck >= _nextBeep) then {
				_nextBeep = _nextBeep + 1;
				playSound "Beep_Target";
			};

			private _timeLeft = _endTime - _timecheck;

			_colorSet = ["IGUI","TEXT_RGB"];
			if (_timeLeft <= 30) then {
				_colorSet = ["IGUI","WARNING_RGB"];
			};

			if (_timeLeft <= 10) then {
				_colorSet = ["IGUI","ERROR_RGB"];
			};

			_color = _colorSet call bis_fnc_displaycolorget;
			_ctrlTime ctrlSetTextColor _color;

			if (_timeLeft > 0) then {
				_ctrlTime ctrlSetText ([_timeLeft,"MM:SS.MS"] call bis_fnc_secondsToString);
			} else {
				_ctrlTime ctrlSetText "00:00.000";
				["UO_FW_SetupTimerEnded"] call BIS_fnc_showNotification;
				sleep 3;
				_break = true;
			};

			if (_break) exitWith {
				_display closeDisplay 1;
				_run = false;
			};

			sleep 0.08;
		};

	};