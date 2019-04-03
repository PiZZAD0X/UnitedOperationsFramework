/*    Description: Respawn Module moves the respawn point when linked zone is active.
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

params [["_mode","",[""]],["_input",[],[[]]]];
    if (isNil QGVAR(initialised)) then {call FUNC(initMain);};
    switch _mode do {
        case "init": {
            AI_EXEC_CHECK(SERVERHC);
            _input params ["_logic",["_isActivated",true,[true]]];
            if !(_isActivated) exitWith {};
            [_logic] spawn FUNC(debugSyncedModules);
        };
        case "attributesChanged3DEN": {};
        case "registeredToWorld3DEN": {};
        case "unregisteredFromWorld3DEN": {};
        case "connectionChanged3DEN": {};
        default {};
    };
    true
