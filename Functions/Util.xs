bool ___RS_UTIL_PLAYER_IN_RANGE___(int playerId  = -1) {
    if(playerId < 0 || playerId > xsGetNumPlayers()) {
        return(false);
    }
    return(true);
}

bool ___RS_UTIL_IS_UNIT_CLASS___(int number = -1) {
    bool isClass = false;

    for(i = 900; < 968) {
        if(number == i) {
            isClass = true;
            break;
        }
    }
    return(isClass);
}

string ___RS_UTIL_GET_AGE___(int playerId = -1) {
    int getCurrentAge = xsPlayerAttribute(playerId, cAttributeCurrentAge);

    if(getCurrentAge == cFeudalAge) {
        return("Feudal");
    } else if(getCurrentAge == cCastleAge) {
        return("Castle");
    } else if(getCurrentAge == cImperialAge) {
        if(xsGetTechState(636, playerId) == cTechStateDone) {
            return("Post-Imperial");
        } else {
            return("Imperial");
        }
    } else {
        return("Dark");
    }
    return("");
}