extern const int RS_FALSE = -9999999;
extern const int RS_TRUE = 9999999;

int ___RS_STORAGE___ = -1;

int ___RS_STORAGE_GET___(int index = -1) {
    if(___RS_STORAGE___ == -1) {
        int maxPlayers = xsGetNumPlayers();
        ___RS_STORAGE___ = xsArrayCreateInt(10,0);

        int storageTech = xsArrayCreateInt(maxPlayers, 0);
        for(i = 0; < maxPlayers) { xsArraySetInt(storageTech, i, xsArrayCreateInt(0)); }
        xsArraySetInt(___RS_STORAGE___, 0, storageTech); // Tech State API

        xsArraySetInt(___RS_STORAGE___, 1, xsArrayCreateInt(0)); // Timer API

        xsArraySetInt(___RS_STORAGE___, 2, xsArrayCreateInt(maxPlayers, -1)); // Age Checker
    }

    return(xsArrayGetInt(___RS_STORAGE___, index));
}
int rsIntArray(string values = "") {
    int array = xsArrayCreateInt(0);

    if(values != "") {
        int items = strSplit(values, ",");
        int size = xsArrayGetSize(items);
        xsArrayResizeInt(array, size);
        for(i = 0; < xsArrayGetSize(items)) {
            int item = strToInt(strTrim(xsArrayGetString(items, i)), 10, -1);
            xsArraySetInt(array, i, item);
        }
    }

    return(array);
}

bool rsIntArrayPush(int arrayId = -1, int value = -1) {
    int getSize = xsArrayGetSize(arrayId);
    xsArrayResizeInt(arrayId, getSize + 1);
    return(xsArraySetInt(arrayId, getSize, value));
}

bool rsIntArrayEdit(int arrayId = -1, int index = -1, int value = -1) {
    int getSize = xsArrayGetSize(arrayId);
    if(index < 0 || index > (getSize - 1) || getSize < 1) {
        return(false);
    }
    return(xsArraySetInt(arrayId, index, value));
}

bool rsIntArrayRemove(int arrayId = -1, int index = -1) {
    int getSize = xsArrayGetSize(arrayId);
    if(index < 0 || index > (getSize - 1) || getSize < 1) {
        return(false);
    }

    int newArray = xsArrayCreateInt(0);

    for(i = 0; < getSize) {
        if(i != index) {
            int getNewSize = xsArrayGetSize(newArray);
            xsArrayResizeInt(newArray, getNewSize + 1);
            xsArraySetInt(newArray, getNewSize, xsArrayGetInt(arrayId, i));
        }
    }
    xsArrayResizeInt(arrayId, xsArrayGetSize(newArray));
    for(i = 0; < xsArrayGetSize(newArray)) {
        xsArraySetInt(arrayId, i, xsArrayGetInt(newArray, i));
    }
    return(true);
}

int rsIntArrayGet(int arrayId = -1, int index = -1) {
    return(xsArrayGetInt(arrayId, index));
}

int rsIntArrayGetIndex(int arrayId = -1, int value = -1) {
    int returnValue = RS_FALSE;
    for(i = 0; < xsArrayGetSize(arrayId)) {
        int getValue = xsArrayGetInt(arrayId, i);
        if(getValue == value) {
            returnValue = i;
            break;
        }
    }
    return(returnValue);
}

int rsIntArrayShift(int arrayId = -1) {
    if(xsArrayGetSize(arrayId) > 0) {
        int value = rsIntArrayGet(arrayId, 0);
        if(rsIntArrayRemove(arrayId, 0)) {
            return(value);
        } else {
            return(RS_FALSE);
        }
    }
    return(RS_FALSE);
}

int rsIntArrayPop(int arrayId = -1) {
    int size = xsArrayGetSize(arrayId);
    if(size > 0) {
        int value = rsIntArrayGet(arrayId, size - 1);
        if(rsIntArrayRemove(arrayId, size - 1)) {
            return(value);
        } else {
            return(RS_FALSE);
        }
    }
    return(RS_FALSE);
}
//
//  Integer Array
//
int rsFloatArray(string values = "") {
    int array = xsArrayCreateFloat(0);

    if(values != "") {
        int items = strSplit(values, ",");
        int size = xsArrayGetSize(items);
        xsArrayResizeFloat(array, size);
        for(i = 0; < xsArrayGetSize(items)) {
            float item = strToFloat(strTrim(xsArrayGetString(items, i)), -1.0);
            xsArraySetFloat(array, i, item);
        }
    }

    return(array);
}

bool rsFloatArrayPush(int arrayId = -1, float value = -1.0) {
    int getSize = xsArrayGetSize(arrayId);
    xsArrayResizeFloat(arrayId, getSize + 1);
    return(xsArraySetFloat(arrayId, getSize, value));
}

bool rsFloatArrayEdit(int arrayId = -1, int index = -1, float value = -1.0) {
    int getSize = xsArrayGetSize(arrayId);
    if(index < 0 || index > (getSize - 1) || getSize < 1) {
        return(false);
    }
    return(xsArraySetFloat(arrayId, index, value));
}

bool rsFloatArrayRemove(int arrayId = -1, int index = -1) {
    int getSize = xsArrayGetSize(arrayId);
    if(index < 0 || index > (getSize - 1) || getSize < 1) {
        return(false);
    }

    int newArray = xsArrayCreateFloat(0);

    for(i = 0; < getSize) {
        if(i != index) {
            int getNewSize = xsArrayGetSize(newArray);
            xsArrayResizeFloat(newArray, getNewSize + 1);
            xsArraySetFloat(newArray, getNewSize, xsArrayGetFloat(arrayId, i));
        }
    }
    xsArrayResizeFloat(arrayId, xsArrayGetSize(newArray));
    for(i = 0; < xsArrayGetSize(newArray)) {
        xsArraySetFloat(arrayId, i, xsArrayGetFloat(newArray, i));
    }
    return(true);
}

float rsFloatArrayGet(int arrayId = -1, int index = -1) {
    return(xsArrayGetFloat(arrayId, index));
}

int rsFloatArrayGetIndex(int arrayId = -1, float value = -1.0) {
    int returnValue = RS_FALSE;
    for(i = 0; < xsArrayGetSize(arrayId)) {
        float getValue = xsArrayGetFloat(arrayId, i);
        if(getValue == value) {
            returnValue = i;
            break;
        }
    }
    return(returnValue);
}

int rsFloatArrayShift(int arrayId = -1) {
    if(xsArrayGetSize(arrayId) > 0) {
        float value = rsFloatArrayGet(arrayId, 0);
        if(rsFloatArrayRemove(arrayId, 0)) {
            return(value);
        } else {
            return(RS_FALSE);
        }
    }
    return(RS_FALSE);
}

int rsFloatArrayPop(int arrayId = -1) {
    int size = xsArrayGetSize(arrayId);
    if(size > 0) {
        float value = rsFloatArrayGet(arrayId, size - 1);
        if(rsFloatArrayRemove(arrayId, size - 1)) {
            return(value);
        } else {
            return(RS_FALSE);
        }
    }
    return(RS_FALSE);
}
int rsSetStringValue(string value = "") { return(xsArrayCreateString(1, value)); }
string rsGetStringValue(int value = -1) { if(xsArrayGetSize(value) == 1) { return(xsArrayGetString(value, 0)); } return(""); }

int rsSetIntValue(int value = -1) { return(xsArrayCreateInt(1, value)); }
int rsGetIntValue(int value = -1) { if(xsArrayGetSize(value) == 1) { return(xsArrayGetInt(value, 0)); } return(RS_FALSE); }

int rsSetFloatValue(float value = -1) { return(xsArrayCreateFloat(1, value)); }
float rsGetFloatValue(int value = -1) { if(xsArrayGetSize(value) == 1) { return(xsArrayGetFloat(value, 0)); } return(RS_FALSE); }

int rsCreateRecord(int key = -1, int value = -1) {
    int record = xsArrayCreateInt(2);
    xsArraySetInt(record, 0, key);
    xsArraySetInt(record, 1, value);
    return(record);
}

int rsGetRecordKey(int record = -1) {
    if(xsArrayGetSize(record) == 2) { return(xsArrayGetInt(record, 0)); }
    return(RS_FALSE);
}

int rsGetRecordValue(int record = -1) {
    if(xsArrayGetSize(record) == 2) { return(xsArrayGetInt(record, 1)); }
    return(RS_FALSE);
}
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
void rsTechNotification(int playerId = -1, string diplomacy = "", string message = "", string soundName = "") {
    if(___RS_UTIL_PLAYER_IN_RANGE___(playerId) == false) { return; }

    string senderName = xsGetPlayerName(playerId);
    string senderColor = xsGetPlayerColorTag(playerId);
    int diplomacies = xsArrayCreateInt(0);

    if(diplomacy == "ally") {
        xsArrayResizeInt(diplomacies, 1);
        xsArraySetInt(diplomacies, 0, cDiplomacyAlly);
    } else if(diplomacy == "unfriendly") {
        xsArrayResizeInt(diplomacies, 2);
        xsArraySetInt(diplomacies, 0, cDiplomacyNeutral);
        xsArraySetInt(diplomacies, 1, cDiplomacyEnemy);
    } else if(diplomacy == "enemy") {
        xsArrayResizeInt(diplomacies, 1);
        xsArraySetInt(diplomacies, 0, cDiplomacyEnemy);
    } else if(diplomacy == "neutral") {
        xsArrayResizeInt(diplomacies, 1);
        xsArraySetInt(diplomacies, 0, cDiplomacyNeutral);
    } else {
        xsArrayResizeInt(diplomacies, 3);
        xsArraySetInt(diplomacies, 0, cDiplomacyAlly);
        xsArraySetInt(diplomacies, 1, cDiplomacyNeutral);
        xsArraySetInt(diplomacies, 2, cDiplomacyEnemy);
    }

    for(player = 1; <= xsGetNumPlayers()) {
        if(playerId == player) { continue; }

        int getDiplomacy = xsGetDiplomacy(playerId, player);
        for(index = 0; < xsArrayGetSize(diplomacies)) {
            if(getDiplomacy == xsArrayGetInt(diplomacies, index)) {
                xsDisplayInstructions(fstr(message), 15, playerId, -1, cPanelTop, true, true, soundName, player);
                break;
            }
        }
    }
}

void rsChat(int targetPlayerId = -1, string message = "", string sound = "") {
    if(___RS_UTIL_PLAYER_IN_RANGE___(targetPlayerId) == false) { return; }
    bool silent = false;
    if(sound != "") {
        silent = true;
        xsPlaySound(sound, targetPlayerId, cInvalidVector, -1.0, -1, true);
    }
    xsSendChat(message, targetPlayerId, silent);
}
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
mutable void RsEventTimer(string eventName = "", string timerId = "", int expiresIn = 0, int params = -1) {}
mutable void RsEventTimerCreated(string timerId = "", int expiresIn = 0, int params = -1) {}
mutable void RsEventTimerExpired(string timerId = "", int expiresIn = 0, int params = -1) {}
mutable void RsEventTimerRemoved(string timerId = "", int expiresIn = 0, int params = -1) {}

string ___RS_API_TIMER_REMOVE_PREFIX___(string timerId = "") {
    if(timerId != "") {
        return(xsArrayGetString(strSplit(timerId, ":"), 1));
    }
    return("");
}

bool ___RS_API_TIMER_CREATE___(string timerName = "", int duration = 0, int params = -1, string prefix = "") {
    int getDb = ___RS_STORAGE_GET___(1);
    duration = duration * 1000;

    int currentTime = xsGetWorldTime();
    int createItem = rsIntArray();
        rsIntArrayPush(createItem, rsSetStringValue((prefix + ":" + timerName)));
        rsIntArrayPush(createItem, rsSetIntValue((currentTime + duration)));
        rsIntArrayPush(createItem, rsSetIntValue(params));
    rsIntArrayPush(getDb, createItem);
    RsEventTimer("created", timerName, (currentTime + duration), params);
    RsEventTimerCreated(timerName, (currentTime + duration), params);
    return(true);
}

void ___RS_API_TIMER_REMOVE___(string timerName = "", string prefix = "") {
    int getDb = ___RS_STORAGE_GET___(1);

    int dbSize = xsArrayGetSize(getDb);
    if(dbSize < 1)  { return; }

    for(index = 0; < dbSize) {
        int getItems = rsIntArrayGet(getDb, index);
        if(xsArrayGetSize(getItems) != 3) { continue; }

        string getKey = rsGetStringValue(rsIntArrayGet(getItems, 0));
        if(getKey == (prefix + ":" + timerName)) {
            int getExpires = rsGetIntValue(rsIntArrayGet(getItems, 1));
            int getParams = rsGetIntValue(rsIntArrayGet(getItems, 2));
            rsIntArrayRemove(getDb, index);
            RsEventTimer("removed", timerName, getExpires, getParams);
            RsEventTimerRemoved(timerName, getExpires, getParams);
        }
    }
}

void ___RS_API_TIMER_INSPECTOR___() {
    int getDb = ___RS_STORAGE_GET___(1);
    int dbSize = xsArrayGetSize(getDb);
    if(dbSize < 1) { return; }

    int currentTime = xsGetWorldTime();
    for(index = 0; < dbSize) {
        int getItems = rsIntArrayGet(getDb, index);
        if(xsArrayGetSize(getItems) != 3) { continue; }

        int getExpires = rsGetIntValue(rsIntArrayGet(getItems, 1));
        if(getExpires < currentTime) {
            int getParams = rsGetIntValue(rsIntArrayGet(getItems, 2));
            string getKey = ___RS_API_TIMER_REMOVE_PREFIX___(rsGetStringValue(rsIntArrayGet(getItems, 0)));
            rsIntArrayRemove(getDb, index);
            RsEventTimer("expired", getKey, getExpires, getParams);
            RsEventTimerExpired(getKey, getExpires, getParams);
        }
    }
}

string rsTimerCreate(string timerId = "", int duration = 1, int params = -1) {
    if(timerId == "") {
        timerId = "" + xsGetRandomNumber();
    } else {
        timerId = strReplace(timerId, ":", "_");
    }

    if(___RS_API_TIMER_CREATE___(timerId, duration, params, "TIMER")) {
        return(timerId);
    }
    return("");
}

bool rsTimerRemove(string timerId = "") {
    if(timerId == "") {
        return(false);
    } else {
        timerId = strReplace(timerId, ":", "_");
    }
    ___RS_API_TIMER_REMOVE___(timerId, "TIMER");
    return(true);
}
void rsKillUnits(int playerId = -1, int unitOrClassId = -1, int unitList = -1, bool except = false) {
    if(___RS_UTIL_PLAYER_IN_RANGE___(playerId) == false) { return; }

    int units = xsGetPlayerUnitIds(playerId, unitOrClassId);

    for(object = 0; < xsArrayGetSize(units)) {
        int unitId = xsArrayGetInt(units, object);
        if(unitList != -1 && xsArrayGetSize(unitList) > 0 && ___RS_UTIL_IS_UNIT_CLASS___(unitOrClassId)) {
            int inArray = rsIntArrayGetIndex(unitList, xsGetUnitObjectId(unitId));
                if(except && inArray != RS_FALSE) { xsSetUnitHitpoints(unitId, 0); }
                if(except == false && inArray == RS_FALSE) { xsSetUnitHitpoints(unitId, 0); }
        } else {
            xsSetUnitHitpoints(unitId, 0);
        }
    }
}

void rsInstantWorker(int playerId = -1, string type = "hunter", bool instant = true) {
    if(___RS_UTIL_PLAYER_IN_RANGE___(playerId) == false) { return; }

    type = strToLower(type);
    int objects = xsArrayCreateInt(2, 0);
    int combatValue = 0;

    if(instant) { combatValue = 1; }

    if(type == "hunter") {
        xsArraySetInt(objects, 0, 122);
        xsArraySetInt(objects, 1, 216);
    } else if(type == "gold miner") {
        xsArraySetInt(objects, 0, 579);
        xsArraySetInt(objects, 1, 581);
    } else if(type == "stone miner") {
        xsArraySetInt(objects, 0, 124);
        xsArraySetInt(objects, 1, 220);
    } else if(type == "miner") {
        xsArrayResizeInt(objects, 4);
        xsArraySetInt(objects, 0, 124);
        xsArraySetInt(objects, 1, 220);
        xsArraySetInt(objects, 2, 579);
        xsArraySetInt(objects, 3, 581);
    } else if(type == "shepherd") {
        xsArraySetInt(objects, 0, 590);
        xsArraySetInt(objects, 1, 592);
    } else if(type == "fisher") {
        xsArraySetInt(objects, 0, 56);
        xsArraySetInt(objects, 1, 57);
    } else if(type == "pearler") {
        xsArraySetInt(objects, 0, 2333);
        xsArraySetInt(objects, 1, 2334);
    }  else if(type == "forager") {
        xsArraySetInt(objects, 0, 120);
        xsArraySetInt(objects, 1, 354);
    } else {
        // Lumberjacks
        xsArraySetInt(objects, 0, 123);
        xsArraySetInt(objects, 1, 218);
    }

    for(index = 0; < xsArrayGetSize(objects)) {
        int objectId = xsArrayGetInt(objects, index);
        for(taskId = 0; < xsGetObjectTaskCount(objectId, playerId)) {
            xsObjectTaskAmount(objectId, playerId, taskId);
            int taskType = xsGetTaskAmount(cTaskAttrTaskType);

            if(taskType == cTaskTypeGatherRebuild || taskType == cTaskTypeHunt) {
                xsTaskAmount(cTaskAttrCombatLevelFlag, combatValue);
                xsModifyObjectTasks(objectId, playerId, taskId, true);
            }
        }
    }
}

void rsSetUnitName(int playerId = -1, int unitId = -1, string name = "") {
    if(___RS_UTIL_PLAYER_IN_RANGE___(playerId) == false || unitId == -1 || name == "") { return; }

    int units = xsGetPlayerUnitIds(playerId, unitId);
    for(i = 0; < xsArrayGetSize(units)) {
        int unit = xsArrayGetInt(units, i);
        xsSetUnitName(unit, name);
    }
}

void rsSetUnitHitpoints(int playerId = -1, int unitId = -1, float hp = 0.0) {
    if(___RS_UTIL_PLAYER_IN_RANGE___(playerId) == false || unitId == -1) { return; }

    int units = xsGetPlayerUnitIds(playerId, unitId);
    for(i = 0; < xsArrayGetSize(units)) {
        int unit = xsArrayGetInt(units, i);
        xsSetUnitHitpoints(unit, hp);
    }
}

void rsSpawnUnit(int playerId = -1, int spawnUnitId = 83, int targetUnit = 109, int count = 1, int spawnCap = 1) {
    if(___RS_UTIL_PLAYER_IN_RANGE___(playerId) == false) { return; }
    xsEffectAmount(cModResource, cAttributeSpawnCap, cAttributeSet, spawnCap, playerId);
    xsEffectAmount(cSpawnUnit, spawnUnitId, targetUnit, count, playerId);
}

void rsUnitAttackable(int playerId = -1, int unitOrClass = -1, bool attackable = true, bool targetable = true) {
    if(___RS_UTIL_PLAYER_IN_RANGE___(playerId) == false) { return; }

    int attack = cAttributeDisable;
    int target = cAttributeDisable;
    if(attackable) { attack = cAttributeEnable; }
    if(targetable) { target = cAttributeEnable; }

    int units = xsGetPlayerUnitIds(playerId, unitOrClass);
    for(i = 0; < xsArrayGetSize(units)) {
        int unit = xsArrayGetInt(units, i);
        xsSetUnitProperty(unit, cUnitAttackable, attack, true);
        xsSetUnitProperty(unit, cUnitTargetable, target, true);
    }
}
int delay = 100;
int tick = 0;

rule ___RS_RULE_EVENT_LISTENER___
    inactive
    group rsTechEvent
    highFrequency
    priority 1
{
    int time = xsGetWorldTime();
    if(tick < time) {
        tick = xsGetWorldTime() + delay;
        ___RS_API_TIMER_INSPECTOR___();
        ___RS_API_TECH_CHECKER_INSPECTOR___();
    }

}

mutable void RsReady() {}
mutable void RsPlayer(int playerId = -1, int civilization = -1, string currentAge = "") {}

void main() {
    rsTechCheckerSetAll(101);
    rsTechCheckerSetAll(102);
    rsTechCheckerSetAll(103);
    RsReady();

    for(playerId = 1; <= xsGetNumPlayers()) {
        RsPlayer(playerId, xsGetPlayerCivilization(playerId), ___RS_UTIL_GET_AGE___(playerId));
    }
    xsEnableRule("___RS_RULE_EVENT_LISTENER___");
}
