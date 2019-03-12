/*
    Author: Bohemia Interactive, edited by Revo

    Description:
    Saves the values of the combo box when pressing OK. Additionally a 3DEN history is created

    Parameter(s):
    -
    Returns:
    _value
*/

#define COMPONENT 3DEN
#include "\x\UO_FW\addons\Main\script_macros.hpp"
EXEC_CHECK(ALL);
EDEN_CHECK;

params ["_ctrl","_config"];
private _value = _ctrl lbData lbCurSel _ctrl;
_value
