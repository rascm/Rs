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
