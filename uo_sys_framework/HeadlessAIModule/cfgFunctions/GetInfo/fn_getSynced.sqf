#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params ["_logic"];
private _synced = synchronizedObjects _logic;
{
    private _obj = _x;
    if (_obj isKindOf "StaticWeapon"
        || _obj isKindOf "Static"
        || _obj isKindOf "Air"
        || _obj isKindOf "Ship"
        || _obj isKindOf "LandVehicle"
    ) then {
        _synced = _synced + (units _obj);
        _synced = _synced + (assignedCargo _obj);
    };
} foreach _synced;
_synced = _synced arrayIntersect _synced;
_synced
