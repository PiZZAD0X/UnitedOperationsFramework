class EndConditionMainSettings_Category1
{
    displayName = "Category Settings";
    collapsed = 0;
    class Attributes
    {
		class UO_FW_EndCondition_Enabled_1
        {
            property = "UO_FW_EndCondition_Enabled_1";
            displayName = "Enable Category";
            tooltip = "Toggle Activation of the End Condition Category";
			control = "CheckBoxState";
            expression="missionNamespace setVariable ['%s', _value]; %s = _value;";
            defaultValue = "false";
        };
        class UO_FW_EndCondition_Mode_1
        {
            property = "UO_FW_EndCondition_Mode_1";
            displayName = "Category Mode";
            tooltip = "Whether or not the condition fires if any condition is true, or if all conditions are true";
			control = "UO_FW_ENDCONDITIONS_MODEATTRIBUTE";
            expression="missionNamespace setVariable ['%s', _value]; %s = _value;";
			validate = "number";
            defaultValue = "0";
        };
		class UO_FW_EndCondition_Message_1
        {
            property = "UO_FW_EndCondition_Message_1";
            displayName = "Category Message";
            tooltip = "Message displayed when end condition category is triggered";
            control = "Edit";
			validate = "string";
            expression="missionNamespace setVariable ['%s', _value]; %s = _value;";
            defaultValue = "'End condition 1 fired!'";
        };
		class UO_FW_EndCondition_EndDelay
        {
            property = "UO_FW_EndCondition_EndDelay";
            displayName = "Mission End Delay";
            tooltip = "Delay in seconds between the end condition category being fired and when the mission ends.";
			control = "EditShort";
            expression="missionNamespace setVariable ['%s', _value]; %s = _value;";
			validate = "number";
            defaultValue = "30";
        };
	};
};

class EndConditionCasualtySettings_Category1
{
    displayName = "Casualty Settings";
    collapsed = 0;
    class Attributes
    {
		class UO_FW_EndCondition_CasualtyCount_BLUFOR_Enabled_1
        {
            property = "UO_FW_EndCondition_CasualtyCount_BLUFOR_Enabled_1";
            displayName = "BLUFOR Casualty";
            tooltip = "Enables casualty limit for this team";
            control = "CheckBox";
            expression="missionNamespace setVariable ['%s', _value]; %s = _value;";
            defaultValue = "false";
        };
        class UO_FW_EndCondition_CasualtyCount_BLUFOR_Percentage_1
        {
            property = "UO_FW_EndCondition_CasualtyCount_BLUFOR_Percentage_1";
            displayName = "Casualty Percentage";
            tooltip = "End condition fires when team casualty percentage is over this number";
			control = "EditShort";
            expression="missionNamespace setVariable ['%s',_value];";
			validate = "number";
            defaultValue = "75";
        };
		class UO_FW_EndCondition_CasualtyCount_OPFOR_Enabled_1
        {
            property = "UO_FW_EndCondition_CasualtyCount_OPFOR_Enabled_1";
            displayName = "OPFOR Casualty";
            tooltip = "Enables casualty limit for this team";
            control = "CheckBox";
            expression="missionNamespace setVariable ['%s', _value]; %s = _value;";
            defaultValue = "false";
        };
        class UO_FW_EndCondition_CasualtyCount_OPFOR_Percentage_1
        {
            property = "UO_FW_EndCondition_CasualtyCount_OPFOR_Percentage_1";
            displayName = "Casualty Percentage";
            tooltip = "End condition fires when team casualty percentage is over this number";
			control = "EditShort";
            expression="missionNamespace setVariable ['%s',_value];";
			validate = "number";
            defaultValue = "75";
        };
		class UO_FW_EndCondition_CasualtyCount_RESISTANCE_Enabled_1
        {
            property = "UO_FW_EndCondition_CasualtyCount_RESISTANCE_Enabled_1";
            displayName = "INDFOR Casualty";
            tooltip = "Enables casualty limit for this team";
            control = "CheckBox";
            expression="missionNamespace setVariable ['%s', _value]; %s = _value;";
            defaultValue = "false";
        };
        class UO_FW_EndCondition_CasualtyCount_RESISTANCE_Percentage_1
        {
            property = "UO_FW_EndCondition_CasualtyCount_RESISTANCE_Percentage_1";
            displayName = "Casualty Percentage";
            tooltip = "End condition fires when team casualty percentage is over this number";
			control = "EditShort";
            expression="missionNamespace setVariable ['%s',_value];";
			validate = "number";
            defaultValue = "75";
        };
		class UO_FW_EndCondition_CasualtyCount_CIVILIAN_Enabled_1
        {
            property = "UO_FW_EndCondition_CasualtyCount_CIVILIAN_Enabled_1";
            displayName = "CIVILIAN Casualty";
            tooltip = "Enables casualty limit for this team";
            control = "CheckBox";
            expression="missionNamespace setVariable ['%s', _value]; %s = _value;";
            defaultValue = "false";
        };
        class UO_FW_EndCondition_CasualtyCount_CIVILIAN_Percentage_1
        {
            property = "UO_FW_EndCondition_CasualtyCount_CIVILIAN_Percentage_1";
            displayName = "Casualty Percentage";
            tooltip = "End condition fires when team casualty percentage is over this number";
			control = "EditShort";
            expression="missionNamespace setVariable ['%s',_value];";
			validate = "number";
            defaultValue = "75";
        };
    };
};

class EndConditionEntitySettings_Category1
{
    displayName = "Entity Settings";
    collapsed = 0;
    class Attributes
    {
		class UO_FW_EndCondition_EntitiesAlive_Array_1
        {
            property = "UO_FW_EndCondition_EntitiesAlive_Array_1";
            displayName = "Alive Entities";
            tooltip = "Array of entities checked for alive status. Leave blank to disable";
			control = "EditShort";
            expression="missionNamespace setVariable ['%s',_value];";
            defaultValue = "''";
        };
		class UO_FW_EndCondition_EntitiesDead_Array_1
        {
            property = "UO_FW_EndCondition_EntitiesDead_Array_1";
            displayName = "Dead Entities";
            tooltip = "Array of entities checked for dead status. Leave blank to disable";
			control = "EditShort";
            expression="missionNamespace setVariable ['%s',_value];";
            defaultValue = "''";
        };
		class UO_FW_EndCondition_EntitiesDamaged_Array_1
        {
            property = "UO_FW_EndCondition_EntitiesDamaged_Array_1";
            displayName = "Damaged Entities";
            tooltip = "Array of entities checked for over 50 percent damage or immobilized status. Includes dead state. Leave blank to disable";
			control = "EditShort";
            expression="missionNamespace setVariable ['%s',_value];";
            defaultValue = "''";
        };
	};
};

class EndConditionVariableSettings_Category1
{
    displayName = "Custom Variable Settings";
    collapsed = 0;
    class Attributes
    {
		class UO_FW_EndCondition_CustomVariables_Array_1
        {
            property = "UO_FW_EndCondition_CustomVariables_Array_1";
            displayName = "Custom Variables";
            tooltip = "Array of variables to check for true status. Leave blank to disable";
			control = "EditShort";
            expression="missionNamespace setVariable ['%s',_value];";
            defaultValue = "''";
        };
	};
};

class EndConditionExtractionSettings_Category1
{
    displayName = "Extraction Settings";
    collapsed = 0;
    class Attributes
    {
		class UO_FW_EndCondition_ExtractionEnabled_1
        {
            property = "UO_FW_EndCondition_Extraction_1";
            displayName = "Require Extraction";
            tooltip = "Require Extraction in addition to end conditions for this category.";
			control = "CheckBoxState";
            expression="missionNamespace setVariable ['%s',_value];";
            defaultValue = "false";
        };
		class UO_FW_EndCondition_ExtractionTeam_1
        {
            property = "UO_FW_EndCondition_Extraction_1";
            displayName = "Team";
            tooltip = "Team required to be in extract area.";
			control = "UO_FW_ENDCONDITIONS_EXTRACTTEAM";
            expression="missionNamespace setVariable ['%s',_value];";
			defaultValue = "false";
        };
		class UO_FW_EndCondition_ExtractionMarker_1
        {
            property = "UO_FW_EndCondition_ExtractionMarker_1";
            displayName = "Extraction Marker";
            tooltip = "Marker name of extraction area.";
			control = "EditShort";
            expression="missionNamespace setVariable ['%s',_value];";
            defaultValue = "''";
        };
		class UO_FW_EndCondition_ExtractionRatio_1
        {
            property = "UO_FW_EndCondition_ExtractionRatio_1";
            displayName = "Ratio";
            tooltip = "Percentage of alive personnel inside the marker to be considered extracted.";
			control = "EditShort";
            expression="missionNamespace setVariable ['%s',_value];";
            validate = "number";
			defaultValue = "75";
        };
	};
};