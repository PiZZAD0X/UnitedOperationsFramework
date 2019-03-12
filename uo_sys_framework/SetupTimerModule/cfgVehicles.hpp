class EGVAR(SetupTimer,SetupTimerModule): EGVAR(Core,BaseModule) {
    displayName = "Setup Timer Module"; // Name displayed in the menu
    scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
    // Name of function triggered once conditions are met
    function = QEFUNC(SetupTimer,moduleSetupTimer);
    // Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
    isGlobal = 1;
    isTriggerActivated = 0;
    isDisposable = 0;
    is3DEN = 1;
    canSetArea = 1;
    canSetAreaHeight = 0;
    canSetAreaShape = 0;
    icon = "\x\UO_FW\addons\Main\SetupTimerModule\resources\setuptimermodule_ca.paa";

    class AttributeValues {
    size2[] = {100,100};
        IsRectangle = 0;
    };

    // Categories collapsible in "Edit Attributes" window
    // Category class, can be anything
    class Attributes {
        class EGVAR(SetupTimer,SideSelect) {
            displayName = "Side";
            tooltip = "Side restricted to the setup area.";
            control = "Combo";
            typeName = "NUMBER";
            property = QEGVAR(SetupTimer,SideSelect);
            expression = MODULE_EXPRESSION;
            validate = "none";
            class values {
                class West {name = "West"; value = 0; default = 0;};
                class East {name = "East"; value = 1;};
                class Ind {name = "Independent"; value = 2;};
                class Civ {name = "Civilian"; value = 3;};
            };
            defaultValue = "0";
        };
        class EGVAR(SetupTimer,RadiusX) {
            displayName = "Radius X";
            tooltip = "The size of the X value of the setup zone. Default: 100";
            property = QEGVAR(SetupTimer,RadiusX);
            control = QMGVAR(RadiusAttribute);
            expression = MODULE_EXPRESSION;
            defaultValue = "100";
            typeName = "NUMBER";
            validate = "number";
        };
        class EGVAR(SetupTimer,RadiusY) {
            displayName = "Radius Y";
            tooltip = "The size of the Y value of the setup zone. Default: 100";
            property = QEGVAR(SetupTimer,RadiusY);
            control = QMGVAR(RadiusAttribute);
            expression = MODULE_EXPRESSION;
            defaultValue = "100";
            typeName = "NUMBER";
            validate = "number";
        };
        class EGVAR(SetupTimer,Time) {
            // Unique property, use "<moduleClass>_<attributeClass>" format to make sure the name is unique in the world
            displayName = "Time"; // Attribute label
            tooltip = "Time in seconds";
            control = QMGVAR(30To900Step1_Slider);
            property = QEGVAR(SetupTimer,Time);
            defaultValue = "30"; // Default attribute value. WARNING: This is an expression, and its returned value will be used (50 in this case)
            typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
            expression = MODULE_EXPRESSION;
            validate = "number";
        };
    };
};

class EGVAR(SetupTimer,SetupTimerModule_R): EGVAR(SetupTimer,SetupTimerModule) {
    displayName = "Setup Timer Module (Rectangle)"; // Name displayed in the menu
    class AttributeValues {
        size2[] = {100,100};
        IsRectangle = 1;
    };
};
