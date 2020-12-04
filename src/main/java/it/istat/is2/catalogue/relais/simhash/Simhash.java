package it.istat.is2.catalogue.relais.simhash;

import java.util.Collection;
import java.util.HashMap;

public class Simhash {

	int soglia = 45;
	int soglia2 = 35;
	int sogliagiro;
	int gradino = 64;
	int hashdim = 128;
	int grDim = 2;
	boolean weights = false;
	HashMap<String, String> wgrams;
	HashMap<String, String> wgramsi;

	public Simhash(int thresh, int rounds, int grDim, boolean weigths) {
		this.gradino = (int) (hashdim / rounds);
		this.soglia = thresh;
		this.soglia2 = (int) (thresh * 0.75);
		this.grDim = grDim;
		this.weights = weigths;
		wgrams = new HashMap<String, String>();
		wgramsi = new HashMap<String, String>();
	}

	public static String invert(String s) {
		String temp = "";
		for (int i = s.length() - 1; i >= 0; i--)
			temp += s.charAt(i);
		return temp;
	}

	public class FileRec {
		int num;
		String value;

		public FileRec(int num, String value) throws Exception {
			this.num = num;
			this.value = value;
		}
	}

	public class HashRec {
		public int num;
		public int ds;
		public String hashcodeRec;
		public String hashinvert;
		public String value;
		public String invert;

		public HashRec(int ds, int num, String value, int hashdim, int totRec, boolean wgh) throws Exception {
			this.ds = ds;
			this.num = num;
			this.value = value;
			this.invert = invert(value);
			Hash h = new Hash(grDim, wgrams, wgh, totRec);
			Hash hi = new Hash(grDim, wgramsi, wgh, totRec);

			this.hashcodeRec = h.decodemd5(value);
			this.hashinvert = hi.decodemd5(invert);

		}

		public void progres(int nbit, int inv) {
			if (inv == 0)
				hashcodeRec = hashcodeRec.substring(nbit) + hashcodeRec.substring(0, nbit);
			else
				hashinvert = hashinvert.substring(nbit) + hashinvert.substring(0, nbit);
		}

		public String print() {
			return (hashcodeRec + " : " + value + " (" + ds + ":" + num + ")");
		}
	}

	public void addGrams(String strtograms, HashMap<String, String> map) {
		int numb;
		HashMap<String, String> gramString = new HashMap<String, String>();

		String[] appo = Hash.getGrams(strtograms, grDim);

		for (int idx = 0; idx < appo.length; idx++) {
			if (!gramString.containsKey(appo[idx])) {
				gramString.put(appo[idx], appo[idx]);
			}
		}

		Collection<?> grs = gramString.values();
		for (Object ngr : grs) {
			numb = 1;
			if (map.containsKey(ngr)) {
				numb = Integer.parseInt(map.get(ngr));
				numb++;
			}
			map.put((String) ngr, Integer.toString(numb));
		}
	}

	public static int hashdist(String hash1, String hash2) throws Exception {
		int dist = 0;
		for (int ix = 0; ix < hash1.length(); ix++)
			if (hash1.charAt(ix) != hash2.charAt(ix))
				dist++;

		return dist;
	}

	public static class SortHash implements java.util.Comparator {

		@Override
		public int compare(Object boy, Object girl) {
			String has1 = ((HashRec) boy).hashcodeRec;
			String has2 = ((HashRec) girl).hashcodeRec;

			return has1.compareTo(has2);

		}
	}

	public static class SortHashInvert implements java.util.Comparator {

		@Override
		public int compare(Object boy, Object girl) {
			String has1 = ((HashRec) boy).hashinvert;
			String has2 = ((HashRec) girl).hashinvert;

			return (has1.compareTo(has2));

		}
	}

	public static class SortValue implements java.util.Comparator {

		@Override
		public int compare(Object boy, Object girl) {
			String has1 = ((HashRec) boy).value;
			String has2 = ((HashRec) girl).value;

			return (has1.compareTo(has2));

		}
	}

	public static class SortInvert implements java.util.Comparator {

		@Override
		public int compare(Object boy, Object girl) {
			String has1 = ((HashRec) boy).invert;
			String has2 = ((HashRec) girl).invert;

			return (has1.compareTo(has2));

		}
	}

}
