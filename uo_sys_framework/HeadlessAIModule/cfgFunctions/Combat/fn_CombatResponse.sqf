#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params ["_Group",["_RadioEnemy",objnull],["_reinforcementcall",false]];
private ["_leader","_currentmission","_currenttarget","_enemydir","_enemydist"];

_leader = leader _group;
_currentmission = _group getVariable [QGVAR(Mission),"NONE"];
if (behaviour _leader isEqualto "SAFE") then {
    _group setbehaviour "AWARE";
};
_currenttarget = _group getVariable [QGVAR(CurrentTarget),objnull];
if (!(_RadioEnemy isEqualto objnull) && (_currenttarget isEqualto objnull)) then {
    _currenttarget = _RadioEnemy;
    _group setVariable [QGVAR(CurrentTarget),_RadioEnemy];
};
_enemydir = _leader getdir _currenttarget;
_enemydist = _leader distance _currenttarget;

switch (_currentmission) do {
    default {};
    case "GARRISON": {};
    case "STATIONARY": {};
    case "BUNKER": {};
    case "DEFAULT PATROLLING": {
            if (_enemydist < 150) then {
                if (((floor random 1) > 0) || _reinforcementcall) then {
                    [_Group,_currenttarget,_enemydir] call FUNC(CombatAttack);
                } else {
                    [_Group,_currenttarget,_enemydir] call FUNC(CombatDefend);
                };
            } else {
                if (((floor random 1) > 0) || _reinforcementcall) then {
                    [_Group,_currenttarget,_enemydir] call FUNC(CombatMoveTo);
                } else {
                    [_Group,_currenttarget,_enemydir] call FUNC(CombatDefend);
                };
            };
        };
    case "PATROLLING": {
            if (_enemydist < 150) then {
                if (((floor random 1) > 0) || _reinforcementcall) then {
                    [_Group,_currenttarget,_enemydir] call FUNC(CombatAttack);
                } else {
                    [_Group,_currenttarget,_enemydir] call FUNC(CombatDefend);
                };
            } else {
                if (((floor random 1) > 0) || _reinforcementcall) then {
                    [_Group,_currenttarget,_enemydir] call FUNC(CombatMoveTo);
                } else {
                    [_Group,_currenttarget,_enemydir] call FUNC(CombatDefend);
                };
            };
        };
    case "LOITERING": {
            _group setSpeedMode "FULL";
            {_x setUnitPos "AUTO";} foreach (units _group);
            if (((floor random 1) > 0)|| _reinforcementcall) then {
                [_Group,_currenttarget,_enemydir] call FUNC(CombatAttack);
            } else {
                [_Group,_currenttarget,_enemydir] call FUNC(CombatDefend);
            };
        }; //regroups unit via a different function
    case "IDLE": {
            if (_enemydist < 150) then {
                if (((floor random 1) > 0) || _reinforcementcall) then {
                    [_Group,_currenttarget,_enemydir] call FUNC(CombatAttack);
                } else {
                    [_Group,_currenttarget,_enemydir] call FUNC(CombatDefend);
                };
            } else {
                if (((floor random 1) > 0)|| _reinforcementcall) then {
                    [_Group,_currenttarget,_enemydir] call FUNC(CombatMoveTo);
                } else {
                    [_Group,_currenttarget,_enemydir] call FUNC(CombatDefend);
                };
            };
        };
    case "NONE": {
            if (_enemydist < 150) then {
                if (((floor random 1) > 0)|| _reinforcementcall) then {
                    [_Group,_currenttarget,_enemydir] call FUNC(CombatAttack);
                } else {
                    [_Group,_currenttarget,_enemydir] call FUNC(CombatDefend);
                };
            } else {
                if (((floor random 1) > 0)|| _reinforcementcall) then {
                    [_Group,_currenttarget,_enemydir] call FUNC(CombatMoveTo);
                } else {
                    [_Group,_currenttarget,_enemydir] call FUNC(CombatDefend);
                };
            };
        };
};
