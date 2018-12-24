/*
 * Author: Sacher
 *
 * Spawns a Vehicle, if side is defined it will try to track it
 *
 * Arguments:
 * 0: className <String>
 * 1: Position <Pos>
 * 2: side <side>
 * Return Value:
 * unit Spawned <object>
 *
 * Public: Yes
 */

private _unit =(_this select 0) createVehicle (_this select 1);
if(!isNil "UO_FW_aCount_event_addEH") then { ["UO_FW_aCount_event_addEH", _unit] call CBA_fnc_serverEvent};
if (_unit getVariable ["UO_FW_AssetName", ""] == "" && (count _this >= 3)) then
{
  {
	if (_x select 1 == (_this select 2)) exitWith {
	  _vehCfg = (configFile >> "CfgVehicles" >> (typeOf _unit));
	  if (isText(_vehCfg >> "displayName")) then
	  {
		[_unit, getText(_vehCfg >> "displayName"), _x select 0] call UO_FW_fnc_TrackAsset;
	  };
	};
  } forEach UO_FW_Teams;
};
_unit
