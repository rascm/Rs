[English version]([https://www.conveythis.com/website-translator?url=https%3A%2F%2Fgithub.com%2Frascm%2FRs%2Ftree%2Fmain%3Ftab%3Dreadme-ov-file&to=en](https://www.conveythis.com/website-translator?url=https%3A%2F%2Fgithub.com%2Frascm%2FRs%2Fblob%2Fmain%2FREADME.md&to=en))

# RS

Ha valami hibát találsz, kérlek jelezd ezt nekem!

## Mi ez?

Ez csak egy XS Script könyvtár Age Of Empires 2 játékhoz amit a saját scenariodban használhatsz! A könyvtár segítségével kevesebb kapcsolót kell használnod a szerkesztőben!

**Problémák amiket nem lehet megoldani:**

Jelenleg egy kritikus feladatot nem lehet megoldani, mégpedig technológiák esetében erőforrás mennyiséget változtatni vagy új erőforrástípust hozzáadni, jelenlegit felülírni XS Scripttel! Ezt sajnos kapcsolókkal és effektekkel kell megoldani! Íme egy példa ami jelenleg nem működik:

```javascript
int tech = 1180; // Blank Technology 00
int targetPlayer = 1;

// Az első szükséges erőforrás, az étel beállítása
xsEffectAmount(cModifyTech, tech, cAttrTypeFirstCost, cAttributeFood, targetPlayer);
// Az első szükséges erőforrás értéke, azaz mennyi élelem szükséges
xsEffectAmount(cModifyTech, tech, cAttrAmountFirstCost, 50, targetPlayer);
// Be kell állítani hogy levonja a költséget
xsEffectAmount(cModifyTech, tech, cAttrDeductFlagFirstCost, 1, targetPlayer);

```

Nem lehet felülírni az adott technológia árát! Talán a közeljövőben kijavítják ezt a hibát!

**Problémák amit nem lehet minden esetben megoldani vagy csak részmegoldás lehetséges:**

Jelenleg nem lehet olyan funkciót, sem változót létrehozni aminek bármilyen értéke lehet. Sajnos nem létezik olyan hogy "any". Továbbá nem lehet "korlátlan" számú opcionális paramétereket megadni, nem létezik funkción belül egy dedikált "arguments" változó sem az úgynevezett "spread syntax" mint javascriptben.

# Beépített API-k

## Timer API

Létre tudsz hozni időzítőket, olyat mint ami a scenario editorban rendelkezésre áll.

### Funkciók

**_string rsTimerCreate(string timerId, int duration, int params)_**

Időzítő létrehozása. Visszatérő érték: Az időzítő egyedi azonosítója.

*   timerId (kötelező): Az időzítőd egyedi azonosítója. Nem egyezhet egy folyamatban lévő időzítőével
    
*   duration (kötelező): Hány másodperc múlva járjon le az időzítő.
    
*   params (opcionális): Egész szám vagy tömb lehet értékként
    

**_bool rsTimerRemove(string timerId)_**

Folyamatban lévő időzítő eltávolítása. Igaz értéket ad vissza ha sikerült az eltávolítás.

*   timerId (kötelező): A már létező időzítő egyedi azonosítója.
    

### Esemény funkciók

**_void RsEventTimer(string eventName, string timerId, int expiresIn, int params)_**

Minden esetben lefut, legyen az létrehozás, törlés, vagy ha egy időzítő lejárt.

*   eventName: Esemény neve. Lehetséges értékek: created, removed, expired
    
*   timerId: Az időzítő azonosítója
    
*   expiresIn: A lejárati időbélyeg
    
*   params: Ha van, egész szám vagy tömb az érték. Alapértelmezetten -1
    

**_void RsEventTimerCreated(string timerId, int expiresIn, int params)_**

Akkor fut le ha egy időzítő létre lett hozva. A paraméterek megegyeznek a RsEventTimer paramétereivel.

**_void RsEventTimerExpired(string timerId, int expiresIn, int params)_**

Akkor fut le ha egy időzítő lejárt. A paraméterek megegyeznek a RsEventTimer paramétereivel.

**_void RsEventTimerRemoved(string timerId, int expiresIn, int params)_**

Akkor fut le ha egy időzítő a lejárati ideje előtt el lett távolítva. A paraméterek megegyeznek a RsEventTimer paramétereivel.

## Technology Checker API

A megadott technológiákat hozzáadhatsz vagy eltávolíthatsz a figyelőhöz akár az összes vagy megadott játékosok számára.

### Funkciók

**_bool rsTechCheckerSetFor(int player, int technologyId)_**

A figyelőhöz hozzáad egy technológát a kiválasztott játékos számára. Igaz értéket ad vissza ha sikerült.

*   playerId: A kívánt játékos sorszáma (1-8)
    
*   technologyId: A figyelni kívánt technológia azonosítója. Például a 45-ös azonosítóval a Hit technológia állapotát figyelheted
    

**_void rsTechCheckerSetFor(int player, int technologyId)_**

A figyelőhöz hozzáad egy technológát az összes játékos számára.

*   technologyId: A figyelni kívánt technológia azonosítója. Például a 45-ös azonosítóval a Hit technológia állapotát figyelheted
    

**_bool rsTechCheckerRemoveFor(int player, int technologyId)_**

Eltávolítja a figyelőből a technológiát a megadott játékos esetében. Igaz értéket ad vissza ha sikerült.

*   player: A kívánt játékos sorszáma (1-8)
    
*   technologyId: Az eltávolítandó technológia azonosítója
    

**_void rsTechCheckerRemoveAll(int technologyId)_**

Eltávolítja a technológiát a figyelőből. Az összes játékosra érvényes!

*   technologyId: Az eltávolítandó technológia azonosítója
    

**_int rsTechCheckerGetFrom(int player, int technologyId)_**

Lekéri a megadott technológia tárolt állapotát a megadott játékos szerint. Egész számot ad vissza, megegyezik a technológia állapot konstansával. ([tech state konstans](https://ugc.aoe2.rocks/general/xs/constants/constants/#17-tech-state)). nem létező technológia esetében RS\_FALSE

*   player: A kívánt játékos sorszáma (1-8)
    
*   technologyId: A technológia azonosítója aminek az állapotát le szeretnéd kérni
    

**_int rsTechCheckerGetAll(int technologyId)_**

Lekéri a megadott technológia állapotát az összes felhasználótól. Visszatérési értéke egész számokat vagy RS\_FALSE értéket tartalmazó tömb (1-8 darabig terjedő).

*   technologyId: A technológia azonosítója aminek az állapotát le szeretnéd kérni
    

### Esemény funkciók

**_void RsEventTechState(string eventName, int playerId, int techId, bool fromQueue)_**

Minden esetben lefut ha technológia állapot változás történik.

*   eventName: Az esemén. Lehetséges értékek: notready, ready, queued, inprogress, completed, disabled
    
*   playerId: A játékos azonosítója akinél változott az állapot
    
*   techId: A technológia azonosítója amelynek megváltozott az állapota
    
*   fromQueue: Ha a korábbi állapot "queued" azaz várakozott a sorban
    

**_void RsEventTechStateNotReady(int playerId, int techId, bool fromQueue)_**

Akkor fut le ha egy technológia nem kutatható mert egy szükséges technológia hiányzik vagy nem elérhető az adott korban.

*   playerId: A játékos azonosítója akinél változott az állapot
    
*   techId: A technológia azonosítója amelynek megváltozott az állapota
    
*   fromQueue: Ha a korábbi állapot "queued" azaz várakozott a sorban
    

**_void RsEventTechStateReady(int playerId, int techId, bool fromQueue)_**

Akkor fut le ha egy technológia kutatható.

*   playerId: A játékos azonosítója akinél változott az állapot
    
*   techId: A technológia azonosítója amelynek megváltozott az állapota
    
*   fromQueue: Ha a korábbi állapot "queued" azaz várakozott a sorban
    

**_void RsEventTechStateQueued(int playerId, int techId, bool fromQueue)_**

Akkor fut le ha egy technológia sorban áll.

*   playerId: A játékos azonosítója akinél változott az állapot
    
*   techId: A technológia azonosítója amelynek megváltozott az állapota
    
*   fromQueue: Ha a korábbi állapot "queued" azaz várakozott a sorban. Jelen esetben mindig igaz
    

**_void RsEventTechStateInProgress(int playerId, int techId, bool fromQueue)_**

Akkor fut le ha egy technológia kutatás alatt van.

*   playerId: A játékos azonosítója akinél változott az állapot
    
*   techId: A technológia azonosítója amelynek megváltozott az állapota
    
*   fromQueue: Ha a korábbi állapot "queued" azaz várakozott a sorban
    

**_void RsEventTechStateCompleted(int playerId, int techId, bool fromQueue)_**

Akkor fut le ha egy technológia sikeresen kutatva lett.

*   playerId: A játékos azonosítója akinél változott az állapot
    
*   techId: A technológia azonosítója amelynek megváltozott az állapota
    
*   fromQueue: Ha a korábbi állapot "queued" azaz várakozott a sorban
    

**_void RsEventTechStateDisabled(int playerId, int techId, bool fromQueue)_**

Akkor fut le ha egy technológia le lett tiltva.

*   playerId: A játékos azonosítója akinél változott az állapot
    
*   techId: A technológia azonosítója amelynek megváltozott az állapota
    
*   fromQueue: Ha a korábbi állapot "queued" azaz várakozott a sorban
    

### Korok szerinti események

**_void RsFeudalAge(int playerId, int civilization)_**

Akkor fut le ha az adott játékos sikeresen belépett a feudális korba. Ez a függvény csak akkor fut le ha nem a Feudális, Kastély és Birodalmi kortól indult a játék.

*   playerId: A játékos azonosítója
    
*   civilization: A játékos civilizációjának azonosítója. Megegyezik a [civilizáció konstans](https://ugc.aoe2.rocks/general/xs/constants/constants/?h=cberber#5-aoe2-civs) értékeivel.
    

**_void RsCastleAge(int playerId, int civilization)_**

Akkor fut le ha az adott játékos sikeresen belépett a kastély korba. Ez a függvény csak akkor fut le ha nem a Kastély vagy Birodalmi kortól indult a játék.

*   playerId: A játékos azonosítója
    
*   civilization: A játékos civilizációjának azonosítója. Megegyezik a [civilizáció konstans](https://ugc.aoe2.rocks/general/xs/constants/constants/?h=cberber#5-aoe2-civs) értékeivel.
    

**_void RsImperialAge(int playerId, int civilization)_**

Akkor fut le ha az adott játékos sikeresen belépett a Birodalmi korba. Ez a függvény csak akkor fut le ha nem a Birodalmi kortól indult a játék.

*   playerId: A játékos azonosítója
    
*   civilization: A játékos civilizációjának azonosítója. Megegyezik a [civilizáció konstans](https://ugc.aoe2.rocks/general/xs/constants/constants/?h=cberber#5-aoe2-civs) értékeivel.
    

# Egyéb funkciók

### Üzenetek

**_void rsTechNotification(int playerId, string diplomacy, string message, string soundName)_**

Értesítés küldése a többi játékos számára diplomácia szerint.

*   playerId (kötelező): A játékos aki küldi az értesítést
    
*   diplomacy (kötelező): Akik értesítést kapnak. lehetséges értékek: ally, neutral, enemy, any
    
*   message (kötelező): Az elküldeni kívánt szöveg
    
*   soundName (opcionális): Egyedi értesítési hang
    

**_void rsChat(int targetPlayerId, string message, string sound)_**

Chat üzenet küldése a megadott játékosnak.

*   targetPlayerId (kötelező): A játékos akinek el lesz küldve az üzenet
    
*   message (kötelező): Az üzenet szövege
    
*   sound (opcionális): Egyedi értesítési hang
    

### Egységek

**_void rsKillUnits(int playerId, int unitOrClassId, int unitList, bool except)_**

Megöli a megadott egységeket a térképen.

*   playerId (kötelező): A játékos azonosítója akinek az egységeit meg kell ölni
    
*   unitOrClassId (kötelező): Egység vagy osztály azonosító
    
*   unitList (opcionális): Egségek azonosítója tömbben megadva akik meghalnak vagy életben maradnak. Csak akkor működik ha az unitOrClassId paraméter osztályazonosítót tartalmaz
    
*   except (opcionális): Ha igaz, a tömbben megadott egységeket nem öli meg
    

**_void rsInstantWorker(int playerId, string type, bool instant)_**

Beállítható hogy a falusiaknak szükséges-e az erőforrást leadniuk! Úgy működik mint a Khmer bónusz.

*   playerId (kötelező): A játékos azonosítója akinél aktiválódik
    
*   type (kötelező): Azon munkáscsoport akiknek nem kell leadni az erőforrást. Lehetséges értékek: hunter, gold miner, stone miner, miner (arany és kőbányászok), shepherd, fisher, pearlel, forager, hunter, lumber
    
*   instant (opcionális): Ki és be lehet kapcsolni az effektet
    

**_void rsSetUnitName(int playerId, int unitId, string name)_**

A térképen található egységet lehet átnevezni.

*   playerId (kötelező): Játékos akinek az egsysége át lesz nevezve
    
*   unitId (kötelező): Az egység azonosítója
    
*   name (kötelező): Az egység új neve
    

**_void rsSetUnitHitpoints(int playerId, int unitId, float hp)_**

A térképen található egység életerejét lehet megváltoztatni

*   playerId (kötelező): Játékos akinek az egsysége át lesz nevezve
    
*   unitId (kötelező): Az egység azonosítója
    
*   hp (kötelező): Az egység új életereje
    

**_void rsSpawnUnit(int playerId, int spawnUnitId, int targetUnit, int count, int spawnCap)_**

Egységeket lehet létrehozni a megadott épülettípusnál. Úgy működik mint a Szicíliai "First Crusade" technológia.

*   playerId (kötelező): Játékos akinek létrejönnek az egységek
    
*   spawnUnitId (kötelező): A létrehozandó egyég azonosítója
    
*   targetUnitId (kötelező): Épülettípus ahol létrejönnke az egységek
    
*   count (kötelező): Hány darab egység jöjjön létre
    
*   spawnCap (kötelező): Maximum hány darab épület mellett jöjjenek létre az egységek
    

**_void rsUnitAttackable(int playerId, int unitOrClass, bool attackable, bool targetable)_**

Beállítható hogy a megadott egység vagy egységosztályba tartozó egységek támadhatóak illetve célozhatóak legyenek-e

*   playerId (kötelező): Játékos azonosítója akinél alkalmazandó
    
*   unitOrClassId (kötelező): Egység vagy osztály azonosító
    
*   attackable (kötelező): Támadható-e az egység vagy nem (igaz/Hamis érték)
    
*   targetable (opcionális): célozható vagy sem (igaz/hamis érték)
    

### Logikai érték

Mivel nem létezik "any" érték, így szükséges kifejezetten egész számok esetében létrehozni logikai értéket.

**_int RS\_FALSE_**

A "false" érték egész számmal reprezentálva. Értéke: -9999999

**_int RS\_TRUE_**

A "true" érték egész számmal reprezentálva. Értéke: 9999999
