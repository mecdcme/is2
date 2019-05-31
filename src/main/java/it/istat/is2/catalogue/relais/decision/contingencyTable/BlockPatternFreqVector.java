package it.istat.is2.catalogue.relais.decision.contingencyTable;

import java.util.Vector;


@SuppressWarnings("unchecked")
public class BlockPatternFreqVector extends Vector {
	private static final long serialVersionUID = 1L;
	Vector<PatternFreqVector> blockVector;
	
	/*Constructor that initializes a vector of PatterFreqVector*/
        public BlockPatternFreqVector(){
		this.blockVector = new Vector<PatternFreqVector>();
	}
	
	/*Adds a specified PatternFreqVector to the Vector
         * in a specified position (index)*/
        public void add(int index, PatternFreqVector pfv){
		blockVector.add(index,pfv);
	}
	
	/*Adds a specified PatternFreqVector to the Vector*/
        public void addElement(PatternFreqVector pfv){
		blockVector.add(pfv);
	}
	
	/*Returns the PatternFreqVector element 
         * that is in index position*/
        public PatternFreqVector get(int index){
		PatternFreqVector pfv = blockVector.get(index);
		return pfv;
	}	
	
	/*Returns the vector size*/
        public int size(){
		return blockVector.size();
	}
	
	/*Insert a specified PatternFreqVector into
         * the Vector in a specified position (index)*/
        public void set(int index, PatternFreqVector pfv){
		blockVector.set(index, pfv);
	} 
	
	/*Returns a boolean that indicates if a specified
         * PatternFreqVector is contained into the Vector*/
        public boolean contains(PatternFreqVector pfv){
		return blockVector.contains(pfv);
	}
	
	/*Returns the position of the specified PatternFreqVector
         *into the Vector*/
        public int indexOf(PatternFreqVector pfv){
		return blockVector.indexOf(pfv);
	}
	
	/*Removes the specified PatternfreqVecotr from
         *the Vector*/
        public boolean removeElement(PatternFreqVector pfv){
		 return blockVector.remove(pfv);
	}

	/*Removes from the Vector the element in the 
         *specified position  (index)*/
        public void removeElementAt(int index){
		blockVector.removeElementAt(index);
	}

	/*Returns the Vector of PatternFreqVector*/
        public Vector<PatternFreqVector> getPatterFreqVector(){
		return this.blockVector;
	}
	
	/*Returns the position into the Vector of
         *a specified input variable*/
        public int getIndexBlock(String blockVar){
		for(int i =0;i < blockVector.size();i++){
			if(blockVector.get(i).getBlockVar().equals(blockVar))
				return i;
		}
		return -1;
	}

	/*Returns a PatternFreqVector containing a specified
         *input variable*/
        public PatternFreqVector getPatternFreqVector(String blockVar){
		for(int i =0;i < blockVector.size();i++){
			if(blockVector.get(i).getBlockVar().equals(blockVar))
				return blockVector.get(i);
		}
		return null;
	}

}
