package it.istat.is2.catalogue.relais.simhash;

import java.security.*;
import java.util.*;

public class Hash {
  private int gramDim;
  private int bitDim=8;
  public String inputString;
  String[] grams;
  int[] weigs;
  double[][] hashbit;
  public int rowDim=0;
  HashMap grWgs;
  boolean useWgs;
  int totrec;
  
 public Hash(int dim, HashMap grWgs, boolean useWgs,int totRec) {
    gramDim=dim; 
    inputString = " ";
    grams = new String[1];
    weigs = new int[1];
    hashbit = new double[1][1];
    this.grWgs=grWgs;
    this.useWgs=useWgs;
    this.totrec = totRec;
 }
 
 public static String[] getGrams(String input, int gramDim) {
     String normString = soloAlfanumerici(input.toUpperCase());
     String[] appo;
     
     if (normString.length()<gramDim) {
        appo =	new String[1];
        appo[0]=normString;
     }
     else {
         appo = new String[normString.length()+1-gramDim];
         for (int ix=0; ix<=normString.length()-gramDim; ix++) {
           appo[ix]=normString.substring(ix,ix+gramDim);
         }
     } 
     return (appo);
 }
 
 public void setString(String input) {
  
     String[] appo;
    appo = getGrams(input,gramDim);
    if (appo.length == 1) {
           grams = new String[1];
           grams[0] = appo[0];
           weigs = new int[1];
           weigs[0] = 1;
    } 
    else { 
	   Arrays.sort(appo);
	   grams = new String[appo.length];
	   weigs = new int[appo.length]; 
	   int w=1;
	   int curr=0;
	   for (int ix=0; ix<(appo.length-1); ix++) {
	       if (appo[ix].equals(appo[(ix+1)])) {
		       w++;
		   }
		   else {
		       grams[curr]=appo[ix];
			   weigs[curr]=w;
			   w=1;
			   curr++;
		   }
       }
	   grams[curr]=appo[(appo.length-1)];
	   weigs[curr]=w;
	   if (curr<(appo.length-1)) {
	      grams[curr+1]="";
		  weigs[curr+1]=0;
	   }
	   
    }
    
 }
 
 @SuppressWarnings("deprecation")
public void evalHashBit() {
   
   rowDim = gramDim*bitDim;
   hashbit = new double[grams.length][rowDim];
   double currCode;
   
   for (int gramx=0;(gramx<grams.length) && (weigs[gramx]>0);gramx++) {
      for (int charx=0;charx<gramDim;charx++) {
         currCode=(double)(new Character(grams[gramx].charAt(charx))).hashCode();
         for (int ix=0;ix<bitDim;ix++) {
             if (Math.pow(2d,(double)(bitDim-1-ix))>currCode) {
                hashbit[gramx][(charx*bitDim)+ix] = -1;
             } else {
                hashbit[gramx][(charx*bitDim)+ix] = weigs[gramx];
                currCode=currCode - (double) Math.pow(2d,(double)(bitDim-1-ix));
             }
            
         }
      }
      
   }
    
 }
 
 public void evalmd5HashBit() throws Exception {
 
   rowDim = bitDim*16;
   hashbit = new double [grams.length][rowDim];
   String appoex;
   double dw;
   
   MessageDigest m = MessageDigest.getInstance("MD5");
   
   for (int gramx=0;(gramx<grams.length) && (weigs[gramx]>0);gramx++) {
       byte[] digest = m.digest(grams[gramx].getBytes());
   
       if (!useWgs)
          dw = (double) weigs[gramx];
      else {
           if (grWgs.containsKey(grams[gramx]))
               dw = (1 + Math.log(weigs[gramx])) * Math.log((double)totrec/ Double.parseDouble(grWgs.get(grams[gramx]).toString()));
	   else {
		throw new Exception("weight for '"+grams[gramx]+"' gram not found");
	   }
      }
      for (int digx=0; digx<digest.length; digx++) {
	     // precedente formato "%1$#"+bitDim+"s" nuovo "%1$"+bitDim+"s" mod 11/10 
         appoex = String.format("%1$"+bitDim+"s",Integer.toBinaryString(digest[digx] < 0 ? 256+digest[digx] : digest[digx]));
         for (int ix=0; ix<bitDim; ix++) {
            if (appoex.charAt(ix)=='1') {
                hashbit[gramx][(digx*bitDim)+ix] = dw;
             } else {
                hashbit[gramx][(digx*bitDim)+ix] = -dw;
             }
         }
		
      }
   }
 }
 
 public String returnCode() {
   char[] code = new char[rowDim];
   double tot;
   for (int ix=0;ix<rowDim;ix++) {
      tot=0;
      for (int gramx=0;(gramx<grams.length) && (weigs[gramx]>0);gramx++) {
          tot+=hashbit[gramx][ix];
          /*TESTRELAIS if (ix==7) System.out.println(gramx+" : "+tot+" "+hashbit[gramx][ix]+" ");*/
      }
      if (tot>0) code[ix]='1';
      else code[ix]='0';
   }
   
   // riduci da 128 a 64 bit
   /*char[] code2 = new char[rowDim/2];
   for (int ix=0;ix<rowDim/2;ix++) {
      code2[ix]=code[2*ix];
   }*/
   
   return (new String(code));    
 }
 
 public static String soloAlfanumerici(String input)
 {
   StringBuffer sb = new StringBuffer();
   for(int i =0; i < input.length(); i++)
   {
      char current = input.charAt(i);
      if(Character.isLetterOrDigit(current))
      sb.append(current);
   }
   return sb.toString();
 }
 
 public String decode(String input) {
   setString(input);
   evalHashBit();
   return returnCode();
 }
 
 public String decodemd5(String input) throws Exception {
     /*TESTRELAIS System.out.print(input); */
   setString(input);
   evalmd5HashBit();
   /*TESTRELAIS System.out.print(" hash: "+returnCode()); */
   return returnCode();
 }
 
}
