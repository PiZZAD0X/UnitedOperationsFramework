#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

if !(GETMVAR(Debug,false)) exitwith {};

params ["_grp",["_pos",[0,0,0],[[]]],["_text","",[""]],["_markerColor","ColorBLUFOR",[""]],["_markerShape","ICON",[""]],["_markerAlpha",1,[0]],["_markerType","b_unknown",[""]]];
private _count = (leader _grp) getvariable["debugMarker",0];
private _markerName = format["%1_%2_%3",_grp,_text,_count + 1];
private _markerText = format["%1_%2",_grp,_text];
private _marker = createMarker [_markerName,_pos];
_marker setMarkerShape _markerShape;
_marker setMarkerText _markerText;
_marker setMarkerColor _markerColor;
_marker setMarkerAlpha _markerAlpha;
_marker setMarkerType _markerType;
(leader _grp) setvariable["debugMarker",(_count + 1)];
[{
    _this setMarkerAlpha (_markerAlpha * 0.5);
    [{
        deleteMarker _this;
    }, [_this], 60] call CBA_fnc_WaitAndExecute;
}, [_marker], 60] call CBA_fnc_WaitAndExecute;
true
