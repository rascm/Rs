int rsIntArray(string values = "") {
    int array = xsArrayCreateInt(0);

    if(values != "") {
        int items = strSplit(values, ",");
        int size = xsArrayGetSize(items);
        xsArrayResizeInt(array, size);
        for(i = 0; < xsArrayGetSize(items)) {
            int item = strToInt(strTrim(xsArrayGetString(items, i)), 10, -1);
            xsArraySetInt(array, i, item);
        }
    }

    return(array);
}

bool rsIntArrayPush(int arrayId = -1, int value = -1) {
    int getSize = xsArrayGetSize(arrayId);
    xsArrayResizeInt(arrayId, getSize + 1);
    return(xsArraySetInt(arrayId, getSize, value));
}

bool rsIntArrayEdit(int arrayId = -1, int index = -1, int value = -1) {
    int getSize = xsArrayGetSize(arrayId);
    if(index < 0 || index > (getSize - 1) || getSize < 1) {
        return(false);
    }
    return(xsArraySetInt(arrayId, index, value));
}

bool rsIntArrayRemove(int arrayId = -1, int index = -1) {
    int getSize = xsArrayGetSize(arrayId);
    if(index < 0 || index > (getSize - 1) || getSize < 1) {
        return(false);
    }

    int newArray = xsArrayCreateInt(0);

    for(i = 0; < getSize) {
        if(i != index) {
            int getNewSize = xsArrayGetSize(newArray);
            xsArrayResizeInt(newArray, getNewSize + 1);
            xsArraySetInt(newArray, getNewSize, xsArrayGetInt(arrayId, i));
        }
    }
    xsArrayResizeInt(arrayId, xsArrayGetSize(newArray));
    for(i = 0; < xsArrayGetSize(newArray)) {
        xsArraySetInt(arrayId, i, xsArrayGetInt(newArray, i));
    }
    return(true);
}

int rsIntArrayGet(int arrayId = -1, int index = -1) {
    return(xsArrayGetInt(arrayId, index));
}

int rsIntArrayGetIndex(int arrayId = -1, int value = -1) {
    int returnValue = RS_FALSE;
    for(i = 0; < xsArrayGetSize(arrayId)) {
        int getValue = xsArrayGetInt(arrayId, i);
        if(getValue == value) {
            returnValue = i;
            break;
        }
    }
    return(returnValue);
}

int rsIntArrayShift(int arrayId = -1) {
    if(xsArrayGetSize(arrayId) > 0) {
        int value = rsIntArrayGet(arrayId, 0);
        if(rsIntArrayRemove(arrayId, 0)) {
            return(value);
        } else {
            return(RS_FALSE);
        }
    }
    return(RS_FALSE);
}

int rsIntArrayPop(int arrayId = -1) {
    int size = xsArrayGetSize(arrayId);
    if(size > 0) {
        int value = rsIntArrayGet(arrayId, size - 1);
        if(rsIntArrayRemove(arrayId, size - 1)) {
            return(value);
        } else {
            return(RS_FALSE);
        }
    }
    return(RS_FALSE);
}