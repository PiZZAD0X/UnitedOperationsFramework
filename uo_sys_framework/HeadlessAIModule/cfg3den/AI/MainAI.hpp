class MainAI
{
    displayName = "AI Settings";
    collapsed = 0;
    class Attributes
    {
		class UO_FW_AI_Enabled
        {
            property = "UO_FW_AI_Enabled";
            displayName = "Enable AI System";
            tooltip = "Enable AI System";
            control = "CheckboxState";
            expression="missionNamespace setVariable ['%s', _value, true]; %s = _value;";
            defaultValue = "false";

        };
        class UO_FW_AI_DEBUG
        {
            property = "UO_FW_AI_DEBUG";
            displayName = "Debug Mode";
            tooltip = "Enables Debug Mode";
            control = "Checkbox";
            expression="missionNamespace setVariable ['%s', _value, true]; %s = _value;";
            defaultValue = "false";

        };
        class UO_FW_AI_MARKERS_ENABLED
        {
            property = "UO_FW_AI_MARKERS_ENABLED";
            displayName = "Debug Markers";
            tooltip = "Enables Debug Markers for AI";
            control = "Checkbox";
            expression="missionNamespace setVariable ['%s', _value, true]; %s = _value;";
            defaultValue = "false";

        };
    };
};