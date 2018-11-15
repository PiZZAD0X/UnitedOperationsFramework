if (missionNamespace getVariable ["UO_FW_EndCondition_Enabled_1",false]) then
{
	if ((isNil "UO_FW_EndCondition_Message_1") || !(typename UO_FW_EndCondition_Message_1 isEqualto "STRING")) then 
	{
		["","invalid message for End Condition Category 1"] call UO_FW_fnc_DebugMessageDetailed;
		
	} else 
	{
		["","Valid message for End Condition Category 1, executing"] call UO_FW_fnc_DebugMessageDetailed;
		//_conditionsCategory1 = [[UO_FW_EndCondition_CasualtyCount_BLUFOR_Enabled_1,UO_FW_EndCondition_CasualtyCount_BLUFOR_Percentage_1],[UO_FW_EndCondition_CasualtyCount_OPFOR_Enabled_1,UO_FW_EndCondition_CasualtyCount_OPFOR_Percentage_1],[UO_FW_EndCondition_CasualtyCount_RESISTANCE_Enabled_1,UO_FW_EndCondition_CasualtyCount_RESISTANCE_Percentage_1],[UO_FW_EndCondition_CasualtyCount_CIVILIAN_Enabled_1,UO_FW_EndCondition_CasualtyCount_CIVILIAN_Percentage_1],[UO_FW_EndCondition_EntitiesAlive_Array_1,UO_FW_EndCondition_EntitiesDead_Array_1,UO_FW_EndCondition_EntitiesDamaged_Array_1,UO_FW_EndCondition_EntitiesDeadORDamaged_Array_1],[UO_FW_EndCondition_CustomVariables_Array_1]];
		//casualties index 0 
		//blufor casualty index 0 select 0
		//blufor cas percentage index 0 select 0 select 1
		//opfor cas enabled index 0 select 1 select 0
		//opfor cas percentage index 0 select 1 select 1
		//entities index 1
		//entities alive index 1 select 0
		//custom variables index 2
		
		_conditionsCountCategory1 = 0;
		
		if (UO_FW_EndCondition_CasualtyCount_BLUFOR_Enabled_1) then {_conditionsCountCategory1 = _conditionsCountCategory1 + 1;};
		if (UO_FW_EndCondition_CasualtyCount_OPFOR_Enabled_1) then {_conditionsCountCategory1 = _conditionsCountCategory1 + 1;};
		if (UO_FW_EndCondition_CasualtyCount_RESISTANCE_Enabled_1) then {_conditionsCountCategory1 = _conditionsCountCategory1 + 1;};
		if (UO_FW_EndCondition_CasualtyCount_CIVILIAN_Enabled_1) then {_conditionsCountCategory1 = _conditionsCountCategory1 + 1;};
	
		if (!(UO_FW_EndCondition_EntitiesAlive_Array_1 isEqualto "")) then {_conditionsCountCategory1 = _conditionsCountCategory1 + 1;};
		if (!(UO_FW_EndCondition_EntitiesDead_Array_1 isEqualto "")) then {_conditionsCountCategory1 = _conditionsCountCategory1 + 1;};
		if (!(UO_FW_EndCondition_EntitiesDamaged_Array_1 isEqualto "")) then {_conditionsCountCategory1 = _conditionsCountCategory1 + 1;};
		if (!(UO_FW_EndCondition_HostageRescued_Array_1 isEqualto "")) then {_conditionsCountCategory1 = _conditionsCountCategory1 + 1;};
		
		if (!(UO_FW_EndCondition_CustomVariables_Array_1 isEqualto "")) then {_conditionsCountCategory1 = _conditionsCountCategory1 + 1;};
		
		if ((UO_FW_EndCondition_CapturezoneEnabled_1)) then {_conditionsCountCategory1 = _conditionsCountCategory1 + 1;};

		_tempdebugtext = format ["Category 1 Condition Count:%1",_conditionsCountCategory1];
		["",_tempdebugtext] call UO_FW_fnc_DebugMessageDetailed;
		if ((_conditionsCountCategory1) > 0) then 
		{
			//spawn loop
			[] spawn {
				while {!UO_FW_MissionEnded} do 
				{
					
					
					_ConditionCheckList = [];
					
					//Casualty Checks
					_BluforCasConditionCheck = false;
					
					if (UO_FW_EndCondition_CasualtyCount_BLUFOR_Enabled_1) then 
					{
						_westCasualty = UO_FW_TeamSetting_Blufor_TeamName call UO_FW_fnc_CasualtyPercentage;
						if (_westCasualty >= UO_FW_EndCondition_CasualtyCount_BLUFOR_Percentage_1) then {_BluforCasConditionCheck = true;} else {_BluforCasConditionCheck = false;};
						_ConditionCheckList pushback ["BLUFOR Cas Check",_BluforCasConditionCheck];
					};
					
					_OpforCasConditionCheck = false;
					
					if (UO_FW_EndCondition_CasualtyCount_OPFOR_Enabled_1) then 
					{
						_eastCasualty = UO_FW_TeamSetting_Opfor_TeamName call UO_FW_fnc_CasualtyPercentage;
						if (_eastCasualty >= UO_FW_EndCondition_CasualtyCount_OPFOR_Percentage_1) then {_OpforCasConditionCheck = true;} else {_OpforCasConditionCheck = false;};
						_ConditionCheckList pushback ["OPFOR Cas Check",_OpforCasConditionCheck];
					};
					
					_IndforCasConditionCheck = false;
					
					if (UO_FW_EndCondition_CasualtyCount_RESISTANCE_Enabled_1) then 
					{
						_resCasualty = UO_FW_TeamSetting_Indfor_TeamName call UO_FW_fnc_CasualtyPercentage;
						if (_resCasualty >= UO_FW_EndCondition_CasualtyCount_RESISTANCE_Percentage_1) then {_IndforCasConditionCheck = true;} else {_IndforCasConditionCheck = false;};
						_ConditionCheckList pushback ["INDFOR Cas Check",_IndforCasConditionCheck];
					};
					
					_CivilianCasConditionCheck = false;
					
					if (UO_FW_EndCondition_CasualtyCount_CIVILIAN_Enabled_1) then 
					{
						_civCasualty = UO_FW_TeamSetting_Civ_TeamName call UO_FW_fnc_CasualtyPercentage;
						if (_civCasualty >= UO_FW_EndCondition_CasualtyCount_CIVILIAN_Percentage_1) then {_CivilianCasConditionCheck = true;} else {_CivilianCasConditionCheck = false;};
						_ConditionCheckList pushback ["CIVILIAN Cas Check",_CivilianCasConditionCheck];
					};
					
					//alive entity block
					_aliveUnitArray = missionNamespace getVariable ["UO_FW_EndCondition_EntitiesAlive_Array_1",[]];
					if (!(_aliveUnitArray isEqualto [])) then 
					{
						
						["",format ["Alive Array 1:%1",_aliveUnitArray]] call UO_FW_fnc_DebugMessageDetailed;
						_alive = true;
						{
							_unit = missionNamespace getVariable [_x,objNull];
							if(typename _unit == "OBJECT" && _unit != objNull) then 
							{
								_alive = _alive && (_unit call UO_FW_FNC_alive);
							}
							else
							{
								_alive = false;
								["Unit " + _x + " not found!","Unit " + _x + " not found!"] call UO_FW_fnc_DebugMessageDetailed;
							};
							
							
						} forEach _aliveUnitArray;
						_ConditionCheckList pushback ["Alive Check",_alive];
						
					};
					
					//dead entity block
					_deadUnitArray = missionNamespace getVariable ["UO_FW_EndCondition_EntitiesDead_Array_1",[]];
					if (!(_deadUnitArray isEqualto [])) then 
					{
						["",format ["Dead Array 1:%1",_deadUnitArray]] call UO_FW_fnc_DebugMessageDetailed;
						_dead = true;
						{
							_unit = missionNamespace getVariable [_x,objNull];
							if(typename _unit == "OBJECT" && _unit != objNull) then 
							{
								_dead = _dead && (!(_unit call UO_FW_FNC_alive));
							}
							else
							{
								_dead = false;
								["Unit " + _x + " not found!","Unit " + _x + " not found!"] call UO_FW_fnc_DebugMessageDetailed;
							};
							
							
						} forEach _deadUnitArray;
						_ConditionCheckList pushback ["Dead Check",_dead];
					};
					
					//damaged & immobilized entity block
					_damagedUnitArray = missionNamespace getVariable ["UO_FW_EndCondition_EntitiesDamaged_Array_1",[]];
					if (!(_damagedUnitArray isEqualto [])) then 
					{
						
						["",format ["Damaged Array 1:%1",_damagedUnitArray]] call UO_FW_fnc_DebugMessageDetailed;

						_damaged = true;
						{
							_unit = missionNamespace getVariable [_x,objNull];
							if(typename _unit == "OBJECT" && _unit != objNull) then 
							{
								_damaged = _damaged && ((damage _unit > 0.5) || ((_unit isKindOf LandVehicle) && (!canMove _unit)));
							}
							else
							{
								_damaged = false;
								["Unit " + _x + " not found!","Unit " + _x + " not found!"] call UO_FW_fnc_DebugMessageDetailed;
							};
							
							
						} forEach _damagedUnitArray;
						_ConditionCheckList pushback ["Damaged Check",_damaged];			
					};

					_hostageRescuedArray = missionNamespace getVariable ["UO_FW_EndCondition_HostageRescued_Array_1",[]];
					if (!(_hostageRescuedArray isEqualto [])) then 
					{
						
						["",format ["Rescued Array 1:%1",_hostageRescuedArray]] call UO_FW_fnc_DebugMessageDetailed;

						_rescued = true;
						{
							_unit = missionNamespace getVariable [_x,objNull];
							if(typename _unit == "OBJECT" && _unit != objNull) then 
							{
								_rescued = _rescued && ((_rescued _unit > 0.5) || ((_unit isKindOf LandVehicle) && (!canMove _unit)));
							}
							else
							{
								_rescued = false;
								["Unit " + _x + " not found!","Unit " + _x + " not found!"] call UO_FW_fnc_DebugMessageDetailed;
							};
							
							
						} forEach _hostageRescuedArray;
						_ConditionCheckList pushback ["Rescued Check",_rescued];			
					};
					
					//custom variables block
					_customVariablesArray = missionNamespace getVariable ["UO_FW_EndCondition_CustomVariables_Array_1",[]];
					if (!(_customVariablesArray isEqualto [])) then 
					{
						_tempdebugtext3 = format ["Var Array 1:%1",UO_FW_EndCondition_CustomVariables_Array_1];
						["",_tempdebugtext3] call UO_FW_fnc_DebugMessageDetailed;
						_custom = true;
						{

							
							if(isNil _x) then
							{
								["Variable " + _x + " does not exist!","Variable " + _x + " does not exist!"] call UO_FW_fnc_DebugMessageDetailed;
							} 
							else
							{
								_Var = missionNamespace getVariable _x;
								_custom = _custom && _Var;
							};
						} forEach _customVariablesArray;
						_ConditionCheckList pushback ["Custom Check",_custom];	
					};
					
					
					
					//capturezoneBlock
					
					_CapturezoneConditionCheck = false;
					
					if (UO_FW_EndCondition_CapturezoneEnabled_1) then 
					{
						_type = UO_FW_EndCondition_CapturezoneMarker_1 call UO_FW_FNC_IsCapturezoneCaptured;
						
						_CapturezoneConditionCheck = (_type == (["NOONE","WEST","EAST","RESISTANCE","CIVILIAN"] select UO_FW_EndCondition_CapturezoneTeam_1));
						
						_ConditionCheckList pushback ["CapturezoneCheck",_CapturezoneConditionCheck];
					};

					_tempdebugtext2 = format ["Category 1 _ConditionCheckList:%1",_ConditionCheckList];
					["",_tempdebugtext2] call UO_FW_fnc_DebugMessageDetailed;

					_ExtractionCheck = false;
					
					//check block
					if (UO_FW_EndCondition_ExtractionEnabled_1) then 
					{
						_team = [UO_FW_TeamSetting_Blufor_TeamName,UO_FW_TeamSetting_Opfor_TeamName,UO_FW_TeamSetting_Indfor_TeamName,UO_FW_TeamSetting_Civ_TeamName] select UO_FW_EndCondition_ExtractionTeam_1;
						if (UO_FW_EndCondition_ExtractionMarker_1 isEqualto "") exitwith {["","No marker entered for extract zone for Category 1!"] call UO_FW_fnc_DebugMessageDetailed;};
						if (getMarkerColor UO_FW_EndCondition_ExtractionMarker_1 isEqualto "") exitwith {["","Invalid extract marker for Category 1!"] call UO_FW_fnc_DebugMessageDetailed;};
							if ([_team,UO_FW_EndCondition_ExtractionMarker_1,UO_FW_EndCondition_ExtractionRatio_1] call UO_FW_fnc_hasExtracted) then {	
								_ExtractionCheck = true;
							} else {
								_ExtractionCheck = false;
							};
					} 
					else 
					{
						_ExtractionCheck = true;
					};
					
					if (_ExtractionCheck) then 
					{
						if (UO_FW_EndCondition_Mode_1 == 1) then 
						{
							{
								_x params ["_name","_value"];
								if (_value) exitwith 
								{
										_tempdebugtext2 = format ["Category 1 Ending due to :%1",_value];
										["",_tempdebugtext2] call UO_FW_fnc_DebugMessageDetailed;
										
										UO_FW_EndCondition_Message_1 call UO_FW_fnc_EndMission;
								};
							} foreach _ConditionCheckList;
						} 
						else 
						{
							if (count ([_ConditionCheckList,false] call UO_FW_fnc_arrayFindAll) <= 0) exitwith 
							{
								_tempdebugtext2 = format ["Category 1 Ending due to :%1",_CapturezoneConditionCheck];
								["",_tempdebugtext2] call UO_FW_fnc_DebugMessageDetailed;
								
								UO_FW_EndCondition_Message_1 call UO_FW_fnc_EndMission;
							};
						};
					};
					sleep(missionNamespace getvariable ["UO_FW_ConditionSleep",30]);
				};
			};
		} else {
			["","No Conditions for Category 1"] call UO_FW_fnc_DebugMessageDetailed;
		};
	};
};