package it.istat.is2.catalogue.relais.metrics.added;

import java.io.Serializable;

import it.istat.is2.catalogue.relais.metrics.utility.AbstractStringMetric;

import java.io.*;
import java.util.*;
import it.istat.is2.catalogue.relais.simhash.Hash;

public final class  Simhash extends AbstractStringMetric implements Serializable{

    private static final long serialVersionUID = 1L;

    private final float ESTIMATEDTIMINGCONST = 1e-4f;

    //private final AbstractSubstitutionCost dCostFunc = new SubCost01();

 int soglia=45;
 int soglia2=35;
 int sogliagiro;
 int gradino=64;
 int hashdim=128;

 int grDim=3;
 boolean weights=false;
 HashMap wgrams;
 HashMap wgramsi;
 HashMap<String,String> map;
 
 public Simhash(){

        this.grDim=3;
        this.weights=false;
        wgrams = new HashMap();
        wgramsi = new HashMap();
        this.map = new HashMap<String,String>();
        
 }
 
 public String getShortDescriptionString() {
        return "SimHash";
    }

    public String getLongDescriptionString() {
        return "Similarity Hash decode using Hamming distance";
    }

    public String getSimilarityExplained(StringBuilder string1, StringBuilder string2) {
        return null;  
    }

    public float getSimilarityTimingEstimated(final StringBuilder string1, final StringBuilder string2) {
        final float str1Length = string1.length();
        final float str2Length = string2.length();
        return (str1Length * str2Length) * ESTIMATEDTIMINGCONST;
    }
    
    public void prepareMap(String stringIn) {
        
    }

    public float getSimilarity(final StringBuilder string1, final StringBuilder string2) {
        
        float HammSim = getUnNormalisedSimilarity(string1,string2);
        return (HammSim/(float) hashdim);
        
    }

    public float getUnNormalisedSimilarity(StringBuilder instring1, StringBuilder instring2) {
       int hamdist=0;
       String hashcode1;
       String hashcode2;
       String string1=instring1.toString();
       String string2=instring2.toString();
       
       try {
            if (map.containsKey(string1)) {
                hashcode1=(String) map.get(string1);
            } else {
                Hash h1=new Hash(grDim,wgrams,weights,2);
                hashcode1=h1.decodemd5(string1);
                map.put(string1, hashcode1);
            }
            if (map.containsKey(string2)) {
                hashcode2=(String) map.get(string2);
            } else {
                Hash h2=new Hash(grDim,wgrams,weights,2);
                hashcode2=h2.decodemd5(string2);
                map.put(string2, hashcode2);
            }
       
            hamdist=hashdist(hashcode1,hashcode2);
            return((float) (hashdim-hamdist));
            
       } catch (Exception ex) {
           System.out.println(ex.getMessage());
           hamdist=hashdim;
           return((float) 0);
       }

    }
 
    public static int hashdist(String hash1, String hash2) throws Exception {
    int dist=0;
    for (int ix=0;ix<hash1.length();ix++)
      if (hash1.charAt(ix)!=hash2.charAt(ix)) dist++;
      
    return dist;
 }
  
}