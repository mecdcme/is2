package it.istat.is2.catalogue.relais.decision.contingencyTable;
/*PatternFreq is a data structure containing a comparison pattern 
 and the corresponding frequency computed for all the pairs of the search space*/

public class PatternFreq {
private int freq;
private String pattern;

/*Constructor*/
public PatternFreq(){
}

/*Constructor that takes in input a 
 *specified pattern*/
public PatternFreq(String pattern){
	this.pattern=pattern;
	this.freq=0;
}

/*Sets a specified frequency*/
public void setFreq(int freq){
	this.freq = freq;
}

/*Returns the frequency*/
public int getFreq(){
	return this.freq;
}

/*Sets a specified Pattern*/
public void setPattern(String pattern){
	this.pattern = pattern;
}

/*Returns the Pattern*/
public String getPattern(){
	return this.pattern;
}

/*Increments the value of the freq counter*/ 
public void increment(){
	this.freq++;
}

}
