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