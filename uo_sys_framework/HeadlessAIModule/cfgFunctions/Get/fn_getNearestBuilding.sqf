#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params ["_pos",["_radius",500,[0]]];
private ["_nbld"];
private _blds = [_pos,_radius] call FUNC(getBuildings);
if (_blds isEqualTo []) then {
    _blds = [_pos,(_radius + 500)] call FUNC(getBuildings);
    if !(_blds isEqualTo []) then {
        _nbld = _blds select 0;
    };
} else {
    _nbld = _blds select 0;
};
_nbld
