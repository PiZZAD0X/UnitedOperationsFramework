#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params [
    ["_unit",objNull,[objNull]],
    ["_allowed",[],[[]]],
    ["_return",false,[false]]
];
if !(_allowed isEqualto []) then {
    if ((stance _unit) in _allowed) then {
        _return = false;
    } else {
        _return = true;
    };
};
_return
