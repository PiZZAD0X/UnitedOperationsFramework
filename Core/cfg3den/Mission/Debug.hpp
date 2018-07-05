class Debug
{
    displayName = "Debug Settings";
    collapsed = 1;
    class Attributes
    {
        class UO_FW_Debug_Enabled
        {
            property = "UO_FW_Debug_Enabled";
            displayName = "Debug Enabled";
            tooltip = "Toggle debug mode.";
            control = "Checkbox";
            expression="missionNamespace setVariable ['%s', _value]; %s = _value;";
            defaultValue = "false";
        };
		class UO_FW_Debug_Detailed_Enabled
        {
            property = "UO_FW_Debug_Detailed_Enabled";
            displayName = "Detailed Debug Enabled";
            tooltip = "Toggle detailed debug mode.";
            control = "Checkbox";
            expression="missionNamespace setVariable ['%s', _value]; %s = _value;";
            defaultValue = "false";
        };
		class UO_FW_ConditionSleep
        {
            property = "UO_FW_ConditionSleep";
            displayName = "End Condition Sleep";
            tooltip = "Time between end condition checks. Low values can cause server lag!";
			control = "EditShort";
            expression="missionNamespace setVariable ['%s', _value]; %s = _value;";
			validate = "number";
            defaultValue = "30";
        };
		class UO_FW_ForceTerrain_Enabled
        {
            property = "UO_FW_ForceTerrain_Enabled";
            displayName = "Force TerrainGrid";
            tooltip = "Force terrain grid to prevent far away objects from appearing as floating.";
            control = "Checkbox";
            expression="missionNamespace setVariable ['%s', _value]; %s = _value;";
            defaultValue = "false";
        };
    };
};