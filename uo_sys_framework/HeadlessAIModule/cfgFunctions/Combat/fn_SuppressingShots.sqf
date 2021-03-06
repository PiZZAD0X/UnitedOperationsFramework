//An extra layer of suppression that will hopefully make AI go for cover better...
//If framerate is below 20 - exit this script.

#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

private ["_unit", "_bullet", "_TimeShot","_FrameRateCheck", "_Unit", "_Array2", "_Point", "_ArrayCheck", "_UnitGroup", "_CheckVariable1", "_CheckDistance"];

private _FrameRateCheck = diag_fps;
if (_FrameRateCheck <= GVAR(FPSFreeze)) exitWith {};

_unit = (_this select 0) select 0;

if (GVAR(CurrentlySuppressing) < GVAR(CurrentlySuppressingLimit)) then {
    GVAR(CurrentlySuppressing) = GVAR(CurrentlySuppressing) + 1;
    _TimeShot = _unit getVariable QGVAR(FiredTime);
    if ((diag_tickTime - _TimeShot) > 25) then {
        _unit setVariable [QGVAR(FiredTime),diag_tickTime,true];
        private _pos = cursorTarget;
        if (isNull _pos) then {
            if (isPlayer _Unit) then {
                //Remember, screenToWorld is using UI coordinates!
                _pos = screenToWorld [0.5,0.5];
            } else {
                _pos = assignedTarget _Unit;
                if (isNull _pos) then {
                    _pos = getPosATL _Unit
                };
            };
        } else {
            _pos = getPosATL _pos;
        };

        _Point = _Unit call FUNC(ClosestEnemy);
        if (_Point isEqualTo [] || {isNil "_Point"}) exitWith {};
        _ArrayCheck = typeName _Point;
        if (_ArrayCheck isEqualTo "ARRAY") exitWith {};
        _UnitGroup = group _Point;

        {
                _CheckDistance = (_pos distance _x);
                private _Kn = _unit knowsAbout _x;
                if (_CheckDistance < 4 && (_Kn > 3.5)) then {
                    if (GVAR(Suppression)) then {
                        if !(isPlayer _x) then {
                            _x setCustomAimCoef GVAR(SuppressionVar);
                            _x spawn {
                                params ["_thisunit"];
                                sleep 8;
                                _thisunit setCustomAimCoef 1;
                            };
                        };
                    };
                    if (GVAR(Adrenaline)) then {
                        if !(isPlayer _x) then {
                            _x setAnimSpeedCoef GVAR(AdrenalineVar);
                            _x spawn {
                                params ["_thisunit"];
                                sleep 8;
                                _thisunit setAnimSpeedCoef 1;
                            };
                        };
                    };
                    if (GETMVAR(Debug,false)) then {
                        LOG_1("%1 is suppressed!",_x);
                    };

                };
        } forEach units _UnitGroup;
    };
    GVAR(CurrentlySuppressing) = GVAR(CurrentlySuppressing) - 1;
};
