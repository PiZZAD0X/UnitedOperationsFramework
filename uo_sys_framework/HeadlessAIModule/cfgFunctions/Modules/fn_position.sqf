/*    Description: Position Module used to pass positions to other modules and functions.
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
    if (isNil QGVAR(initialised)) then {call FUNC(init);};
    switch _mode do {
        case "init": {
            if !is3DEN then {
                AI_EXEC_CHECK(SERVERHC);
                _input params ["_logic",["_isActivated",true,[true]]];
                if !(_isActivated) exitWith {};
                sleep 0.25;
                [_logic] spawn FUNC(debugSyncedModules);
            };
        };
        case "attributesChanged3DEN": {
            private _logic = _input param [0,objNull,[objNull]];
            private _radiusX = GETVAR(_logic,positionRadiusX,0);
            private _radiusY = GETVAR(_logic,positionRadiusY,0);
            set3DENAttributes [[[_logic],"size2",[_radiusX,_radiusY]]];
        };
        case "registeredToWorld3DEN": {};
        case "unregisteredFromWorld3DEN": {};
        case "connectionChanged3DEN": {};
        default {};
    };
    true
