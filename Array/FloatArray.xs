//
//  Integer Array
//
int rsFloatArray(string values = "") {
    int array = xsArrayCreateFloat(0);

    if(values != "") {
        int items = strSplit(values, ",");
        int size = xsArrayGetSize(items);
        xsArrayResizeFloat(array, size);
        for(i = 0; < xsArrayGetSize(items)) {
            float item = strToFloat(strTrim(xsArrayGetString(items, i)), -1.0);
            xsArraySetFloat(array, i, item);
        }
    }

    return(array);
}

bool rsFloatArrayPush(int arrayId = -1, float value = -1.0) {
    int getSize = xsArrayGetSize(arrayId);
    xsArrayResizeFloat(arrayId, getSize + 1);
    return(xsArraySetFloat(arrayId, getSize, value));
}

bool rsFloatArrayEdit(int arrayId = -1, int index = -1, float value = -1.0) {
    int getSize = xsArrayGetSize(arrayId);
    if(index < 0 || index > (getSize - 1) || getSize < 1) {
        return(false);
    }
    return(xsArraySetFloat(arrayId, index, value));
}

bool rsFloatArrayRemove(int arrayId = -1, int index = -1) {
    int getSize = xsArrayGetSize(arrayId);
    if(index < 0 || index > (getSize - 1) || getSize < 1) {
        return(false);
    }

    int newArray = xsArrayCreateFloat(0);

    for(i = 0; < getSize) {
        if(i != index) {
            int getNewSize = xsArrayGetSize(newArray);
            xsArrayResizeFloat(newArray, getNewSize + 1);
            xsArraySetFloat(newArray, getNewSize, xsArrayGetFloat(arrayId, i));
        }
    }
    xsArrayResizeFloat(arrayId, xsArrayGetSize(newArray));
    for(i = 0; < xsArrayGetSize(newArray)) {
        xsArraySetFloat(arrayId, i, xsArrayGetFloat(newArray, i));
    }
    return(true);
}

float rsFloatArrayGet(int arrayId = -1, int index = -1) {
    return(xsArrayGetFloat(arrayId, index));
}

int rsFloatArrayGetIndex(int arrayId = -1, float value = -1.0) {
    int returnValue = RS_FALSE;
    for(i = 0; < xsArrayGetSize(arrayId)) {
        float getValue = xsArrayGetFloat(arrayId, i);
        if(getValue == value) {
            returnValue = i;
            break;
        }
    }
    return(returnValue);
}

int rsFloatArrayShift(int arrayId = -1) {
    if(xsArrayGetSize(arrayId) > 0) {
        float value = rsFloatArrayGet(arrayId, 0);
        if(rsFloatArrayRemove(arrayId, 0)) {
            return(value);
        } else {
            return(RS_FALSE);
        }
    }
    return(RS_FALSE);
}

int rsFloatArrayPop(int arrayId = -1) {
    int size = xsArrayGetSize(arrayId);
    if(size > 0) {
        float value = rsFloatArrayGet(arrayId, size - 1);
        if(rsFloatArrayRemove(arrayId, size - 1)) {
            return(value);
        } else {
            return(RS_FALSE);
        }
    }
    return(RS_FALSE);
}
