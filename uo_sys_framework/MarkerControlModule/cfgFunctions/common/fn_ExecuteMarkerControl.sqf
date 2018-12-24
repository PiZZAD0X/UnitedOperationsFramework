#include "\x\UO_FW\addons\main\script_macros.hpp"


private ["_markers","_isValid"];
_markers = _this;
_isValid = _markers call UO_FW_fnc_ValidateMarkerControl;
if(!_isValid) exitWith { UO_FW_DEBUG("Marker Control Module Failed to validate!","Marker Control Module Failed to validate!")};
["Marker Control", "Allows the mission maker to create markers visible to a single side.", "Olsen amd Sacher"] call UO_FW_FNC_RegisterModule;
{
	if ((_x select 0) != (side player)) then
	{
		(_x select 1) setMarkerAlphaLocal 0;
	};
} forEach _markers;

[{time > 0},
{
	{
		if (_x select 2) then
		{
			(_x select 1) setMarkerAlphaLocal 0;
		};
	} forEach _this;
}, _markers] call CBA_fnc_WaitUntilAndExecute;