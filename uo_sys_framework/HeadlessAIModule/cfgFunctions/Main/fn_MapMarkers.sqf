//Prints and updates markers for all in GVAR(TrackedUnits) array

#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

GVAR(MARKERARRAY) = [];
GVAR(TrackedUnits) = [];

if !(GETMVAR(Markers_enabled,false)) exitWith {};
GVAR(MapMarkersPFH) = [{
    {
        _x params ["_side","_group","_leader","_groupcount","_behaviourtasking","_behaviour","_target","_position","_hasRadio"];
        if (!(alive _leader) || !(local _leader)) exitwith {
            private _lastname = name _leader;
            private _trackername = format["trk_%1_%2",_lastname,_leader];
            if (_trackername in GVAR(MARKERARRAY)) then {
                deletemarker _trackername;
                GVAR(MARKERARRAY) = GVAR(MARKERARRAY) - [_trackername];
            };
            private _destname = format["dest_%1_%2",_lastname,_leader];
            if (_destname in GVAR(MARKERARRAY)) then {
                deletemarker _destname;
                GVAR(MARKERARRAY) = GVAR(MARKERARRAY) - [_destname];
            };
            private _targetname = format["target_%1_%2",_lastname,_leader];
            if (_targetname in GVAR(MARKERARRAY)) then {
                deletemarker _targetname;
                GVAR(MARKERARRAY) = GVAR(MARKERARRAY) - [_targetname];
            };
        };
        private _rankshort = [rank _leader,"displayNameShort"] call BIS_fnc_rankparams;
        private _lastname = name _leader;
        private _trackername = format["trk_%1_%2",_lastname,_leader];
        private _markercolour = (switch (_side) do {
            case west: {"ColorBlue"};
            case east: {"ColorRed"};
            case independent: {"ColorGreen"};
            case civilian: {"ColorYellow"};
            default {"ColorBlack"};
        });
        if (!(_trackername in GVAR(MARKERARRAY))) then {
            private _markerlead = createMarker [_trackername,[0,0]];
            GVAR(MARKERARRAY) pushback _trackername;
            private _drawicon = switch (true) do {
                case (_leader isKindOf "Man"): {"b_inf"};
                case (_leader isKindOf "LandVehicle"): {"b_motor_inf"};
                default {"b_inf"};
            };
            _trackername setMarkerShape "ICON";
            _trackername setMarkerType _drawicon;
            _trackername setmarkercolor _markercolour;
        };
        _trackername setmarkerpos [getpos _leader select 0, getpos _leader select 1];
        private _usedest = switch (_behaviourtasking) do {
            case "GARRISON": {false;};
            case "PATROLLING": {true;};
            case "PATROLLING PERIMETER": {true;};
            case "SENTRY": {true;};
            case "ATTACK": {true;};
            case "ASSAULT": {true;};
            case "FLANK": {true;};
            case "MOVE": {true;};
            case "DEFEND": {false;};
            case "BUNKER": {false;};
            case "LOITERING": {false;};
            case "STATIONARY": {false;};
            case "HOLD": {false;};
            case "FORCE HOLD": {false;};
            case "NONE": {false;};
            case "BLD MOVE": {true;};
            case "BLD DEFEND": {false;};
            case "BLD SEARCH": {true;};
            default {false};
        };
        private _usetarget = false;
        if (_target isEqualto objnull) then {
            _target = "No Target";
        } else {
            _usetarget = true;
        };
        private _text = format ["%1. %2 - Grpcount: %3 - Mission: %4 - CombatMode: %5 - Target: %6",_rankshort, _lastname,_groupcount,_behaviourtasking,_behaviour,_target];
        _trackername setMarkerText _text;
        if (_usedest) then {
            private _destname = format["dest_%1_%2",_lastname,_leader];
            if (!(_destname in GVAR(MARKERARRAY))) then {
                private _markerobj = createMarker[_destname,[0,0]];
                GVAR(MARKERARRAY) pushback _destname;
                private _wptext = format ["%1. %2",_rankshort, _lastname];
                _destname setMarkerShape "ICON";
                _destname setMarkerType "mil_marker";
                _destname setMarkerSize [0.5,0.5];
                _destname setmarkercolor _markercolour;
                _destname setMarkerText _wptext;
            };
            private _wpArray = waypoints _group;
            if (count _wpArray > 0) then {
                private _wpindex = currentWaypoint _group;
                private _wppos = waypointPosition [_group,_wpindex];
                _destname setmarkerpos _wppos;
            } else {
                _destname setmarkerpos [0,0];
            };
        } else {
            private _destname = format["dest_%1_%2",_lastname,_leader];
            if (_destname in GVAR(MARKERARRAY)) then {
                deletemarker _destname;
                GVAR(MARKERARRAY) = GVAR(MARKERARRAY) - [_destname];
            };
        };
        if (_usetarget) then {
            private _targetname = format["target_%1_%2",_lastname,_leader];
            if (!(_targetname in GVAR(MARKERARRAY))) then {
                private _markertarget = createMarker[_targetname,[0,0]];
                GVAR(MARKERARRAY) pushback _targetname;
                private _targettext = format ["%1. %2",_rankshort, _lastname];
                _targetname setMarkerShape "ICON";
                _targetname setMarkerType "mil_objective";
                _targetname setMarkerSize [0.5,0.5];
                _targetname setmarkercolor _markercolour;
                _targetname setMarkerText _targettext;
            };
            _targetname setMarkerPos [(getpos _target select 0),(getpos _target select 1)];
        } else {
            private _targetname = format["target_%1_%2",_lastname,_leader];
            if (_targetname in GVAR(MARKERARRAY)) then {
                deletemarker _targetname;
                GVAR(MARKERARRAY) = GVAR(MARKERARRAY) - [_targetname];
            };
        };
    } foreach GVAR(GroupArray);
}, 120] call CBA_fnc_addPerFrameHandler;
