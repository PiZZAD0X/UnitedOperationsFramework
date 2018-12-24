private ["_Unit", "_index", "_wPos", "_NearestEnemy", "_unit","_GuessLocation","_UO_FW_AI_MovedRecently","_UO_FW_AI_MovedRecentlyCover","_UO_FW_AI_InCover","_ReturnVariable"];
_Unit = _this select 0;
//systemchat format ["%1",((group _Unit) call UO_FW_AI_fnc_Waypointcheck)];
//if ((count ((group _Unit) call UO_FW_AI_fnc_Waypointcheck)) > 0) exitwith {};
if (UO_FW_AI_CurrentlyMoving < UO_FW_AI_CurrentlyMovingLimit) then
{
	_UO_FW_AI_GARRISONED = _this select 1;
	_UO_FW_AI_MovedRecently = _this select 2;
	_UO_FW_AI_MovedRecentlyCover = _this select 3;
	_UO_FW_AI_InCover = _this select 4;
	_UO_FW_AI_VisuallyCanSee = _this select 5;
	_UO_FW_AI_ActivelyClearing = _this select 6;
	_UO_FW_AI_StartedInside = _this select 7;
	_FiredRecently = _unit getVariable ["UO_FW_AI_FiredTime",diag_ticktime];
	
	//systemchat "EXECUTED COMBAT MOVEMENT!";
	//systemchat format ["%1",(diag_tickTime - _FiredRecently)];
	
	if (_UO_FW_AI_MovedRecentlyCover || {(diag_tickTime - _FiredRecently) < 3} || {_UO_FW_AI_VisuallyCanSee} || {_UO_FW_AI_ActivelyClearing} || {_UO_FW_AI_StartedInside} || {_UO_FW_AI_GARRISONED} || {_UO_FW_AI_MovedRecently}) exitWith {_ReturnVariable = [false,false,false];UO_FW_AI_CurrentlyMoving = UO_FW_AI_CurrentlyMoving - 1;_ReturnVariable};
	_Squadlead = leader _Unit;
	
	if (_Squadlead distance _Unit > 60) then
	{
		//_Unit domove (getposATL _Squadlead);
			_Unit forcespeed -1;
	}
	else
	{
		_Group = (group _Unit);
		//Pull the waypoint information
		_index = currentWaypoint _Group;
		
		_WPPosition = getWPPos [_Group,_index];
		//systemchat format ["_WPPosition: %1",_WPPosition];
		if !(_WPPosition isEqualTo [0,0,0]) then
		{
			if (_Unit isEqualTo (leader _Unit)) then
			{
				_GroupDudes = units (group _Unit);
				_NearestEnemy = _Unit call UO_FW_AI_fnc_ClosestEnemy;
				if (isNil "_NearestEnemy" || _NearestEnemy isEqualTo [0,0,0]) then {_NearestEnemy = _WPPosition;};
				//systemchat format ["_NearestEnemy: %1",_NearestEnemy];	
				_UO_FW_AI_MovedRecentlyRETURN = true;
				_UO_FW_AI_MovedRecentlyCoverRETURN = true;
				_UO_FW_AI_InCoverRETURN = true;		
				_ReturnVariable = [_UO_FW_AI_MovedRecentlyRETURN,_UO_FW_AI_MovedRecentlyCoverRETURN,_UO_FW_AI_InCoverRETURN];			
				{
					[_x,_WPPosition,_UO_FW_AI_GARRISONED,_UO_FW_AI_MovedRecentlyCover,_UO_FW_AI_ActivelyClearing,_UO_FW_AI_StartedInside,_NearestEnemy] spawn 
					{
						_Unit = _this select 0;					
						if !((vehicle _Unit) isEqualTo _Unit) exitWith {};
						waitUntil {UO_FW_AI_CurrentlyMoving < UO_FW_AI_CurrentlyMovingLimit};
						UO_FW_AI_CurrentlyMoving = UO_FW_AI_CurrentlyMoving + 1;
						sleep (random 10);
						_Pos = _this select 1;
						_UO_FW_AI_GARRISONED = _this select 2;
						_UO_FW_AI_MovedRecentlyCover = _this select 3;
						_UO_FW_AI_ActivelyClearing = _this select 4;
						_UO_FW_AI_StartedInside = _this select 5;
						_NearestEnemy = _this select 6;
						
						
						_MoveToPos = [_Unit,_Pos,_NearestEnemy] call UO_FW_AI_fnc_FragmentMove;
						//systemchat format ["_MoveToPos: %1",_MoveToPos];	
						if !((vehicle _Unit) isEqualTo _Unit) exitWith
						{
							_Unit forceSpeed -1;
							_Unit doMove _Pos;
						};			
						_CoverPos = [_Unit,_MoveToPos,_UO_FW_AI_GARRISONED,_UO_FW_AI_MovedRecentlyCover,_UO_FW_AI_ActivelyClearing,_UO_FW_AI_StartedInside,_NearestEnemy] call UO_FW_AI_fnc_FindCoverPos;
						//systemchat format ["_CoverPos: %1",_CoverPos];	
				
						if !(isNil "_CoverPos") then
						{
						if (UO_FW_AI_DEBUG) then
						{
							_arrow = "Sign_Sphere200cm_F" createVehicle [0,0,0];
							_arrow setpos _CoverPos;
							_arrow spawn 
							{
								_Counter = 0;
								_Position = getpos _this;
								_NewPos2 = _Position select 2;						
								while {_Counter < 60} do
								{
									_NewPos2 = _NewPos2 + 0.1;
									_this setpos [_Position select 0,_Position select 1,_NewPos2];
									_Counter = _Counter + 1;
									sleep 0.5;
								};
								deletevehicle _this;
							};
						};
						
							_Unit doWatch ObjNull;
							_Unit disableAI "TARGET";
							_Unit disableAI "AUTOTARGET";																									
							_Unit disableAI "SUPPRESSION";				
							_Unit disableAI "AUTOCOMBAT";								
							_WaitTime = diag_ticktime + 35;
							While {alive _Unit && diag_ticktime < _WaitTime && (_Unit distance _CoverPos) > 3} do 
							{
										_Unit forcespeed -1;							
										_Unit domove _CoverPos;
								//	};
								sleep 4;		
							};
							//systemchat format ["MADE IT: %1",_Unit];
							_Unit forcespeed 0;
						}
						else
						{
							_Unit forcespeed -1;
							_Unit doMove _MoveToPos;
						};
						_Unit enableAI "AUTOTARGET";
						_Unit enableAI "TARGET";				
						_Unit enableAI "SUPPRESSION";				
						_Unit enableAI "AUTOCOMBAT";	
						_Unit doWatch _NearestEnemy;
					};
				} foreach _GroupDudes;
			};
			_UO_FW_AI_MovedRecentlyRETURN = true;
			_UO_FW_AI_MovedRecentlyCoverRETURN = true;
			_UO_FW_AI_InCoverRETURN = true;		
			_ReturnVariable = [_UO_FW_AI_MovedRecentlyRETURN,_UO_FW_AI_MovedRecentlyCoverRETURN,_UO_FW_AI_InCoverRETURN];			
			//_Unit setVariable ["UO_FW_AI_InCover",true,false];
		}
		else
		{
			_UO_FW_AI_MovedRecentlyRETURN = false;
			_UO_FW_AI_MovedRecentlyCoverRETURN = false;
			_UO_FW_AI_InCoverRETURN = false;		
			_ReturnVariable = [_UO_FW_AI_MovedRecentlyRETURN,_UO_FW_AI_MovedRecentlyCoverRETURN,_UO_FW_AI_InCoverRETURN];	
			
		};
		UO_FW_AI_CurrentlyMoving = UO_FW_AI_CurrentlyMoving - 1;
	};
};
if (isNil "_ReturnVariable") then {_ReturnVariable = [false,false,false];};
_ReturnVariable