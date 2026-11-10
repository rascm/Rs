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