#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

//Currently not being used
{
        [_x,false,false,false,false] spawn FUNC(MoveToCover);
} foreach (units (group _this));
