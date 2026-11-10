mutable void RsEventTechState(string eventName = "", int playerId = -1, int techId = -1, bool fromQueue = false) {}
mutable void RsEventTechStateNotReady(int playerId = -1, int techId = -1, bool fromQueue = false) {}
mutable void RsEventTechStateReady(int playerId = -1, int techId = -1, bool fromQueue = false) {}
mutable void RsEventTechStateQueued(int playerId = -1, int techId = -1, bool fromQueue = false) {}
mutable void RsEventTechStateInProgress(int playerId = -1, int techId = -1, bool fromQueue = false) {}
mutable void RsEventTechStateCompleted(int playerId = -1, int techId = -1, bool fromQueue = false) {}
mutable void RsEventTechStateDisabled(int playerId = -1, int techId = -1, bool fromQueue = false) {}
mutable void RsFeudalAge(int playerId = -1, int civilization = -1) {}
mutable void RsCastleAge(int playerId = -1, int civilization = -1) {}
mutable void RsImperialAge(int playerId = -1, int civilization = -1) {}


int ___RS_API_TECH_CHECKER_GET___(int index = -1, int techId = -1, bool returnIndex = false) {
    int getDb = rsIntArrayGet(___RS_STORAGE_GET___(0), index);
    int getDbSize = xsArrayGetSize(getDb);
    int returnValue = RS_FALSE;

    if(getDbSize > 0) {
        for(itemId = 0; < getDbSize) {
            int getItems = rsIntArrayGet(getDb, itemId);
            if(xsArrayGetSize(getItems) == 2) {
                int key = rsIntArrayGet(getItems, 0);
                if(techId == key) {
                    if(returnIndex) {
                        returnValue = itemId;
                    } else {
                        returnValue = rsIntArrayGet(getItems, 1);
                    }
                    break;
                }
            }
        }
    }

    return(returnValue);
}

bool ___RS_API_TECH_CHECKER_SET___(int index = -1, int techId = -1, int techState = -1) {
    int getDb = rsIntArrayGet(___RS_STORAGE_GET___(0), index);
    int getDbSize = xsArrayGetSize(getDb);
    int getIndex = ___RS_API_TECH_CHECKER_GET___(index, techId, true);
    bool returnValue = false;

    if(getDbSize > 0 && getIndex != RS_FALSE) {
        int getItems = rsIntArrayGet(getDb, getIndex);

        if(xsArrayGetSize(getItems) == 2) {
            int getKey = rsIntArrayGet(getItems, 0);
            if(techId == getKey) {
                rsIntArrayEdit(getItems, 0, techState);
                returnValue = true;
            }
        }
    } else {
        int record = rsIntArray();
            rsIntArrayPush(record, techId);
            rsIntArrayPush(record, techState);
        rsIntArrayPush(getDb, record);
        returnValue = true;
    }
    return(returnValue);
}

bool ___RS_API_TECH_CHECKER_REMOVE___(int index = -1, int techId = -1) {
    int getDb = rsIntArrayGet(___RS_STORAGE_GET___(0), index);
    int getDbSize = xsArrayGetSize(getDb);
    int getIndex = ___RS_API_TECH_CHECKER_GET___(index, techId, true);
    bool returnValue = false;

    if(getDbSize > 0 && getIndex != RS_FALSE) {
        int getItems = rsIntArrayGet(getDb, getIndex);

        if(xsArrayGetSize(getItems) == 2) {
            int getKey = rsIntArrayGet(getItems, 0);
            if(techId == getKey) {
                rsIntArrayRemove(getDb, getIndex);
                returnValue = true;
            }
        }
    }
    return(returnValue);
}

void ___RS_API_TECH_CHECKER_CONDITIONS___(int item = -1, int playerId = -1, int techId = -1, int storedState = -1) {
    int currentState = xsGetTechState(techId, playerId);
    bool fromQueue = false;

    if(currentState != storedState) {
        if(currentState == cTechStateNotReady) {
            RsEventTechState("notready", playerId, techId, fromQueue);
            RsEventTechStateNotReady(playerId, techId, fromQueue);
        } else if(currentState == cTechStateReady) {
            fromQueue = false;
            if(storedState == cTechStateQueued) { fromQueue = true; }
            RsEventTechState("ready", playerId, techId, fromQueue);
            RsEventTechStateReady(playerId, techId, fromQueue);
        } else if(currentState == cTechStateQueued) {
            RsEventTechState("queued", playerId, techId, true);
            RsEventTechStateReady(playerId, techId, true);
        } else if(currentState == cTechStateResearching) {
            fromQueue = false;
            if(storedState == cTechStateQueued) { fromQueue = true; }
            RsEventTechState("inprogress", playerId, techId, fromQueue);
            RsEventTechStateInProgress(playerId, techId, fromQueue);
        } else if(currentState == cTechStateDone) {
            RsEventTechState("completed", playerId, techId, false);
            RsEventTechStateCompleted(playerId, techId, false);
            if(techId == 101) {
                RsFeudalAge(playerId, xsGetPlayerCivilization(playerId));
            } else if(techId == 102) {
                RsCastleAge(playerId, xsGetPlayerCivilization(playerId));
            } else if(techId == 103) {
                RsImperialAge(playerId, xsGetPlayerCivilization(playerId));
            }
        } else if(currentState == cTechStateDisabled) {
            fromQueue = false;
            if(storedState == cTechStateQueued) { fromQueue = true; }
            RsEventTechState("disabled", playerId, techId, fromQueue);
            RsEventTechStateDisabled(playerId, techId, fromQueue);
        }
        rsIntArrayEdit(item, 1, currentState);
    }
}

void ___RS_API_TECH_CHECKER_INSPECTOR___() {
    int getDb = ___RS_STORAGE_GET___(0);
    for(player = 0; < xsGetNumPlayers()) {
        int getPlayerStorage = rsIntArrayGet(getDb, player);
        int getStorageSize = xsArrayGetSize(getPlayerStorage);
        int playerId = player + 1;
        if(getStorageSize > 0) {
            for(itemId = 0; < getStorageSize) {
                int getItem = rsIntArrayGet(getPlayerStorage, itemId);
                if(xsArrayGetSize(getItem) == 2) {
                    int key = rsIntArrayGet(getItem, 0);
                    int val = rsIntArrayGet(getItem, 1);
                    ___RS_API_TECH_CHECKER_CONDITIONS___(getItem, playerId, key, val);
                }
            }
        }
    }
}

void rsTechCheckerSetAll(int technologyId = -1) {
    if(technologyId > -1) {
        for(player = 0; < xsGetNumPlayers()) {
            int techState = xsGetTechState(technologyId, (player + 1));
            if(techState != -2) {
                ___RS_API_TECH_CHECKER_SET___(player, technologyId, techState);
            }
        }
    }
}

bool rsTechCheckerSetFor(int player = -1, int technologyId = -1) {
    if(player < 1 || player > xsGetNumPlayers() || technologyId < 0) {
        return(false);
    }

    int techState = xsGetTechState(technologyId, player);
    if(techState != -2) {
        return(___RS_API_TECH_CHECKER_SET___((player - 1), technologyId, techState));
    }

    return(false);
}

bool rsTechCheckerRemoveFor(int player = -1, int technologyId = -1) {
    if(player < 1 || player > xsGetNumPlayers() || technologyId < 0) {
        return(false);
    }
    return(___RS_API_TECH_CHECKER_REMOVE___((player - 1), technologyId));
}

void rsTechCheckerRemoveAll(int technologyId = -1) {
    if(technologyId > -1) {
        for(player = 0; < xsGetNumPlayers()) {
            int techState = xsGetTechState(technologyId, (player + 1));
            if(techState != -2) {
                ___RS_API_TECH_CHECKER_REMOVE___(player, technologyId);
            }
        }
    }
}

int rsTechCheckerGetFrom(int player = -1, int technologyId = -1) {
    if(player < 1 || player > xsGetNumPlayers() || technologyId < 0) {
        return(RS_FALSE);
    }

    return(___RS_API_TECH_CHECKER_GET___((player - 1), technologyId, false));
}

int rsTechCheckerGetAll(int technologyId = -1) {
    if(technologyId < 0) {
        return(RS_FALSE);
    }

    int array = rsIntArray();

    for(player = 0; < xsGetNumPlayers()) {
        rsIntArrayPush(array, ___RS_API_TECH_CHECKER_GET___(player, technologyId, false));
    }
    return(array);
}
