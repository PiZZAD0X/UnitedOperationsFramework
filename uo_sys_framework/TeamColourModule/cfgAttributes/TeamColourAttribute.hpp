class EGVAR(TeamColour,ColourAttribute): Combo {
    //save the lbData from the selected entry upon exit
    attributeSave = "\
        private _value = ((_this controlsGroupCtrl 100) lbData lbCurSel (_this controlsGroupCtrl 100));\
        private _unit = ((get3denselected 'object') select 0);\
        private _name = gettext (_config >> 'property');\
        _unit setvariable [_name,_value];\
        _value\
    ";
    //_this - config, _value - saved value
    attributeLoad="\
        private _control = (_this controlsGroupCtrl 100);\
        private _name = gettext (_config >> 'property');\
        private _teamcolourarray = [['None',[0, 0, 0, 0]],['White',[1, 1, 1, 1]],['Red',[1, 0, 0, 1]],['Green',[0, 1, 0, 1]],['Blue',[0, 0, 1, 1]],['Yellow',[1, 1, 0, 1]]];\
        {\
            _x params ['_name','_colour'];\
            private _index = _control lbadd _name;\
            _control lbsetdata [_index,_name];\
            _control lbsetValue [_index,_foreachIndex];\
            _control lbsetpicture [_index,'#(argb,8,8,3)color(1,1,1,1)'];\
            _control lbsetpicturecolor [_index,_colour];\
            _control lbsetpicturecolorselected [_index,_colour];\
            if (_value isEqualto (_control lbData _index)) then {\
                _control lbSetCurSel _index;\
            };\
        } foreach _teamcolourarray;\
        private ['_isUnitPlayable'];\
        private _unit = ((get3denselected 'object') select 0);\
        private _ctrlGroup = ctrlParentControlsGroup ctrlParentControlsGroup _control;\
        {\
            if (ctrlParentControlsGroup _x isEqualto _ctrlGroup) then {\
                if !(isNull player) then {\
                     _isUnitPlayable = ((_unit in playableUnits) || (_unit isEqualto player));\
                } else {\
                     _isUnitPlayable = (_unit in playableUnits);\
                };\
                _state = [false,true] select (_isUnitPlayable);\
                _fade = [0.75,0] select _state;\
                _x ctrlenable _state;\
                _x ctrlsetfade _fade;\
                _x ctrlshow _state;\
                _x ctrlcommit 0;\
                ctrlsetfocus _x;\
                ctrlsetfocus _control;\
            };\
        } foreach (allcontrols (ctrlparent _control));\
    ";
    class Controls: Controls {
        class Title: Title {};
        class Value: Value {};
    };
};
