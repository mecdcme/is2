package it.istat.is2.catalogue.relais.decision.contingencyTable;

import java.util.Vector;


@SuppressWarnings("unchecked")
public class PatternFreqVector extends Vector {
	private static final long serialVersionUID = 1L;
	Vector<PatternFreq> vector;
	String blockVar;
	
	/*Constructor*/
        public PatternFreqVector(){
		vector = new Vector<PatternFreq>();
		blockVar="";
	}
	
	/*Constructor that takes as input a specified variable*/
        public PatternFreqVector(String blockVar){
		vector = new Vector<PatternFreq>();
		this.blockVar=blockVar;
	}
	
	/*Adds in a specified position (index) a specified PatternFreq*/
        public void add(int index, PatternFreq pf){
		vector.add(index,pf);
	}
	
	/*Adds a specified PatternFreq*/
        public void addElement(PatternFreq pf){
		vector.add(pf);
	}
	
	/*Returns a PatternFreq in a specified position (index)*/
        public PatternFreq get(int index){
		PatternFreq pf = vector.get(index);
		return pf;
	}	
	
        /*Returns the vector size*/
        public int size(){
		return vector.size();
	}
	
	/*Sets a PatternFreq in a specified position (index)*/
        public void set(int index, PatternFreq pf){
		vector.set(index, pf);
	} 
	
	/*Sets the blockVar*/
        public void setBlockVar(String blockVar){
		this.blockVar=blockVar;
	}

	/*Returns the blockVar value*/
        public String getBlockVar(){
		return this.blockVar;
	}
	
	/*Returns a boolean that indicates if the specified
         *PatternFreq is contained into the Vector*/
        public boolean contains(PatternFreq pf){
		return vector.contains(pf);
	}
	
	/*Returns the index in the vector of the specified PatternFreq*/
        public int indexOf(PatternFreq pf){
		return vector.indexOf(pf);
	}
	
	/*Removes the specified PatternFreq from the vector*/
        public boolean removeElement(PatternFreq pf){
		 return vector.remove(pf);
	}

	/*Removes the element in position index from the vector*/
        public void removeElementAt(int index){
		vector.removeElementAt(index);
	}

	/*Returns the vector of PatternFreq*/
        public Vector<PatternFreq> getPatterFreqVector(){
		return this.vector;
	}
	
	/*Returns the index of the specified pattern in the vector*/
        public int getIndexPattern(String pattern){
		for(int i =0;i < vector.size();i++){
			if(vector.get(i).getPattern().equals(pattern))
				return i;
		}
		return -1;
	}

	/*Returns the PatternFreq element corresponding 
         *to the specified pattern*/
        public PatternFreq getPatternFreq(String pattern){
		for(int i =0;i < vector.size();i++){
			if(vector.get(i).getPattern().equals(pattern))
				return vector.get(i);
		}
		return null;
	}
}
