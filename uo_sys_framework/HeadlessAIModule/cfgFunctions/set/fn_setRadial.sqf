#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params["_value"];
private _leader = leader ((get3DENSelected 'Group') select 0);
set3DENAttributes [[[_leader],'size2',[_value,_value]]];
true
