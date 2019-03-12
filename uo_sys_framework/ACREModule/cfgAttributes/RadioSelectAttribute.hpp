class EGVAR(Acre,SR_SELECT): Toolbox {
    attributeLoad ="\
        private _name = gettext (_config >> 'property');\
        missionNamespace setvariable [_name,_value];\
        private _control = (_this controlsGroupCtrl 100);\
        _control setvariable ['UO_FW_ParentCfg',_config];\
        _control lbsetcursel _value\
    ";
    attributeSave = "\
        private _name = gettext (_config >> 'property');\
        private _value = missionNamespace getvariable [_name,''];\
        _value\
    ";
    h = "7 * (pixelH * pixelGrid * 0.50)";
    class Controls: Controls {
        class Title: Title {};
        class Value: ctrlToolbox {
            idc = 100;
            style = "0x02";
            x = "48 * (pixelW * pixelGrid * 0.50)";
            w = "82 * (pixelW * pixelGrid * 0.50)";
            h = "6 * (pixelH * pixelGrid * 0.50)";
            rows = 1;
            columns = 3;
            strings[] = {"NONE","PRC-343","SEM-52SL"};
            values[] = {0,1,2};
            onToolboxSelChanged ="\
                params ['_control','_value'];\
                private _config = _control getvariable ['UO_FW_ParentCfg',''];\
                private _name = gettext (_config >> 'property');\
                missionNamespace setvariable [_name,_value];\
            ";
        };
    };
};

class EGVAR(Acre,LR_SELECT): Toolbox {
    attributeLoad ="\
        private _name = gettext (_config >> 'property');\
        missionNamespace setvariable [_name,_value];\
        private _control = (_this controlsGroupCtrl 100);\
        _control setvariable ['UO_FW_ParentCfg',_config];\
        _control lbsetcursel _value\
    ";
    attributeSave = "\
        private _name = gettext (_config >> 'property');\
        private _value = missionNamespace getvariable [_name,''];\
        _value\
    ";
    h = "7 * (pixelH * pixelGrid * 0.50)";
    class Controls: Controls {
        class Title: Title {};
        class Value: ctrlToolbox {
            idc = 100;
            style = "0x02";
            x = "48 * (pixelW * pixelGrid * 0.50)";
            w = "82 * (pixelW * pixelGrid * 0.50)";
            h = "6 * (pixelH * pixelGrid * 0.50)";
            rows = 1;
            columns = 4;
            strings[] = {"NONE","PRC-343","PRC-148","PRC-152"};
            values[] = {0,1,2,3};
            onToolboxSelChanged ="\
                params ['_control','_value'];\
                private _config = _control getvariable ['UO_FW_ParentCfg',''];\
                private _name = gettext (_config >> 'property');\
                missionNamespace setvariable [_name,_value];\
            ";
        };
    };
};

class EGVAR(Acre,PK_SELECT): Toolbox {
    attributeLoad ="\
        private _name = gettext (_config >> 'property');\
        missionNamespace setvariable [_name,_value];\
        private _control = (_this controlsGroupCtrl 100);\
        _control setvariable ['UO_FW_ParentCfg',_config];\
        _control lbsetcursel _value\
    ";
    attributeSave = "\
        private _name = gettext (_config >> 'property');\
        private _value = missionNamespace getvariable [_name,0];\
        _value\
    ";
    h = "7 * (pixelH * pixelGrid * 0.50)";
    class Controls: Controls {
        class Title: Title {};
        class Value: ctrlToolbox {
            idc = 100;
            style = "0x02";
            x = "48 * (pixelW * pixelGrid * 0.50)";
            w = "82 * (pixelW * pixelGrid * 0.50)";
            h = "6 * (pixelH * pixelGrid * 0.50)";
            rows = 1;
            columns = 4;
            strings[] = {"NONE","PRC-117F","PRC-77","SEM-70"};
            values[] = {0,1,2,3};
            onToolboxSelChanged ="\
                params ['_control','_value'];\
                private _config = _control getvariable ['UO_FW_ParentCfg',''];\
                private _name = gettext (_config >> 'property');\
                missionNamespace setvariable [_name,_value];\
            ";
        };
    };
};
