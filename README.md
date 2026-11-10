# Rs
If I did something wrong, please let me know!

# What is this?
This is an XS Script library that you can use in custom scenario! You need download the “Rs.xs” file, copy it into the your mod xs folder, and then load it into the file you're using in your own scenario! This library includes a technology status monitor, a timer, and other functions that simplify existing functions!

# A sample file
The file below is a main XS file for a scenario:

```
include "Rs.xs";

void RsReady() {
// The code here provides the same functionality as if you were using the main() function!
}

void RsPlayer(int playerId = -1, int civilization = -1, string currentAge = "") {
  // Place the codes that apply to a specific player! here This code runs only when the game starts a total of as many times as there are players!
}
```
