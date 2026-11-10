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
