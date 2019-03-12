#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
UO_FW_AI_EXEC_CHECK(SERVERHC);

private ["_Counter","_NearestUnit","_Nearobjects","_StanceCompare"];

_Counter = 6;
while {_Counter > 0} do {
    private _BehindUnit = _this modelToWorld [0,-1,0.5];
    _Nearobjects = _BehindUnit nearObjects ["Man",2];
    if (_this in _Nearobjects) then {_Nearobjects = _Nearobjects - [_this]};
    _NearestUnit = [_Nearobjects,_BehindUnit] call EFUNC(AI,ClosestObject);
    if (isNil "_NearestUnit" || {typeName _NearestUnit isEqualTo "ARRAY"}) then {_this setUnitPos "UP";_NearestUnit = _this;};
    if (_NearestUnit isEqualTo _this) then {_this setUnitPos "UP";};
    _StanceCompare = stance _NearestUnit;
    if (_StanceCompare isEqualTo "STAND") then {_this setUnitPos "MIDDLE";};
    if (_StanceCompare isEqualTo "CROUCH") then {_this setUnitPos "DOWN";};
    if (_StanceCompare isEqualTo "PRONE") then {_this setUnitPos "UP";};
    if (_StanceCompare isEqualTo "UNDEFINED") then {_this setUnitPos "UP";};
    if (_StanceCompare isEqualTo "") then {_this setUnitPos "UP";};
    _Counter = _Counter - 1;
    sleep 10;
};

_this setUnitPos "AUTO";
