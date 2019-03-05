#define COMPONENT Gear
#include "\x\UO_FW\addons\Main\script_macros.hpp"
UO_FW_EXEC_CHECK(ALL);
UO_FW_3DEN_CHECK;

if (!(EGETMVALUE(Gear,ACEAR_System_Enabled,false)) && {!(EGETMVALUE(Gear,Olsen_Enabled,false))}) exitwith {
    ESETPLPVAR(Gear,GearReady,true);
};

params ["_object"];
LOG_1("_object: %1",_object);
LOG_1("_object UnitSystemType: %1",GETVAR(_object,UnitSystemType,"NONE"));
LOG_1("_object UnitGearType: %1",GETVAR(_object,UnitGearType,"NONE"));

if (GETVAR(_object,UnitSystemType,"NONE") isEqualto "NONE") exitwith {};
if (GETVAR(_object,UnitGearType,"NONE") isEqualto "NONE") exitwith {};

[_object] call FUNC(GearTypeLoad3DEN);
