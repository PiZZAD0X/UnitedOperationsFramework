/*    Description: Task Module initialisation creates the zone.
 *    Arguments:
 *         OBJECT    - Module (name, _logic)
 *        ARRAY    - Units (synced to module)
 *        BOOL    - Module Activated
 *     Return Value:
 *         BOOL    - True
 *    Author
 *        suits & PiZZADOX & Lecks
 */
#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"

params [["_mode","",[""]],["_input",[],[[]]]];
    if (isNil QGVAR(initialised)) then {call FUNC(initMain);};
    switch _mode do {
        case "init": {
            AI_EXEC_CHECK(SERVERHC);
            _input params ["_logic",["_isActivated",true,[true]]];
            if !(_isActivated) exitWith {};
            if (count ([_logic ,[QGVAR(ZoneModule),QGVAR(ZoneModule_R)]] call FUNC(getSyncedModules)) > 0 ) then {
                _logic setVariable[QGVAR(taskZoneActivated),true];
            };
            [_logic] spawn FUNC(debugSyncedModules);
        };
        case "attributesChanged3DEN": {
            private _logic = _input param [0,objNull,[objNull]];
            private _radius = (GETVAR(_logic,taskRadius,100));
            set3DENAttributes [[[_logic],"size2",[_radius,_radius]]];
        };
    };
    true
