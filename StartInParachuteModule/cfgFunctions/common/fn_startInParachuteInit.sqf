#include "\x\UO_FW\addons\main\script_macros.hpp"
if(!UO_FW_SERVER_STARTINPARACHUTEMODULE_ALLOWED) exitWith {};
"" spawn
{

	if(isServer) then
	{
		{
			if(!(isPlayer _x)) then 
			{
				_parachuteType = _x getVariable ["UO_FW_StartInParachute", "NONE"];
				_altitude = _x getVariable ["UO_FW_ParachuteAltitude", 300];
				_randomAltitude = _x getVariable ["UO_FW_ParachuteRandomAltitude", 100];
				switch(_parachuteType) do
				{
					case "NONE":
					{
						
					};
					case "NONSTEERABLE":
					{
						[_x,_altitude,_randomAltitude,false] call UO_FW_FNC_DoParachute;
					};
					case "STEERABLE":
					{
						[_x,_altitude,_randomAltitude,true] call UO_FW_FNC_DoParachute;
					};
				};
			};
		}forEach allUnits;
	};
	if (!isDedicated) then 
	{
		waitUntil{(player getVariable ["UO_FW_StartInParachute", ""]) != ""};
		_parachuteType = player getVariable ["UO_FW_StartInParachute", "NONE"];
		_altitude = player getVariable ["UO_FW_ParachuteAltitude", 300];
		_randomAltitude = player getVariable ["UO_FW_ParachuteRandomAltitude", 100];
		switch(_parachuteType) do
		{
			case "NONE":
			{
				
			};
			case "NONSTEERABLE":
			{
				[player,_altitude,_randomAltitude,false] call UO_FW_FNC_DoParachute;
			};
			case "STEERABLE":
			{
				[player,_altitude,_randomAltitude,true] call UO_FW_FNC_DoParachute;
			};
		};
	};
};
