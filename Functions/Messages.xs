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
