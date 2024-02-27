import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class ColourTableTest {
    @Test
    @DisplayName("Using a palette size that is too small")
    void testConstructorWithTooSmallPaletteSize() {
        Throwable exception = assertThrows(IllegalArgumentException.class, () -> new ColourTable(1));
        assertEquals("Invalid palette size, must be between 2 and 1024, and a power of two", exception.getMessage());
    }

    @Test
    @DisplayName("Using a palette size that is too large")
    void testConstructorWithTooLargePaletteSize() {
        Throwable exception = assertThrows(IllegalArgumentException.class, () -> new ColourTable(2048));
        assertEquals("Invalid palette size, must be between 2 and 1024, and a power of two", exception.getMessage());
    }

    @Test
    @DisplayName("Using a palette size that is not a power of two")
    void testConstructorWithNonPowerTwoPaletteSize() {
        Throwable exception = assertThrows(IllegalArgumentException.class, () -> new ColourTable(72));
        assertEquals("Invalid palette size, must be between 2 and 1024, and a power of two", exception.getMessage());
    }

    @Test
    @DisplayName("Using a value that does not fall in the [0, 255] range")
    void testIllegalColourValue() {
        ColourTable colourtable = new ColourTable(32);
        Throwable exception = assertThrows(IllegalArgumentException.class, () -> colourtable.add(17, 300, 29));
        assertEquals("Invalid colour value provided", exception.getMessage());
    }

    @Test
    @DisplayName("Ensuring colour count is handled correctly")
    void testColourCount() {
        ColourTable colourtable = new ColourTable(64);
        for (int i = 0; i < 20; i++) {
            colourtable.add(i, i, i);
        }
        for (int i = 10; i < 15; i++) {
            colourtable.add(i, i, i);
        }
        assertEquals(20, colourtable.countColours(), "Duplicate values should be handled correctly");
    }

    @Test
    @DisplayName("Verifying size limit of palette")
    void testPaletteSizeLimits() {
        ColourTable colourtable = new ColourTable(16);
        for (int i = 0; i < 16; i++) {
            colourtable.add(i, i, i);
        }
        Throwable exception = assertThrows(IllegalStateException.class, () -> colourtable.add(100, 100, 100));
        assertEquals("Palette cannot exceed size specified at creation", exception.getMessage());
    }

    @Test
    @DisplayName("Checking reformatHexString()")
    void testReformatHexString() {
        ColourTable colourtable = new ColourTable(16);
        colourtable.add("fff123");
        colourtable.add("fFf123");
        colourtable.add("#FFF123");
        colourtable.add("Fff124");
        assertEquals(2, colourtable.countColours(), "Strings should be equal upon reformatting");
    }

    @Test
    @DisplayName("Check valid hexadecimal string")
    void testValidHexString() {
        ColourTable colourtable = new ColourTable(16);
        Throwable exception = assertThrows(IllegalArgumentException.class, () -> colourtable.add("001G00"));
        assertEquals("Invalid colour value provided", exception.getMessage());
    }

    @Test
    @DisplayName("Check if values are mapped to the correct hexadecimal representations")
    void testHexConversion() {
        ColourTable colourtable = new ColourTable(16);
        colourtable.add(0, 0, 0);
        colourtable.add("FFFFFF");
        colourtable.add(48, 241, 100);
        colourtable.add("30F164");
        assertEquals(3, colourtable.countColours(), "Last two additions are equal, so they should only count for 1");
    }

    @Test
    @DisplayName("Removing a colour not present in the palette via RGB")
    void testRemoveIllegalRGB() {
        ColourTable colourtable = new ColourTable(16);
        colourtable.add("314159");
        Throwable exception = assertThrows(IllegalArgumentException.class, () -> colourtable.remove(14, 8, 22));
        assertEquals("Colour does not exist in palette", exception.getMessage());
    }

    @Test
    @DisplayName("Removing a colour not present in the palette via Hexadecimal String")
    void testRemoveIllegalHexString() {
        ColourTable colourtable = new ColourTable(16);
        colourtable.add(14, 8, 22);
        Throwable exception = assertThrows(IllegalArgumentException.class, () -> colourtable.remove("314159"));
        assertEquals("Colour does not exist in palette", exception.getMessage());
    }

    @Test
    @DisplayName("Verify colour count after removal of colours")
    void testCountAfterRemovals() {
        ColourTable colourtable = new ColourTable(128);
        for (int i = 0; i < 100; i++) {
            colourtable.add(i, i, i);
        }
        for (int i = 20; i < 70; i++) {
            colourtable.remove(i, i, i);
        }
        assertEquals(50, colourtable.countColours(), "50 colours should remain in the palette after the removals");
    }
}

//    Throwable exception = assertThrows(IllegalArgumentException.class, () -> );
//    assertEquals("", exception.getMessage());
