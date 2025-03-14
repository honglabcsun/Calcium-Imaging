// Macro to extract frame numbers and timestamps from stack metadata
run("Clear Results");
frames = nSlices;

for (i = 1; i <= frames; i++) {
    setSlice(i);
    
    // Get the frame info from the image properties
    Stack.setPosition(1, i, 1);
    info = getInfo("image.subtitle");
    
    // Extract time value from the subtitle info
    // Expected format: "1/830 (0.13s)" or similar
    time = 0;
    if (indexOf(info, "(") > 0 && indexOf(info, "s)") > 0) {
        startIndex = indexOf(info, "(") + 1;
        endIndex = indexOf(info, "s)");
        timeStr = substring(info, startIndex, endIndex);
        time = parseFloat(timeStr);
    }
    
    setResult("Frame", i-1, i);
    setResult("Time (s)", i-1, time);
    updateResults();
}