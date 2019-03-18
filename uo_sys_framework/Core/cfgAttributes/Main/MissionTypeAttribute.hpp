class EGVAR(Core,MissionTypeAttribute): Toolbox {
    attributeLoad= QUOTE(\
        missionNamespace setVariable [QN(EGVAR(Core,MissionType)),_value];\
        (_this controlsGroupCtrl 100) lbsetcursel _value;\
    );
    attributeSave= QUOTE(\
        private _value = missionNamespace getVariable [QN(EGVAR(Core,MissionType)),0];\
        _value\
    );
    h="8 * (pixelH * pixelGrid * 0.50)";
    class Controls: Controls {
        class Title: Title {};
        class Value: ctrlToolbox {
            idc=100;
            h="8 * (pixelH * pixelGrid * 0.50)";
            x="48 * (pixelW * pixelGrid * 0.50)";
            w="82 * (pixelW * pixelGrid * 0.50)";
            rows=1;
            columns=5;
            strings[]= {
                "CO",
                "TVT",
                "COTVT",
                "LOL",
                "UOTC"
            };
            tooltips[]= {
                "CO is defined as a mission where players are against AI",
                "TVT is defined as a mission where players are against players",
                "COTVT is defined as a mission where players are against AI that are assisted by players",
                "LOL is defined as any mission that does not fit within the other categories",
                "UOTC is defined as any mission built for the United Operations Training Center"
            };
            values[]={0,1,2,3,4};
            onToolboxSelChanged = QUOTE(\
                missionNamespace setVariable [QN(EGVAR(Core,MissionType)),(_this select 1)];\
            );
        };
    };
};
