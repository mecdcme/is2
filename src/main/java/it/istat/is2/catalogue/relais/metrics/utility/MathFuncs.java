package it.istat.is2.catalogue.relais.metrics.utility;

final public class MathFuncs {

    public static float max3(final float x, final float y, final float z) {
        return Math.max(x, Math.max(y, z));
    }

    public static float max4(final float w, final float x, final float y, final float z) {
        return Math.max(Math.max(w, x), Math.max(y, z));
    }

    public static float min3(final float x, final float y, final float z) {
        return Math.min(x, Math.min(y, z));
    }

    public static int min3(final int x, final int y, final int z) {
        return Math.min(x, Math.min(y, z));
    }

    public static int max3(final int x, final int y, final int z) {
        return Math.max(x, Math.max(y, z));
    }
}
