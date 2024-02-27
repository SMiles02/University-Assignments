import java.util.HashSet;

public class ColourTable {
    // Palette containing the colours already added to the ColourTable, represented as a HashSet of Strings
    private HashSet<String> palette;
    // The maximum number of colours in the palette upon creation, must conform to MAX_SIZE
    private int paletteSize;

    public ColourTable(int paletteSize) {
        // Ensures the criteria laid out in the assignment brief about the palette size is fulfilled
        if (!isPowerTwo(paletteSize) || paletteSize < 2 || 1024 < paletteSize) {
            throw new IllegalArgumentException("Invalid palette size, must be between 2 and 1024, and a power of two");
        }
        palette = new HashSet<>();
        this.paletteSize = paletteSize;
    }

    public void add(int redValue, int greenValue, int blueValue) {
        if (!isValidColourValue(redValue) || !isValidColourValue(greenValue) || !isValidColourValue(blueValue)) {
            throw new IllegalArgumentException("Invalid colour value provided");
        }
        String hexString = rgbToHexString(redValue, greenValue, blueValue);
        if (palette.contains(hexString)) { // Do nothing if our palette already contains the specified hexString
            return;
        }
        if (palette.size() == paletteSize) { // Adding an additional colour will exceed paletteSize
            throw new IllegalStateException("Palette cannot exceed size specified at creation");
        }
        palette.add(hexString); // Adding the colour to our palette
    }

    public void add(String hexString) {
        // Standardises the given hexadecimal String
        hexString = reformatHexString(hexString);
        if (!isValidHexColour(hexString)) { // Throw error in case of invalid String being given
            throw new IllegalArgumentException("Invalid colour value provided");
        }
        if (palette.contains(hexString)) { // Do nothing if our palette already contains the specified hexString
            return;
        }
        if (palette.size() == paletteSize) { // Adding an additional colour will exceed paletteSize
            throw new IllegalStateException("Palette cannot exceed size specified at creation");
        }
        palette.add(hexString); // Adding the colour to our palette
    }

    public void remove(int redValue, int greenValue, int blueValue) {
        if (!isValidColourValue(redValue) || !isValidColourValue(greenValue) || !isValidColourValue(blueValue)) {
            throw new IllegalArgumentException("Invalid colour value provided");
        }
        String hexString = rgbToHexString(redValue, greenValue, blueValue);
        if (!palette.contains(hexString)) { // Throw error if colour not present
            throw new IllegalArgumentException("Colour does not exist in palette");
        }
        palette.remove(hexString); // Removing the colour from our palette
    }

    public void remove(String hexString) {
        // Standardises the given hexadecimal String
        hexString = reformatHexString(hexString);
        if (!isValidHexColour(hexString)) { // Throw error in case of invalid String being given
            throw new IllegalArgumentException("Invalid colour value provided");
        }
        if (!palette.contains(hexString)) { // Throw error if colour not present
            throw new IllegalArgumentException("Colour does not exist in palette");
        }
        palette.remove(hexString); // Removing the colour from our palette
    }

    // Returns the number of colours added to the palette so far
    public int countColours() {
        return palette.size();
    }

    // Checks if the given number is a power of two using bitwise operators
    private boolean isPowerTwo(int number) {
        return (number > 0) && ((number & (number - 1)) == 0);
    }

    // Checks whether the given colour value is in the range [0, 255]
    private boolean isValidColourValue(int value) {
        return (0 <= value) && (value < 256);
    }

    // Returns the hexadecimal String corresponding with the RGB values given
    private String rgbToHexString(int r, int g, int b) {
        // https://www.w3schools.blog/rgb-to-hex-java
        return String.format("%02X%02X%02X", r, g, b);
    }

    // Allows the user more freedom in stylising
    // For example, the Strings "fff123", "fFf123", and "#FFF123" are considered equal as they represent the same colour
    private String reformatHexString(String hexString) {
        hexString = hexString.toUpperCase();
        if (hexString.length() == 7 && hexString.charAt(0) == '#') {
            return hexString.substring(1);
        }
        return hexString;
    }

    // Checks whether the given String is a valid hexadecimal colour
    private boolean isValidHexColour(String hexString) {
        return (hexString.length() == 6) && (hexString.chars().allMatch(c -> "0123456789ABCDEF".indexOf(c) >= 0));
    }
}