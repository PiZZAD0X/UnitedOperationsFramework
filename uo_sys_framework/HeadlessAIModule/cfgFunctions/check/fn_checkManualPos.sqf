#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params [["_pos",[],[[]]],["_return",false,[false]]];
if ((_pos isEqualType "ARRAY") && {(count _pos) == 3} && {(_pos select 0) isEqualType "SCALAR"} && {(_pos select 1) isEqualType "SCALAR"} && {(_pos select 2) isEqualType "SCALAR"}) then {
    _return = true;
};
_return
