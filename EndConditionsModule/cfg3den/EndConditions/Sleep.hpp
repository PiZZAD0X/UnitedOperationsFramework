class EndConditionSleepMenu
{
    displayName = "End Condition Loop Settings";
    collapsed = 0;
    class Attributes
    {
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
	};
};