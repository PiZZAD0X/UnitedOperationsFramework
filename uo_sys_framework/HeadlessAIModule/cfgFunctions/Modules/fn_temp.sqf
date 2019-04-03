/*    Description: Template Module saves linked entities for reuse by Position Modules.
 *    Arguments:
 *         OBJECT    - Module (name, _logic)
 *        ARRAY    - Units (synced to module)
 *        BOOL    - Module Activated
 *     Return Value:
 *         BOOL    - True
 *    Author
 *        suits & PiZZADOX
 */
#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);


params [["_mode","",[""]],["_input",[],[[]]]];
switch _mode do {
    case "init": {
        AI_EXEC_CHECK(SERVERHC);
        _input params ["_logic",["_isActivated",true,[true]]];
        if !(_isActivated) exitWith {};
        if (GETMVAR(Debug,false)) then {
            [_logic] spawn FUNC(debugSyncedModules);
        };
    };
    case "attributesChanged3DEN": {};
    case "registeredToWorld3DEN": {};
    case "unregisteredFromWorld3DEN": {};
    case "connectionChanged3DEN": {};
    default {};
};
true
