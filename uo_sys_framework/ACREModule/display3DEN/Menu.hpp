class EGVAR(ACRE,Folder) {
    text = "Configure ACRE";
    items[] = {QEGVAR(Acre,Configure_Blufor),QEGVAR(Acre,Configure_Opfor),QEGVAR(Acre,Configure_Indfor),QEGVAR(Acre,Configure_Civ),QEGVAR(Acre,Configure_MainSettings)};
    //picture = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\talk_ca.paa";
    picture = "x\UO_FW\addons\Main\ACREModule\resources\RadioIcon_Radio.paa";
};

class EGVAR(Acre,Configure_Blufor) {
    text = "Configure Blufor ACRE";
    action = QUOTE(edit3DENMissionAttributes QN(EGVAR(Acre,Blufor)));
};

class EGVAR(Acre,Configure_Opfor) {
    text = "Configure Opfor ACRE";
    action = QUOTE(edit3DENMissionAttributes QN(EGVAR(Acre,Opfor)));
};

class EGVAR(Acre,Configure_Indfor) {
    text = "Configure Indfor ACRE";
    action = QUOTE(edit3DENMissionAttributes QN(EGVAR(Acre,Indfor)));
};

class EGVAR(ACRE,Configure_Civ) {
    text = "Configure Civilian ACRE";
    action = QUOTE(edit3DENMissionAttributes QN(EGVAR(Acre,Civilian)));
};

class EGVAR(ACRE,Configure_MainSettings) {
    text = "Configure ACRE Settings";
    action = QUOTE(edit3DENMissionAttributes QN(EGVAR(Acre,MainSettings)));
};
