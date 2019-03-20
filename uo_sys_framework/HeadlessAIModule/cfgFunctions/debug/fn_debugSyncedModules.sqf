#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params ["_logic"];
private _Type = typeof _logic;
private _synced = synchronizedObjects _logic;
switch (_Type) do {
    case QGVAR(ZoneModule_R);
    case QGVAR(ZoneModule): {
        private _AllowedLinks = [QGVAR(ControlModule),QGVAR(ControlModule_R),QGVAR(TaskModule),QGVAR(PositionModule),QGVAR(PositionModule_R),QGVAR(RespawnModule),"Group","Object","Vehicle"];
        {
            private _syncItem = _x;
            private _check = "";
            if (_syncItem isKindOf "Man") then {
                _check = "Group";
            } else {
                if (_syncItem isKindOf "Thing") then {
                    _check = "Object";
                } else {
                    if (_syncItem isKindOf "StaticWeapon"
                        || _syncItem isKindOf "Static"
                        || _syncItem isKindOf "Air"
                        || _syncItem isKindOf "Ship"
                        || _syncItem isKindOf "LandVehicle"
                    ) then {
                        _check = "Vehicle";
                    } else {
                        _check = typeof _syncItem;
                    };
                };
            };
            private _Allowed = _check in _AllowedLinks;
            if (!_Allowed) then {
                if (_logic != _syncItem) then {
                    LOG_4("%2 a %3 is incorrectly linked to %1 a %4.",_logic,_syncItem,_check,_Type);
                };
            };
        } foreach _synced;
    };
    case QGVAR(TaskModule): {
        private _AllowedLinks = [QGVAR(ZoneModule),QGVAR(ZoneModule_R),QGVAR(TaskModule),"Group"];
        {
            private _syncItem = _x;
            private _check = "";
            if (_syncItem isKindOf "Man"
                || _syncItem isKindOf "AllVehicles"
                || _syncItem isKindOf "StaticWeapon"
                || _syncItem isKindOf "Static"
                || _syncItem isKindOf "Air"
                || _syncItem isKindOf "Ship"
                || _syncItem isKindOf "LandVehicle"
            ) then {_check = "Group";} else {_check = typeof _syncItem;};
            private _Allowed = _check in _AllowedLinks;
            if (!_Allowed) then {
                if (_logic != _syncItem) then {
                    LOG_4("%2 a %3 is incorrectly linked to %1 a %4.",_logic,_syncItem,_check,_Type);
                };
            };
        } foreach _synced;
    };
    case QGVAR(ControlModule_R);
    case QGVAR(ControlModule): {
        private _AllowedLinks = [QGVAR(ZoneModule),QGVAR(ZoneModule_R),"Group","Object","Vehicle"];
        {
            private _syncItem = _x;
            private _check = "";
            if (_syncItem isKindOf "Man") then {
                _check = "Group";
            } else {
                if (_syncItem isKindOf "Thing") then {
                    _check = "Object";
                } else {
                    if (_syncItem isKindOf "StaticWeapon"
                        || _syncItem isKindOf "Static"
                        || _syncItem isKindOf "Air"
                        || _syncItem isKindOf "Ship"
                        || _syncItem isKindOf "LandVehicle"
                    ) then {
                        _check = "Vehicle";
                    } else {
                        _check = typeof _syncItem;
                    };
                };
            };
            private _Allowed = _check in _AllowedLinks;
            if (!_Allowed) then {
                if (_logic != _syncItem) then {
                    LOG_4("%2 a %3 is incorrectly linked to %1 a %4.",_logic,_syncItem,_check,_Type);
                };
            };
        } foreach _synced;
    };
    case QGVAR(PositionModule_R);
    case QGVAR(PositionModule): {
        private _AllowedLinks = [QGVAR(ZoneModule),QGVAR(ZoneModule_R),QGVAR(TemplateModule),"Group","Object","Vehicle"];
        {
            private _syncItem = _x;
            private _check = "";
            if (_syncItem isKindOf "Man") then {
                _check = "Group";
            } else {
                if (_syncItem isKindOf "Thing") then {
                    _check = "Object";
                } else {
                    if (_syncItem isKindOf "StaticWeapon"
                        || _syncItem isKindOf "Static"
                        || _syncItem isKindOf "Air"
                        || _syncItem isKindOf "Ship"
                        || _syncItem isKindOf "LandVehicle"
                    ) then {
                        _check = "Vehicle";
                    } else {
                        _check = typeof _syncItem;
                    };
                };
            };
            private _Allowed = _check in _AllowedLinks;
            if (!_Allowed) then {
                if (_logic != _syncItem) then {
                    LOG_4("%2 a %3 is incorrectly linked to %1 a %4.",_logic,_syncItem,_check,_Type);
                };
            };
        } foreach _synced;
    };
    case QGVAR(TemplateModule): {
        private _AllowedLinks = [QGVAR(PositionModule),QGVAR(PositionModule_R),"Group","Object","Vehicle"];
        {
            private _syncItem = _x;
            private _check = "";
            if (_syncItem isKindOf "Man") then {
                _check = "Group";
            } else {
                if (_syncItem isKindOf "Thing") then {
                    _check = "Object";
                } else {
                    if (_syncItem isKindOf "StaticWeapon"
                        || _syncItem isKindOf "Static"
                        || _syncItem isKindOf "Air"
                        || _syncItem isKindOf "Ship"
                        || _syncItem isKindOf "LandVehicle"
                    ) then {
                        _check = "Vehicle";
                    } else {
                        _check = typeof _syncItem;
                    };
                };
            };
            private _Allowed = _check in _AllowedLinks;
            if (!_Allowed) then {
                if (_logic != _syncItem) then {
                    LOG_4("%2 a %3 is incorrectly linked to %1 a %4.",_logic,_syncItem,_check,_Type);
                };
            };
        } foreach _synced;
    };
    case QGVAR(RespawnModule): {
        private _AllowedLinks = [QGVAR(ZoneModule),QGVAR(ZoneModule_R)];
        {
            private _syncItem = _x;
            private _check = typeof _syncItem;
            private _Allowed = _check in _AllowedLinks;
            if (!_Allowed) then {
                if (_logic != _syncItem) then {
                    LOG_4("%2 a %3 is incorrectly linked to %1 a %4.",_logic,_syncItem,_check,_Type);
                };
            };
        } foreach _synced;
    };
    default {
        LOG_1("Invalid Logic Type - %1", _Type)
    };
};
true
