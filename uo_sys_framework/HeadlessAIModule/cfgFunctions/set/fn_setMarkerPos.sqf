#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params["_marker","_obj"];
private _pos = getposATL _obj;
_marker setMarkerPos _pos;
true
