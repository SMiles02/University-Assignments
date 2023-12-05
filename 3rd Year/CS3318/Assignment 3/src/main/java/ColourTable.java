import java.util.ArrayList;

public class ColourTable {
    private ArrayList<String> palette;
    private final int MAX_SiZE = 1024;
    private int paletteSize;

    public ColourTable(int paletteSize) {
        if (!isPowerTwo(paletteSize) || paletteSize < 2 || paletteSize > MAX_SiZE) {
            throw new IllegalArgumentException("Invalid palette size, must be between 2 and " + MAX_SiZE);
        }
        palette = new ArrayList<>();
        this.paletteSize = paletteSize;
    }

    private boolean isPowerTwo(int number) {
        return (number > 0) && ((number & (number - 1)) == 0);
    }
}
