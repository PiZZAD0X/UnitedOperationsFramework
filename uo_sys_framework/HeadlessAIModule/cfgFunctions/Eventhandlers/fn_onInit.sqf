#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(HC);

if !(local _this) exitwith {};
if (isNil QGVAR(UnitQueue)) then {
    GVAR(UnitQueue) = [_this];
} else {
    GVAR(UnitQueue) append [_this];
};
