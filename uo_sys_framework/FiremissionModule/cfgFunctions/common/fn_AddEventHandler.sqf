#include "..\..\Global\defs.hpp"
if (!((_this) getVariable [VAR_SART_ARTHASEH,false])) then {
        (_this) addeventhandler ["firedMan", {(_this select 0) setvehicleammo 1}];
        (_this) setVariable [VAR_SART_ARTHASEH,true];
};
