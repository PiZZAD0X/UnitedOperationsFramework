#define COMPONENT Gear
#include "\x\UO_FW\addons\Main\script_macros.hpp"
UO_FW_EXEC_CHECK(ALL);
UO_FW_3DEN_CHECK;

{
    _x call UO_FW_fnc_GearHandleEH;
} foreach (all3DENEntities select 0);