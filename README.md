
# RS

If you find any bugs, please let me know!

## What is this?

This is just an XS Script library for Age Of Empires 2 that you can use in your own scenario! With this library, you need to use fewer triggers in the editor!

**Problems that cannot be solved:**

Currently, one critical task cannot be solved: changing the amount of a resource required by a technology, adding a new resource type, or overwriting an existing resource type using XS Script! Unfortunately, this has to be handled using triggers and effects! Here is an example that currently does not work:

```c
int tech = 1180; // Blank Technology 00
int targetPlayer = 1;

// Set the first required resource, food
xsEffectAmount(cModifyTech, tech, cAttrTypeFirstCost, cAttributeFood, targetPlayer);
// Set the amount of the first required resource, i.e. how much food is required
xsEffectAmount(cModifyTech, tech, cAttrAmountFirstCost, 50, targetPlayer);
// It must be configured to deduct the cost
xsEffectAmount(cModifyTech, tech, cAttrDeductFlagFirstCost, 1, targetPlayer);

```

The cost of the specified technology cannot be overwritten! Perhaps this bug will be fixed in the near future!

**Problems that cannot be solved in every case, or for which only a partial solution is possible:**

Currently, it is not possible to create a function or variable that can hold any type of value. Unfortunately, there is no such type as "any". Furthermore, it is not possible to specify an "unlimited" number of optional parameters, nor is there a dedicated "arguments" variable within functions or so-called "spread syntax" like in JavaScript.

# Sample main.xs file
You need only the "Rs.xs" file.
```c
include "Rs.xs";

// This code runs once when everything is ready. It works just like the main() function
void RsReady() {
    xsChatData("Script is ready");
    // Add Faith Technology to Technology Checker for all players
    rsTechCheckerSetAll(45);
    
}

// Or use this: This function also runs once per player when everything is ready. This is where civilization-specific codes can be placed. For example, a unique tech tree
RsPlayer(int playerId = -1, int civilization = -1, string currentAge = "") {
    xsChatData("Player " + playerId + " start in the " + currentAge + " Age");
    // playerId = the current player number (1-8)
    // civilization = returns the civilization ID
    // currentAge = returns the starting age: "Dark", "Feudal", "Castle", "Imperial" or "Post-Imperial"

    if(currentAge == "Post-Imperial") {
        // Execute when player is in Post-Imperial Age
    }

    if(civilization == cMagyars) {
        // Execute when player civilization are Hungarian
    }
}

void RsEventTechState(string eventName = "", int playerId = -1, int techId = -1, bool fromQueue = false) {
    if(eventName == "done" && techId == 45 && playerId == 1) {
        // executes when player 1 are researched Faith technology
    }
}
```

# Built-in APIs

## Timer API

You can create timers similar to those available in the Scenario Editor.

### Functions

**_string rsTimerCreate(string timerId, int duration, int params)_**

Creates a timer. Return value: The unique identifier of the timer.

*   timerId (required): The unique identifier of your timer. It cannot be the same as that of a timer that is currently active.
    
*   duration (required): The number of seconds until the timer expires.
    
*   params (optional): The value can be an integer or an array.
    

**_bool rsTimerRemove(string timerId)_**

Removes an active timer. Returns true if the timer was successfully removed.

*   timerId (required): The unique identifier of an existing timer.
    

### Event Functions

**_void RsEventTimer(string eventName, string timerId, int expiresIn, int params)_**

Runs in every case, whether a timer is created, removed, or expires.

*   eventName: The name of the event. Possible values: created, removed, expired
    
*   timerId: The identifier of the timer
    
*   expiresIn: The expiration timestamp
    
*   params: If present, the value is an integer or an array. The default value is -1
    

**_void RsEventTimerCreated(string timerId, int expiresIn, int params)_**

Runs when a timer has been created. The parameters are the same as those of RsEventTimer.

**_void RsEventTimerExpired(string timerId, int expiresIn, int params)_**

Runs when a timer expires. The parameters are the same as those of RsEventTimer.

**_void RsEventTimerRemoved(string timerId, int expiresIn, int params)_**

Runs when a timer is removed before its expiration time. The parameters are the same as those of RsEventTimer.

## Technology Checker API

You can add specified technologies to or remove them from the monitor for either all players or specific players.

### Functions

**_bool rsTechCheckerSetFor(int player, int technologyId)_**

Adds a technology to the monitor for the selected player. Returns true if successful.

*   playerId: The number of the desired player (1-8)
    
*   technologyId: The identifier of the technology you want to monitor. For example, using ID 45, you can monitor the state of the Faith technology.
    

**_void rsTechCheckerSetAll(int technologyId)_**

Adds a technology to the monitor for all players.

*   technologyId: The identifier of the technology you want to monitor. For example, using ID 45, you can monitor the state of the Faith technology.
    

**_bool rsTechCheckerRemoveFor(int player, int technologyId)_**

Removes the technology from the monitor for the specified player. Returns true if successful.

*   player: The number of the desired player (1-8)
    
*   technologyId: The identifier of the technology to remove
    

**_void rsTechCheckerRemoveAll(int technologyId)_**

Removes the technology from the monitor. Applies to all players!

*   technologyId: The identifier of the technology to remove
    

**_int rsTechCheckerGetFrom(int player, int technologyId)_**

Retrieves the stored state of the specified technology for the specified player. Returns an integer matching the technology state constant. ([tech state constant](https://ugc.aoe2.rocks/general/xs/constants/constants/#17-tech-state)). Returns RS\_FALSE if the technology does not exist.

*   player: The number of the desired player (1-8)
    
*   technologyId: The identifier of the technology whose state you want to retrieve
    

**_int rsTechCheckerGetAll(int technologyId)_**

Retrieves the state of the specified technology from all players. The return value is an array containing integers or RS\_FALSE values (ranging from 1 to 8 elements).

*   technologyId: The identifier of the technology whose state you want to retrieve
    

### Event Functions

**_void RsEventTechState(string eventName, int playerId, int techId, bool fromQueue)_**

Runs whenever the state of a technology changes.

*   eventName: The event. Possible values: notready, ready, queued, inprogress, completed, disabled
    
*   playerId: The identifier of the player whose state changed
    
*   techId: The identifier of the technology whose state changed
    
*   fromQueue: Whether the previous state was "queued", meaning it was waiting in the queue
    

**_void RsEventTechStateNotReady(int playerId, int techId, bool fromQueue)_**

Runs when a technology cannot be researched because a required technology is missing or it is not available in the current Age.

*   playerId: The identifier of the player whose state changed
    
*   techId: The identifier of the technology whose state changed
    
*   fromQueue: Whether the previous state was "queued", meaning it was waiting in the queue
    

**_void RsEventTechStateReady(int playerId, int techId, bool fromQueue)_**

Runs when a technology can be researched.

*   playerId: The identifier of the player whose state changed
    
*   techId: The identifier of the technology whose state changed
    
*   fromQueue: Whether the previous state was "queued", meaning it was waiting in the queue
    

**_void RsEventTechStateQueued(int playerId, int techId, bool fromQueue)_**

Runs when a technology is queued.

*   playerId: The identifier of the player whose state changed
    
*   techId: The identifier of the technology whose state changed
    
*   fromQueue: Whether the previous state was "queued", meaning it was waiting in the queue. In this case, it is always true.
    

**_void RsEventTechStateInProgress(int playerId, int techId, bool fromQueue)_**

Runs when a technology is being researched.

*   playerId: The identifier of the player whose state changed
    
*   techId: The identifier of the technology whose state changed
    
*   fromQueue: Whether the previous state was "queued", meaning it was waiting in the queue
    

**_void RsEventTechStateCompleted(int playerId, int techId, bool fromQueue)_**

Runs when a technology has been successfully researched.

*   playerId: The identifier of the player whose state changed
    
*   techId: The identifier of the technology whose state changed
    
*   fromQueue: Whether the previous state was "queued", meaning it was waiting in the queue
    

**_void RsEventTechStateDisabled(int playerId, int techId, bool fromQueue)_**

Runs when a technology has been disabled.

*   playerId: The identifier of the player whose state changed
    
*   techId: The identifier of the technology whose state changed
    
*   fromQueue: Whether the previous state was "queued", meaning it was waiting in the queue
    

### Age-specific Events

**_void RsFeudalAge(int playerId, int civilization)_**

Runs when the specified player successfully advances to the Feudal Age. This function only runs if the game did not start in the Feudal, Castle, or Imperial Age.

*   playerId: The identifier of the player
    
*   civilization: The identifier of the player's civilization. Matches the values of the [civilization constants](https://ugc.aoe2.rocks/general/xs/constants/constants/?h=cberber#5-aoe2-civs).
    

**_void RsCastleAge(int playerId, int civilization)_**

Runs when the specified player successfully advances to the Castle Age. This function only runs if the game did not start in the Castle or Imperial Age.

*   playerId: The identifier of the player
    
*   civilization: The identifier of the player's civilization. Matches the values of the [civilization constants](https://ugc.aoe2.rocks/general/xs/constants/constants/?h=cberber#5-aoe2-civs).
    

**_void RsImperialAge(int playerId, int civilization)_**

Runs when the specified player successfully advances to the Imperial Age. This function only runs if the game did not start in the Imperial Age.

*   playerId: The identifier of the player
    
*   civilization: The identifier of the player's civilization. Matches the values of the [civilization constants](https://ugc.aoe2.rocks/general/xs/constants/constants/?h=cberber#5-aoe2-civs).
    

# Other Functions

### Messages

**_void rsTechNotification(int playerId, string diplomacy, string message, string soundName)_**

Sends a notification to other players according to diplomacy.

*   playerId (required): The player who sends the notification
    
*   diplomacy (required): The players who will receive the notification. Possible values: ally, neutral, enemy, any
    
*   message (required): The text to send
    
*   soundName (optional): Custom notification sound
    

**_void rsChat(int targetPlayerId, string message, string sound)_**

Sends a chat message to the specified player.

*   targetPlayerId (required): The player to whom the message will be sent
    
*   message (required): The text of the message
    
*   sound (optional): Custom notification sound
    

### Units

**_void rsKillUnits(int playerId, int unitOrClassId, int unitList, bool except)_**

Kills the specified units on the map.

*   playerId (required): The identifier of the player whose units should be killed
    
*   unitOrClassId (required): Unit or class identifier
    
*   unitList (optional): The identifiers of units provided in an array that will either die or remain alive. This only works if the unitOrClassId parameter contains a class identifier
    
*   except (optional): If true, the units specified in the array will not be killed
    

**_void rsInstantWorker(int playerId, string type, bool instant)_**

Configures whether villagers need to drop off their resources! It works like the Khmer bonus.

*   playerId (required): The identifier of the player for whom it is activated
    
*   type (required): The worker group that does not need to drop off resources. Possible values: hunter, gold miner, stone miner, miner (gold and stone miners), shepherd, fisher, pearler, forager, hunter, lumber
    
*   instant (optional): Enables or disables the effect
    

**_void rsSetUnitName(int playerId, int unitId, string name)_**

Renames a unit located on the map.

*   playerId (required): The player whose unit will be renamed
    
*   unitId (required): The identifier of the unit
    
*   name (required): The new name of the unit
    

**_void rsSetUnitHitpoints(int playerId, int unitId, float hp)_**

Changes the hit points of a unit located on the map.

*   playerId (required): The player whose unit will be renamed
    
*   unitId (required): The identifier of the unit
    
*   hp (required): The new hit points of the unit
    

**_void rsSpawnUnit(int playerId, int spawnUnitId, int targetUnit, int count, int spawnCap)_**

Creates units at the specified building type. It works like the Sicilian "First Crusade" technology.

*   playerId (required): The player for whom the units will be created
    
*   spawnUnitId (required): The identifier of the unit to create
    
*   targetUnitId (required): The building type where the units will be created
    
*   count (required): The number of units to create
    
*   spawnCap (required): The maximum number of buildings at which units should be created
    

**_void rsUnitAttackable(int playerId, int unitOrClass, bool attackable, bool targetable)_**

Configures whether the specified unit or units belonging to the specified unit class can be attacked and targeted.

*   playerId (required): The identifier of the player to whom this should be applied
    
*   unitOrClassId (required): Unit or class identifier
    
*   attackable (required): Whether the unit can be attacked or not (true/false value)
    
*   targetable (optional): Whether the unit can be targeted or not (true/false value)
    

### Boolean Value

Because there is no "any" type, a Boolean value specifically for integers is required.

**_int RS\_FALSE_**

The "false" value represented as an integer. Value: -9999999

**_int RS\_TRUE_**

The "true" value represented as an integer. Value: 9999999
