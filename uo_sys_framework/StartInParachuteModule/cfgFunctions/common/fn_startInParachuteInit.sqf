#include "\x\UO_FW\addons\main\script_macros.hpp"

if !(UO_FW_SERVER_STARTINPARACHUTEMODULE_ALLOWED) exitwith {};

if(isServer) then {
	{
			_parachuteType = _x getVariable ["UO_FW_StartInParachute", "NONE"];
			_altitude = _x getVariable ["UO_FW_ParachuteAltitude", 300];
			_randomAltitude = _x getVariable ["UO_FW_ParachuteRandomAltitude", 100];
			switch(_parachuteType) do
			{
				case "NONE": {};
				case "NONSTEERABLE": {
					[_x,_altitude,_randomAltitude,false] call UO_FW_FNC_DoParachute;
				};
				case "STEERABLE": {
					[_x,_altitude,_randomAltitude,true] call UO_FW_FNC_DoParachute;
				};
			};
	} forEach (allUnits select {!(isPlayer _x)});
	_id = ["Event_PlayerParachuteJipped",
	{
		_unit = _this select 0;
		_parachuteType = _unit getVariable ["UO_FW_StartInParachute", "NONE"];
		_altitude = _unit getVariable ["UO_FW_ParachuteAltitude", 300];
		_randomAltitude = _unit getVariable ["UO_FW_ParachuteRandomAltitude", 100];
		switch(_parachuteType) do
		{
			case "NONE": {};
			case "NONSTEERABLE": {
				["Event_PlayerDoParachute", [_altitude,_randomAltitude,false],_unit] call CBA_fnc_targetEvent;
			};
			case "STEERABLE": {
				["Event_PlayerDoParachute", [_altitude,_randomAltitude,true],_unit] call CBA_fnc_targetEvent;
			};
		};
	}] call CBA_fnc_addEventHandler;
};

if (!isDedicated) then {
	[{!isNull player}, {
	_id = ["Event_PlayerDoParachute", {[player,_this select 0,_this select 1,_this select 2] call UO_FW_FNC_DoParachute;}] call CBA_fnc_addEventHandler;
	["Event_PlayerParachuteJipped", [player]] call CBA_fnc_serverEvent;
	}] call CBA_fnc_waitUntilAndExecute;
};