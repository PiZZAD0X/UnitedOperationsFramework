/*
 * Author: Olsen
 *
 * Remove all gear.
 *
 * Arguments:
 * 0: unit <object>
 *
 * Return Value:
 * nothing
 *
 * Public: No
 */

#define COMPONENT Gear
#include "\x\UO_FW\addons\Main\script_macros.hpp"
EXEC_CHECK(ALL);

#define WHITELIST ["None","G_Spectacles","G_Spectacles_Tinted","G_Lowprofile","G_Shades_Black","G_Shades_Green","G_Shades_Red","G_Squares","G_Squares_Tinted","G_Sport_BlackWhite","G_Sport_Blackyellow","G_Sport_Greenblack","G_Sport_Checkered","G_Sport_Red","G_Tactical_Black","G_Aviator","G_Bandanna_blk","G_Bandanna_oli","G_Bandanna_khk","G_Bandanna_tan","G_Bandanna_shades","G_Bandanna_sport","G_Bandanna_aviator","G_Shades_Blue", "G_Sport_Blackred","G_Tactical_Clear","rhs_scarf", "G_Combat_Goggles_tna_F","rhs_googles_black","rhs_googles_clear","rhs_googles_yellow","rhs_googles_orange","rhs_ess_black"]

params ["_unit"];

if(!(_unit isKindOf "CAManBase")) then
{
   _unit call FUNC(RemoveAllVehicleGear);
}
else
{
    removeHeadgear _unit;
    if ((!isPlayer _unit) || {!((goggles _unit) in WHITELIST)} || {GETMVAR(Olsen_FaceRemovalEnabled,false)}) then {
        removeGoggles _unit;
    };
    removeVest _unit;
    removeBackpack _unit;
    removeUniform _unit;
    removeAllWeapons _unit;
    removeAllAssignedItems _unit;
};
