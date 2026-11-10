# Rs
If I did something wrong, please let me know!

# What is this?
This is an XS Script library that you can use in custom scenario! You need download the “Rs.xs” file, copy it into the your mod xs folder, and then load it into the file you're using in your own scenario! This library includes a technology status monitor, a timer, and other functions that simplify existing functions!

# A sample file
The code below is a main XS file for a scenario:

```
include "Rs.xs";

void RsReady() {
// The code here provides the same functionality as if you were using the main() function!
}

void RsPlayer(int playerId = -1, int civilization = -1, string currentAge = "") {
  // Place the codes that apply to a specific player! here This code runs only when the game starts a total of as many times as there are players!
}
```

# Timer API

**void RsEventTimer(string eventName, string timerId, int expiresIn, int params)**

This runs when you add a timer, when a timer expires, or when you remove a timer

- eventName: The name of the event. Possible values: created, reemoved, expired
- timerId: The name of the timer.
- params: This can be an integer or an array

### Events
**void RsEventTimerCreated(string timerId, int expiresIn, int params)**

It runs when a timer is created by a function. It returns the same parameters as ***RsEventTimer***


**void RsEventTimerExpired(string timerId, int expiresIn, int params)**

It runs when a timer is expired. It returns the same parameters as ***RsEventTimer***


**void RsEventTimerRemoved(string timerId, int expiresIn, int params)**

It runs when a timer is removed by a function. It returns the same parameters as ***RsEventTimer***

### Functions
**string rsTimerCreate(string timerId, int duration, int params)**

Creating a Timer. returns a specified unique timer id

- timerId (required): The timer unique ID.
- duration (required): expiration time specified in seconds
- params (optional): This can be an integer or an array


**bool rsTimerRemove(string timerId)**
Removing a timer before it expires

- timerId (required): The existing timer unique ID.

