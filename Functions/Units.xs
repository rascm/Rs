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