#include "\x\UO_FW\addons\Main\HeadlessAIModule\module_macros.hpp"
AI_EXEC_CHECK(SERVERHC);

params["_arr"];
{
    private _vehicle = _x;
    if (!(_vehicle isKindOf "Logic") && {!isNull _vehicle}) then {
        {
            private _object = _x;
            detach _object;
            deleteVehicle _object;
        } foreach attachedObjects _vehicle;
        deleteVehicle _vehicle;
        deleteGroup (group _vehicle);
    };
} forEach _arr;
