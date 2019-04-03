//class EGVAR(AI,InitPost) {
//    init = QUOTE(_this call EFUNC(AI,playerInit));
//};

class EGVAR(AI,InitPost) {
    init = QUOTE(\
        private _unit = (_this select 0);\
        if (isPlayer _unit) then {\
            _unit call EFUNC(AI,playerInit);\
        } else {\
            _unit call EFUNC(AI,onInit);\
        };\
    );
};
