#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params [
    ["_pos",[0,0,0],[[]],[3]],
    ["_radius",5,[0]],
    ["_side",[west],[[]]],
    ["_Types",["CAManBase","LandVehicle","Ship","Helicopter","Plane"],[[]]],
    ["_allCheck",false,[false]]
];

if !(_side isEqualType []) then { _side = [_side] };
if !(_Types isEqualType []) then { _Types = [_Types] };
private _EnabledEntities = [];
private _nearEntities = _pos nearEntities [_Types,_radius];
{
    if (((isPlayer _x) || _allCheck) && {(side _x) in _side} && {(alive _x)} ) then {
        _EnabledEntities set [count _EnabledEntities, _x]
    };
} forEach _nearEntities;
_EnabledEntities
