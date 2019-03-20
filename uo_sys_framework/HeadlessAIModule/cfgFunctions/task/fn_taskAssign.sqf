#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params [
    ["_task",4,[0]],
    ["_grp",grpNull,[grpNull]],
    ["_pos",[],[[]]],
    ["_radius",50,[0]],
    ["_wait",3,[0]],
    ["_behaviour", "UNCHANGED", [""]],
      ["_combat", "NO CHANGE", [""]],
      ["_speed", "UNCHANGED", [""]],
    ["_formation", "NO CHANGE", [""]],
    ["_occupyOption",0,[0]],
    ["_bld",objNull,[objNull]],
    ["_blds",[],[[]]]
];

private _taskSet = [_grp,_pos,_radius,_wait,_behaviour,_combat,_speed,_formation];
private _taskSetBasic = [_grp,_behaviour,_combat,_speed,_formation];
private _taskSetBld = [_bld,_grp,_pos,_radius,_wait,_behaviour,_combat,_speed,_formation];
private _taskSetBlds = [_blds,_grp,_pos,_radius,_wait,_behaviour,_combat,_speed,_formation];
switch (_task) do {
    case 0: {_taskSet spawn FUNC(taskLoiter);};     //Loiter
    case 1: {_taskSetBasic spawn FUNC(taskHoldUntil);};     //Hold Until
    case 2: {_taskSet spawn FUNC(taskSentry);};                //Sentry
    case 3: {_taskSetBasic spawn FUNC(taskPlacement);};        //Stationary
    case 4: {_taskSet spawn FUNC(taskPatrol);};                //Patrol
    case 5: {_taskSet spawn FUNC(taskPatrolPerimeter);};    //Patrol Perimeter
    case 6: {
        switch (_occupyOption) do {
            case 2: {_taskSetBld spawn FUNC(taskMoveNearestBuildingPatrol);};
            case 3: {_taskSetBld spawn FUNC(taskMoveRandomBuildingPatrol);};
            case 4: {_taskSetBlds spawn FUNC(taskMoveGroupBuildingsPatrol);};
            case 5: {_taskSetBlds spawn FUNC(taskMoveRandomGroupBuildingsPatrol);};
            case 6: {_taskSetBlds spawn FUNC(taskMoveMultipleBuildingsPatrol);};
            case 7: {_taskSetBlds spawn FUNC(taskMoveRandomMultipleBuildingsPatrol);};
            default {_taskSetBld spawn FUNC(taskMoveNearestBuildingPatrol);};
        };
    };
    case 7: {
        switch (_occupyOption) do {
            case 2: {_taskSetBld spawn FUNC(taskMoveNearestBuildingDefend);};
            case 3: {_taskSetBld spawn FUNC(taskMoveRandomBuildingDefend);};
            case 4: {_taskSetBlds spawn FUNC(taskMoveGroupBuildingsDefend);};
            case 5: {_taskSetBlds spawn FUNC(taskMoveRandomGroupBuildingsDefend);};
            case 6: {_taskSetBlds spawn FUNC(taskMoveMultipleBuildingsDefend);};
            case 7: {_taskSetBlds spawn FUNC(taskMoveRandomMultipleBuildingsDefend);};
            default {_taskSetBld spawn FUNC(taskMoveNearestBuildingDefend);};
        };
    };
    case 8: {_taskSet spawn FUNC(TaskSetBunker);};    //Entrenched
    case 9: {_taskSet spawn {};};    //Reinforcements
    case 10: {_taskSet spawn {};};    //NONE
    default {_taskSet spawn FUNC(taskPatrol);};
};
true
