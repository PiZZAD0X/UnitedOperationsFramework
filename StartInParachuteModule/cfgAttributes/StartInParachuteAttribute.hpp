class UO_FW_StartInParachuteAttribute: Toolbox 
{
	attributeLoad = "missionnamespace setvariable ['UO_FW_StartInParachute_value',_value]; (_this controlsGroupCtrl 193) lbsetcursel _value;";
	attributeSave = "missionnamespace getvariable ['UO_FW_StartInParachute_value',0];";
	h = "18 * (pixelH * pixelGrid * 0.50)";
	class Controls: Controls 
	{
		class Title: Title {};
		class Value: ctrlToolbox
		 {
			idc = 193;
			style = "0x02";
			x = "48 * (pixelW * pixelGrid * 0.50)";
            w = "82 * (pixelW * pixelGrid * 0.50)";
            h = "12 * (pixelH * pixelGrid * 0.50)";
			rows = 2;
            columns = 3;
			strings[] = {"NONE","NONSTEERABLE","STEERABLE"};
			values[] = {0,1,2,3,4,5};
			onToolboxSelChanged = "missionnamespace setvariable ['UO_FW_StartInParachute_value',(_this select 1)];";
		};
	};
};