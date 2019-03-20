#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(HC);

if !(GETMVALUE(Enabled,false)) exitWith {};

LOG("running fn_initMain");

[QEGVAR(Core,RegisterModuleEvent), ["Headless AI", "Custom AI Scripts and spawning modules for AI", "PiZZADOX"]] call CBA_fnc_globalEvent;

GVAR(Zones) = [];
GVAR(zoneEntities) = [];
GVAR(templates) = [];
GVAR(respawns) = [];
GVAR(taskedGroups) = [];
GVAR(functions) = [QGVAR(FastAirStrikeModule),QGVAR(AirDropModule),QGVAR(HeloInsertModule)];
GVAR(zoneTypes) = [/*0*/["CAManBase","LandVehicle","Ship","Helicopter","Plane"],/*1*/["CAManBase","LandVehicle"],/*2*/["Helicopter","Plane"],/*3*/["CAManBase","LandVehicle","Helicopter"],/*4*/["CAManBase","LandVehicle","Ship"],/*5*/["CAManBase","LandVehicle","Plane"],/*6*/["Ship","Helicopter","Plane"],/*7*/["CAManBase"],/*8*/["LandVehicle"],/*9*/["Ship"],/*10*/["Helicopter"],/*11*/["Plane"]];
GVAR(paradrop) = false;
GVAR(zoneInit) = [];
GVAR(templatesyncedObjects) = [];
GVAR(templateCleanup) = false;
GVAR(initialised) = true;

GVAR(BasicCheckCurrent) = 0;
GVAR(LeaderExecuteCurrent) = 0;

////Settings to be put in 3den AI settings menu
//Will AI garrison static weapons nearby?
GVAR(STATICGARRISON) = 1;
//Should we let AI use flanking manuevers? false means they can flank
GVAR(REINFORCE) = false;
//Should AI use smoke grenades? Besides default A3 behavior?
GVAR(USESMOKE) = true;
//Chance of AI using grenades
GVAR(GRENADECHANCE) = 35;
//AI will automatically disembark from vehicles when in combat.
GVAR(AIDisembark) = true;
//How low should an AI's mag count be for them to consider finding more ammo? This DOES NOT include the mag loaded in the gun already.
GVAR(AIMagLimit) = 2;
//Should the rain impact accuracy of AI? DEFAULT = true;
GVAR(RainImpact) = true;
//How much should rain impact the accuracy of AI? Default = 3. Default formula is -> _WeatherCheck = (rain)/3; "rain" is on a scale from 0 to 1. 1 Being very intense rain.
GVAR(RainPercent) = 3;
//Should AI and players have an additional layer of suppression that decreases aiming when suppressed? Default = true;
GVAR(Suppression) = false;
//How much should suppression impact both AI and player aiming? Default is 5. Normal ArmA is 1.
GVAR(SuppressionVar) = 5;
//Should AI/players be impacted by adrenaline? This provides players and AI with a small speed boost to animations to assist with cover seeking and positioning for a short time. Default = true;
GVAR(Adrenaline) = false;
//How much of a speed boost should players/AI recieve? Default = 1.35; (1 is ArmA's normal speed).
GVAR(AdrenalineVar) = 1.35;
//How many AI UNITS can be calculating cover positions at once?
GVAR(CurrentlyMovingLimit) = 24;
//How many AI UNITS can be suppressing others at once?
GVAR(CurrentlySuppressingLimit) = 40;
//How many AI can be checking roles/equipment/additional commands at once? This will impact FPS of AI in and out of battle. The goal is to limit how many benign commands are being run at once and bogging down a server with over a couple HUNDRED AI.
GVAR(BasicCheckLimit) = 40;
//How many squad leaders can be executing advanced code at once.
GVAR(LeaderExecuteLimit) = 20;
//How low should the FPS be, before Vcom pauses simulation. This will not disable simulation on AI - they will run default Bohemia AI.
GVAR(FPSFreeze) = 10;
//Should the AI notice IR lasers?
GVAR(IRLaser) = true;
//The longer an AI's target stays in 1 location, the more accurate and aware of the target the AI becomes.DEFAULT = [WEST,EAST,CIVILIAN,INDEPENDENT];
GVAR(IncreasingAccuracy) = true;
//GVAR(SideBasedMovement)- Remove sides from the array below to force that specific AI side to not execute any advance movement code. (I.E. Moving to reinforce allies, being alerted by distant gunshots and etc). AI with this will still react normally in combat. DEFAULT = [WEST,EAST,CIVILIAN,INDEPENDENT];
GVAR(SideBasedMovement) = [WEST,EAST,INDEPENDENT,CIVILIAN];
//GVAR(SideBasedExecution)- Remove sides from the array below to remove that specific AI side from executing any of the VCOMAI scripts at all. DEFAULT = [WEST,EAST,CIVILIAN,INDEPENDENT];
GVAR(SideBasedExecution) = [WEST,EAST,INDEPENDENT,CIVILIAN];
//Whether the AI will set up campfires at night if they are set to "DISMISS" waypoint
GVAR(Campfires) = true;
//Distance the AI will attempt to flank around the enemy. I.E. How far off a waypoint, or around the enemy squad, the AI are willing to go in combat.
GVAR(WaypointDistance) = 300;
//The distance a unit needs to be away for PZAI scripts to temporary disable itself upon the unit? The AI unit will also need to be out of combat.
GVAR(DisableDistance) = 3000;
//Aid to the AI spotting distance and time
GVAR(SIGHTAID_Enabled) = true;
//Distance at which the AI will start seeings enemies in LOS of them
GVAR(SightAid_Distance) = 800;
//Minimum reveal value per increase +n reveal value per check every 5 seconds of targets in LOS of enemies.
GVAR(SightAid_MinIncrease) = 2;
//Distance at which the AI will force engage the enemies
GVAR(SightAid_EngageDistance) = 400;
GVAR(HEARINGAIDS_Enabled) = true;
//How far can the AI hear gunshots from?
GVAR(HearingDistance) = 1400;
//How revealed an enemy is from a gunshot report
GVAR(HearingMinIncrease) = 1;
//Distance a bunker enemy can see/engage the enemy
GVAR(Bunker_Enabled) = true;
//Distance a bunker enemy can see/engage the enemy
GVAR(Bunker_Distance) = 900;
//Whether Bunker AI get released and act normally/free to move if enemies get too close
GVAR(Bunker_Release) = true;
//Sensitivity/Sightlevel needed for Bunker AI to engage - lower is more sensitive.
GVAR(Bunker_Sightlevel) = 0.25;
//Distance at which AI are released from bunker
GVAR(Bunker_Release_Dist) = 25;
//Distance AI will respond to call of help from each other
GVAR(Radio_Distance) = 1200;
//Whether or not AI need ACRE radios to broadcast info to other groups
GVAR(Radio_NeedRadio) = false;
//Distance the AI will patrol to by default when set to "GUARD" waypoint
GVAR(PatrolDistance) = 200;
//Whether the AI will patrol between garrison positions. Pretty buggy, but nice for 'mersion
GVAR(GarrisonPatrol) = true;
GVAR(FORCETIME_Enabled) = false;
GVAR(FORCETIME_TIME) = 12;

//Lets gets the queue handler going
[{CBA_MissionTime > 0},{
    [] call FUNC(QueueHandle);
    [] call FUNC(ActiveHandler);
    [] call FUNC(GroupHandler);
    [] call FUNC(MapMarkers);
    [] call FUNC(zoneMonitor);
}] call CBA_fnc_waitUntilAndExecute;

//leader/group behavior handling loop
//[] spawn FUNC(MainLoop);

if ((!hasinterface) && {(!isDedicated)}) then {
    setViewDistance (missionNamespace getvariable [QGVAR(ViewDistance),2500]);
    if (GVAR(FORCETIME_Enabled)) then {
        private _timeForced = missionNamespace getvariable [QGVAR(FORCETIME_TIME),daytime];
        [{CBA_missionTime > 1},{
            GVAR(TimeForcedPFH) = [{
                params ["_args", "_idPFH"];
                _args params ["_timeForced"];
                private _daytime = daytime;
                skiptime ((_timeForced / 3600) - _daytime);
            }, 1, [_timeForced]] call CBA_fnc_addPerFrameHandler;
        }, [_timeForced]] call CBA_fnc_waitUntilAndExecute;
    };
};

GVAR(InitMainInitialized) = true;
