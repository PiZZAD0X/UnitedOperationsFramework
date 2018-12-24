/*	Description: Gets synced modules list and checks if correct modules linked.
 *	Displays error message in debug mode if wrong links exist.
 * 	Arguments:
 * 		OBJECT	- Module (name, _logic)
 * 	Return Value:
 * 		BOOL 	- True
 */
#include "\x\UO_FW\addons\main\HeadlessAIModule\module_macros.hpp"
UO_FW_AI_EXEC_CHECK(SERVERHC)
params ["_logic"];
private _type	= typeof _logic;
private _synced = synchronizedObjects _logic;
switch (_type) do {
	case "UO_FW_AI_ZoneModule_R";
	case "UO_FW_AI_ZoneModule": {
		private _allowedLinks = ["UO_FW_AI_ControlModule","UO_FW_AI_ControlModule_R","UO_FW_AI_TaskModule","UO_FW_AI_PositionModule","UO_FW_AI_PositionModule_R","UO_FW_AI_FastAirStrikeModule","UO_FW_AI_AirDropModule","UO_FW_AI_HeloInsertModule","UO_FW_AI_RespawnModule","Group","Object","Vehicle"];
		for [{_j=0}, {(_j < count _synced)}, {_j = _j + 1}] do {
			private _syncItem = _synced select _j;
			private _check = "";
			if(_syncItem isKindOf "Man") then {
				_check = "Group";
			} else {
				if(_syncItem isKindOf "Thing") then {
					_check = "Object";
				} else {
					if((_syncItem isKindOf "StaticWeapon" || _syncItem isKindOf "Static" || _syncItem isKindOf "Air" || _syncItem isKindOf "Ship" || _syncItem isKindOf "LandVehicle")) then {
						_check = "Vehicle";
					} else {
						_check = typeof _syncItem;
					};
				};
			};
			private _allowed = _check in _allowedLinks;
			if (!_allowed) then {
				if (_logic != _syncItem) then {(format["%2 a %3 is incorrectly linked to %1 a %4.",_logic,_syncItem,_check,_type]) call UO_FW_fnc_DebugMessage;};
			};
		};
	};
	case "UO_FW_AI_TaskModule": {
		private _allowedLinks = ["UO_FW_AI_ZoneModule","UO_FW_AI_ZoneModule_R","UO_FW_AI_TaskModule","Group"];
		for [{_j=0}, {(_j < count _synced)}, {_j = _j + 1}] do {
			private _syncItem = _synced select _j;
			private _check = "";
			if(_syncItem isKindOf "Man" || _syncItem isKindOf "AllVehicles" || _syncItem isKindOf "StaticWeapon" || _syncItem isKindOf "Static" || _syncItem isKindOf "Air" || _syncItem isKindOf "Ship" || _syncItem isKindOf "LandVehicle") then {_check = "Group";} else {_check = typeof _syncItem;};
			private _allowed = _check in _allowedLinks;
			if (!_allowed) then {
				if (_logic != _syncItem) then {(format["%2 a %3 is incorrectly linked to %1 a %4.",_logic,_syncItem,_check,_type]) call UO_FW_fnc_DebugMessage;};
			};
		};
	};
	case "UO_FW_AI_ControlModule_R";
	case "UO_FW_AI_ControlModule": {
		private _allowedLinks = ["UO_FW_AI_ZoneModule","UO_FW_AI_ZoneModule_R","Group","Object","Vehicle"];
		for [{_j=0}, {(_j < count _synced)}, {_j = _j + 1}] do {
			private _syncItem = _synced select _j;
			private _check = "";
			if(_syncItem isKindOf "Man") then {
				_check = "Group";
			} else {
				if(_syncItem isKindOf "Thing") then {
					_check = "Object";
				} else {
					if((_syncItem isKindOf "StaticWeapon" || _syncItem isKindOf "Static" || _syncItem isKindOf "Air" || _syncItem isKindOf "Ship" || _syncItem isKindOf "LandVehicle")) then {
						_check = "Vehicle";
					} else {
						_check = typeof _syncItem;
					};
				};
			};
			private _allowed = _check in _allowedLinks;
			if (!_allowed) then {
				if (_logic != _syncItem) then {(format["%2 a %3 is incorrectly linked to %1 a %4.",_logic,_syncItem,_check,_type]) call UO_FW_fnc_DebugMessage;};
			};
		};
	};
	case "UO_FW_AI_FastAirStrikeModule": {
		private _allowedLinks = ["UO_FW_AI_ZoneModule","UO_FW_AI_ZoneModule_R","UO_FW_AI_PositionModule","UO_FW_AI_PositionModule_R","UO_FW_AI_TemplateModule","Vehicle"];
		for [{_j=0}, {(_j < count _synced)}, {_j = _j + 1}] do {
			private _syncItem = _synced select _j;
			private _check = "";
			if( _syncItem isKindOf "Air") then {
				_check = "Vehicle";
			} else {
				_check = typeof _syncItem;
			};
			private _allowed = _check in _allowedLinks;
			if (!_allowed) then {
				if (_logic != _syncItem) then {(format["%2 a %3 is incorrectly linked to %1 a %4.",_logic,_syncItem,_check,_type]) call UO_FW_fnc_DebugMessage;};
			};
		};
	};
	case "UO_FW_AI_AirDropModule": {
		private _allowedLinks = ["UO_FW_AI_ZoneModule","UO_FW_AI_ZoneModule_R","UO_FW_AI_PositionModule","UO_FW_AI_PositionModule_R","UO_FW_AI_TemplateModule"];
		for [{_j=0}, {(_j < count _synced)}, {_j = _j + 1}] do {
			private _syncItem = _synced select _j;
			private _check = typeof _syncItem;
			private _allowed = _check in _allowedLinks;
			if (!_allowed) then {
				if (_logic != _syncItem) then {(format["%2 a %3 is incorrectly linked to %1 a %4.",_logic,_syncItem,_check,_type]) call UO_FW_fnc_DebugMessage;};
			};
		};
	};
	case "UO_FW_AI_HeloInsertModule": {
		private _allowedLinks = ["UO_FW_AI_ZoneModule","UO_FW_AI_ZoneModule_R","UO_FW_AI_PositionModule","UO_FW_AI_PositionModule_R","UO_FW_AI_TemplateModule"];
		for [{_j=0}, {(_j < count _synced)}, {_j = _j + 1}] do {
			private _syncItem = _synced select _j;
			private _check = typeof _syncItem;
			private _allowed = _check in _allowedLinks;
			if (!_allowed) then {
				if (_logic != _syncItem) then {(format["%2 a %3 is incorrectly linked to %1 a %4.",_logic,_syncItem,_check,_type]) call UO_FW_fnc_DebugMessage;};
			};
		};
	};
	case "UO_FW_AI_PositionModule_R";
	case "UO_FW_AI_PositionModule": {
		private _allowedLinks = ["UO_FW_AI_ZoneModule","UO_FW_AI_ZoneModule_R","UO_FW_AI_TemplateModule","UO_FW_AI_FastAirStrikeModule","UO_FW_AI_AirDropModule","UO_FW_AI_HeloInsertModule","UO_FW_NonCombatantModule","Group","Object","Vehicle"];
		for [{_j=0}, {(_j < count _synced)}, {_j = _j + 1}] do {
			private _syncItem = _synced select _j;
			private _check = "";
			if(_syncItem isKindOf "Man") then {
				_check = "Group";
			} else {
				if(_syncItem isKindOf "Thing") then {
					_check = "Object";
				} else {
					if((_syncItem isKindOf "StaticWeapon" || _syncItem isKindOf "Static" || _syncItem isKindOf "Air" || _syncItem isKindOf "Ship" || _syncItem isKindOf "LandVehicle")) then {
						_check = "Vehicle";
					} else {
						_check = typeof _syncItem;
					};
				};
			};
			private _allowed = _check in _allowedLinks;
			if (!_allowed) then {
				if (_logic != _syncItem) then {(format["%2 a %3 is incorrectly linked to %1 a %4.",_logic,_syncItem,_check,_type]) call UO_FW_fnc_DebugMessage;};
			};
		};
	};
	case "UO_FW_AI_TemplateModule": {
		private _allowedLinks = ["UO_FW_AI_PositionModule","UO_FW_AI_PositionModule_R","UO_FW_AI_FastAirStrikeModule","UO_FW_AI_AirDropModule","UO_FW_AI_HeloInsertModule","Group","Object","Vehicle"];
		for [{_j=0}, {(_j < count _synced)}, {_j = _j + 1}] do {
			private _syncItem = _synced select _j;
			private _check = "";
			if(_syncItem isKindOf "Man") then {
				_check = "Group";
			} else {
				if(_syncItem isKindOf "Thing") then {
					_check = "Object";
				} else {
					if((_syncItem isKindOf "StaticWeapon" || _syncItem isKindOf "Static" || _syncItem isKindOf "Air" || _syncItem isKindOf "Ship" || _syncItem isKindOf "LandVehicle")) then {
						_check = "Vehicle";
					} else {
						_check = typeof _syncItem;
					};
				};
			};
			private _allowed = _check in _allowedLinks;
			if (!_allowed) then {
				if (_logic != _syncItem) then {(format["%2 a %3 is incorrectly linked to %1 a %4.",_logic,_syncItem,_check,_type]) call UO_FW_fnc_DebugMessage;};
			};
		};
	};
	case "UO_FW_AI_RespawnModule": {
		private _allowedLinks = ["UO_FW_AI_ZoneModule","UO_FW_AI_ZoneModule_R"];
		for [{_j=0}, {(_j < count _synced)}, {_j = _j + 1}] do {
			private _syncItem = _synced select _j;
			private _check = typeof _syncItem;
			private _allowed = _check in _allowedLinks;
			if (!_allowed) then {
				if (_logic != _syncItem) then {(format["%2 a %3 is incorrectly linked to %1 a %4.",_logic,_syncItem,_check,_type]) call UO_FW_fnc_DebugMessage;};
			};
		};
	};
	default { hint format["Invalid Logic Type - %1", _type];};
};
true