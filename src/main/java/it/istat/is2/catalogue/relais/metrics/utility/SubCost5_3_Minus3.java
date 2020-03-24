package it.istat.is2.catalogue.relais.metrics.utility;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

@SuppressWarnings("unchecked")
public final class SubCost5_3_Minus3 extends AbstractSubstitutionCost implements Serializable {

	private static final long serialVersionUID = 1L;

    private static final int CHAR_EXACT_MATCH_SCORE = +5;

    private static final int CHAR_APPROX_MATCH_SCORE = +3;

    private static final int CHAR_MISMATCH_MATCH_SCORE = -3;

    static private final Set<Character>[] approx;

    static {
        approx = new Set[7] ;
        approx[0] = new HashSet<Character>();
        approx[0].add('d');
        approx[0].add('t');
        approx[1] = new HashSet<Character>();
        approx[1].add('g');
        approx[1].add('j');
        approx[2] = new HashSet<Character>();
        approx[2].add('l');
        approx[2].add('r');
        approx[3] = new HashSet<Character>();
        approx[3].add('m');
        approx[3].add('n');
        approx[4] = new HashSet<Character>();
        approx[4].add('b');
        approx[4].add('p');
        approx[4].add('v');
        approx[5] = new HashSet<Character>();
        approx[5].add('a');
        approx[5].add('e');
        approx[5].add('i');
        approx[5].add('o');
        approx[5].add('u');
        approx[6] = new HashSet<Character>();
        approx[6].add(',');
        approx[6].add('.');
    }

    public final String getShortDescriptionString() {
        return "SubCost5_3_Minus3";
    }

    public final float getCost(final String str1, final int string1Index, final String str2, final int string2Index) {
        if (str1.length() <= string1Index || string1Index < 0) {
            return CHAR_MISMATCH_MATCH_SCORE;
        }
        if (str2.length() <= string2Index || string2Index < 0) {
            return CHAR_MISMATCH_MATCH_SCORE;
        }

        if (str1.charAt(string1Index) == str2.charAt(string2Index)) {
            return CHAR_EXACT_MATCH_SCORE;
        } else {
            final Character si = Character.toLowerCase(str1.charAt(string1Index));
            final Character ti = Character.toLowerCase(str2.charAt(string2Index));
            for (Set<Character> aApprox : approx) {
                if (aApprox.contains(si) && aApprox.contains(ti))
                    return CHAR_APPROX_MATCH_SCORE;
            }
            return CHAR_MISMATCH_MATCH_SCORE;
        }
    }

    public final float getMaxCost() {
        return CHAR_EXACT_MATCH_SCORE;
    }

    public final float getMinCost() {
        return CHAR_MISMATCH_MATCH_SCORE;
    }
}


