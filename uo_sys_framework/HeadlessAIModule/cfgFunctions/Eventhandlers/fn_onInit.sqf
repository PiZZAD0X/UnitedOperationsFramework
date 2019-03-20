#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(HC);

if !(local _this) exitwith {};
if (isNil QGVAR(ActiveList)) then {
    GVAR(ActiveList) = [_this];
} else {
    GVAR(ActiveList) append _this;
};
