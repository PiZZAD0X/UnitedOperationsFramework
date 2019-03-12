class EGVAR(EndConditions,ExtractTeam): Toolbox {
    attributeLoad = "\
        private _name = gettext (_config >> 'property');\
        missionNamespace setvariable [_name,_value];\
        private _control = (_this controlsGroupCtrl 100);\
        _control setvariable ['UO_FW_ParentCfg',_config];\
        _control lbsetcursel _value;\
    ";
    attributeSave = "\
        private _name = gettext (_config >> 'property');\
        private _value = missionNamespace getvariable [_name,''];\
        _value\
    ";
    h = "8 * (pixelH * pixelGrid * 0.50)";
    class Controls: Controls {
        class Title: Title {};
        class Value: ctrlToolbox {
            idc = 100;
            style = "0x02";
            x = "48 * (pixelW * pixelGrid * 0.50)";
            w = "82 * (pixelW * pixelGrid * 0.50)";
            h = "8 * (pixelH * pixelGrid * 0.50)";
            rows = 1;
            columns = 4;
            strings[] = {"BLUFOR","OPFOR","Indfor","CIVILIAN"};
            values[] = {0,1,2,3};
            onToolboxSelChanged = "\
                params ['_control','_value'];\
                private _config = _control getvariable ['UO_FW_ParentCfg',''];\
                private _name = gettext (_config >> 'property');\
                missionNamespace setvariable [_name,_value];\
            ";
        };
    };
};
