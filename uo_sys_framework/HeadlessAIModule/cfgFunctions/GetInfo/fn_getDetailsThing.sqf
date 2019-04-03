#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params ["_obj",["_pos",[],[[]]]];
private _objectInit = (MGETVAR(_obj,AI_unitInit,""));
if (typename _objectInit isEqualTo "STRING") then {_objectInit = compile _objectInit;};
if (_pos isEqualTo []) then {_pos = (getposATL _obj)};
[typeOf _obj,
_pos,
vectorDir _obj,
vectorUp _obj,
damage _obj,
surfaceIsWater (getposATL _obj),
_obj getVariable [QGVAR(unitName),""],
_obj getVariable [QGVAR(unitPersistent),true],
_objectInit]
