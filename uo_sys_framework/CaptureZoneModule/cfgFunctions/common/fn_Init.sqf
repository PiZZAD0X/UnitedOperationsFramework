#define COMPONENT CaptureZone
#include "\x\UO_FW\addons\Main\script_macros.hpp"
EXEC_CHECK(SERVER);

//[_logic,_zoneName,_area,_repeatable,_capArray,_timeArray,_messagesArray,_colours,_hidden,_silent,_automessages,_ratioNeeded,_cond] passed array
//params ["","_zoneName","","","","","","","","","","",["_cond","true",[""]]];
private _cond = _this select 12;
private _logic = _this select 1;

[QEGVAR(Core,RegisterModuleEvent), ["Capture Zone", "Creates Capture Zone objectives for variable declares and end condition requirements", "Sacher and PiZZADOX"]] call CBA_fnc_globalEvent;

LOG_1("CaptureZone Loop called with this: %1",_this);
if (!(_this call FUNC(Validate))) exitWith {
    ERROR_1("CaptureZone %1 failed to Validate",_logic);
};

if (call (compile _cond)) exitwith {
    _this call FUNC(Loop);
};

[{call (_this select 1)}, {
    (_this select 0) call FUNC(Loop);
}, [_this, (compile _cond)]] call CBA_fnc_waitUntilAndExecute;
