#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

private ["_Unit", "_index", "_NearestEnemy", "_unit","_MovedRecently","_MovedRecentlyCover","_ReturnVariable","_MovedRecentlyRETURN","_MovedRecentlyCoverRETURN","_InCoverRETURN"];
params ["_Unit","_GARRISONED","_MovedRecently","_MovedRecentlyCover","_VisuallyCanSee","_ActivelyClearing","_StartedInside"];

//systemchat format ["%1",((group _Unit) call FUNC(Waypointcheck))];
//if ((count ((group _Unit) call FUNC(Waypointcheck))) > 0) exitwith {};
if (GVAR(CurrentlyMoving) < GVAR(CurrentlyMovingLimit)) then {
    private _FiredRecently = _unit getVariable [QGVAR(FiredTime),diag_ticktime];

    //systemchat "EXECUTED COMBAT MOVEMENT!";
    //systemchat format ["%1",(diag_tickTime - _FiredRecently)];

    if (_MovedRecentlyCover || {(diag_tickTime - _FiredRecently) < 3} || {_VisuallyCanSee} || {_ActivelyClearing} || {_StartedInside} || {_GARRISONED} || {_MovedRecently}) exitWith {_ReturnVariable = [false,false,false];GVAR(CurrentlyMoving) = GVAR(CurrentlyMoving) - 1;_ReturnVariable};
    private _Squadlead = leader _Unit;

    if (_Squadlead distance _Unit > 60) then {
        //_Unit domove (getposATL _Squadlead);
            _Unit forcespeed -1;
    } else {
        private _Group = (group _Unit);
        //Pull the waypoint information
        _index = currentWaypoint _Group;

        private _WPPosition = getWPPos [_Group,_index];
        //systemchat format ["_WPPosition: %1",_WPPosition];
        if !(_WPPosition isEqualTo [0,0,0]) then {
            if (_Unit isEqualTo (leader _Unit)) then {
                private _GroupDudes = units (group _Unit);
                _NearestEnemy = _Unit call FUNC(ClosestEnemy);
                if (isNil "_NearestEnemy" || _NearestEnemy isEqualTo [0,0,0]) then {_NearestEnemy = _WPPosition;};
                //systemchat format ["_NearestEnemy: %1",_NearestEnemy];
                _MovedRecentlyRETURN = true;
                _MovedRecentlyCoverRETURN = true;
                _InCoverRETURN = true;
                _ReturnVariable = [_MovedRecentlyRETURN,_MovedRecentlyCoverRETURN,_InCoverRETURN];
                {
                    [_x,_WPPosition,_GARRISONED,_MovedRecentlyCover,_ActivelyClearing,_StartedInside,_NearestEnemy] spawn {
                        params ["_unit","_pos","_GARRISONED","_MovedRecentlyCover","_ActivelyClearing","_StartedInside","_NearestEnemy"];
                        if !((vehicle _Unit) isEqualTo _Unit) exitWith {};
                        waitUntil {GVAR(CurrentlyMoving) < GVAR(CurrentlyMovingLimit)};
                        GVAR(CurrentlyMoving) = GVAR(CurrentlyMoving) + 1;
                        sleep (random 10);


                        private _MoveToPos = [_Unit,_Pos,_NearestEnemy] call FUNC(FragmentMove);
                        //systemchat format ["_MoveToPos: %1",_MoveToPos];
                        if !((vehicle _Unit) isEqualTo _Unit) exitWith {
                            _Unit forceSpeed -1;
                            _Unit doMove _Pos;
                        };
                        private _CoverPos = [_Unit,_MoveToPos,_GARRISONED,_MovedRecentlyCover,_ActivelyClearing,_StartedInside,_NearestEnemy] call FUNC(FindCoverPos);
                        //systemchat format ["_CoverPos: %1",_CoverPos];

                        if !(isNil "_CoverPos") then {
                        if (GETMVAR(Debug,false)) then {
                            private _arrow = "Sign_Sphere200cm_F" createVehicle [0,0,0];
                            _arrow setpos _CoverPos;
                            _arrow spawn {
                                params ["_arrow"];
                                private _Counter = 0;
                                private _Position = getpos _arrow;
                                private _NewPos2 = _Position select 2;
                                while {_Counter < 60} do {
                                    _NewPos2 = _NewPos2 + 0.1;
                                    _arrow setpos [_Position select 0,_Position select 1,_NewPos2];
                                    _Counter = _Counter + 1;
                                    sleep 0.5;
                                };
                                deletevehicle _arrow;
                            };
                        };

                            _Unit doWatch ObjNull;
                            _Unit disableAI "TARGET";
                            _Unit disableAI "AUTOTARGET";
                            _Unit disableAI "SUPPRESSION";
                            _Unit disableAI "AUTOCOMBAT";
                            private _WaitTime = diag_ticktime + 35;
                            While {alive _Unit && diag_ticktime < _WaitTime && (_Unit distance _CoverPos) > 3} do {
                                        _Unit forcespeed -1;
                                        _Unit domove _CoverPos;
                                //    };
                                sleep 4;
                            };
                            //systemchat format ["MADE IT: %1",_Unit];
                            _Unit forcespeed 0;
                        } else {
                            _Unit forcespeed -1;
                            _Unit doMove _MoveToPos;
                        };
                        _Unit enableAI "AUTOTARGET";
                        _Unit enableAI "TARGET";
                        _Unit enableAI "SUPPRESSION";
                        _Unit enableAI "AUTOCOMBAT";
                        _Unit doWatch _NearestEnemy;
                    };
                } foreach _GroupDudes;
            };
            _MovedRecentlyRETURN = true;
            _MovedRecentlyCoverRETURN = true;
            _InCoverRETURN = true;
            _ReturnVariable = [_MovedRecentlyRETURN,_MovedRecentlyCoverRETURN,_InCoverRETURN];
            //_Unit setVariable [QGVAR(InCover),true,false];
        } else {
            _MovedRecentlyRETURN = false;
            _MovedRecentlyCoverRETURN = false;
            _InCoverRETURN = false;
            _ReturnVariable = [_MovedRecentlyRETURN,_MovedRecentlyCoverRETURN,_InCoverRETURN];

        };
        GVAR(CurrentlyMoving) = GVAR(CurrentlyMoving) - 1;
    };
};
if (isNil "_ReturnVariable") then {_ReturnVariable = [false,false,false];};
_ReturnVariable
