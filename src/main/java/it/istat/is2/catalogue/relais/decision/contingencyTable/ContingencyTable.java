package it.istat.is2.catalogue.relais.decision.contingencyTable;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import it.istat.is2.catalogue.relais.constants.TablesName;
import it.istat.is2.catalogue.relais.matchingVariables.MatchingVariables;
import it.istat.is2.catalogue.relais.metrics.DiceSimilarity;
import it.istat.is2.catalogue.relais.metrics.Jaro;
import it.istat.is2.catalogue.relais.metrics.JaroWinkler;
import it.istat.is2.catalogue.relais.metrics.Levenshtein;
import it.istat.is2.catalogue.relais.metrics.QGramsDistance;
import it.istat.is2.catalogue.relais.metrics.Soundex;
import it.istat.is2.catalogue.relais.metrics.added.NumericComparison;
import it.istat.is2.catalogue.relais.metrics.added.NumericEuclideanDistance;
import it.istat.is2.catalogue.relais.metrics.added.QGramsInclusion;
import it.istat.is2.catalogue.relais.metrics.added.WindowEquality;
import it.istat.is2.catalogue.relais.metrics.dataStructure.MetricMatchingVariableVector;
import it.istat.is2.catalogue.relais.metrics.utility.AbstractStringMetric;
import it.istat.is2.catalogue.relais.project.ReconciledSchema;
import it.istat.is2.catalogue.relais.project.VariablesSetting;

public class ContingencyTable {

private Connection connection;
private Statement stmCreate;
private final int DIMMAX = 100000;
private String blockingKey;
private MetricMatchingVariableVector mmvv;
private BlockPatternFreqVector bpfv;
private int numVar;
private int dim;
private int[][] combinations;
private ReconciledSchema rsc;
MatchingVariables mv;

/*Constructor that takes in input the 
 *Connection to the database. Creates all the possible 
 *patterns.*/
public ContingencyTable(Connection conn) throws Exception {

        this.connection=conn;

        mv=new MatchingVariables(conn);
        this.mmvv = new MetricMatchingVariableVector();
	this.mmvv = mv.getMetricMatchingVariableVector();

	this.numVar = mmvv.size();
        
        rsc = new ReconciledSchema(conn);
	
	VariablesSetting set = new VariablesSetting(connection);
        this.blockingKey = set.ReadBlockVar();
        
	double dim_d=Math.pow(2,numVar);
	dim=(int) dim_d;
	combinations=new int[dim][numVar];
	int i,j;
	int nn=0;
	int r=0;
	//Creation of the whole possible patterns	
	for (i=0;i<dim;i++)
	{
		nn=i;	
		for (j=numVar;j>0;j--)
		{r=nn%2;			
		 if (r==0) combinations[i][j-1]=0;
		 else combinations[i][j-1]=1;
		  nn=nn/2;						
		}				 
	}
	bpfv = new BlockPatternFreqVector();
        
}

   /*Creates and initializes the table ContingencyTable 
     *evaluating the frequencies of all possible patterns 
     *through the application of a specified distance 
     *function. Different distance functions return a value 
     *contained in the interval (0,1) and if this result is 
     *greater than a certain threshold, the result is converted 
     *into 1 when it is smaller than the threshold, the result 
     *is transformed into 0.
     *This function is applied only if the method applied is the 
     *Blocking and only if a single block is analized, in input 
     *is specified the block number*/
private void CreateContingencyTable(boolean blocking, int blockNumber, String blockModality) throws Exception {
	
        Statement stm;
	PatternFreqVector pfv;
	String pattern,denomBlock;
	int i;
	int varBlock;
        
	String tableNameTemp = TablesName.nameSearchSpaceTemp();
	String tableNameFinal = TablesName.nameSearchSpaceFinal();
	String tableNameConting = TablesName.nameContingency();
	double rowloaded=0,rowtoload;
        AbstractStringMetric[] metrics = new AbstractStringMetric[numVar];
	
        for (int ind=0; ind<numVar; ind++) {
            if (mmvv.get(ind).getComparisonFunction().equals("Equality"))
                metrics[ind]=null;
            else if (mmvv.get(ind).getComparisonFunction().equals("Jaro"))
                metrics[ind]=new Jaro();
            else if (mmvv.get(ind).getComparisonFunction().equals("Dice"))
                metrics[ind]=new DiceSimilarity();
            else if (mmvv.get(ind).getComparisonFunction().equals("JaroWinkler"))
                metrics[ind]=new JaroWinkler();
            else if (mmvv.get(ind).getComparisonFunction().equals("Levenshtein"))
                metrics[ind]=new Levenshtein();
            else if (mmvv.get(ind).getComparisonFunction().equals("3Grams"))
                metrics[ind]=new QGramsDistance();
            else if (mmvv.get(ind).getComparisonFunction().equals("Soundex"))
                metrics[ind]=new Soundex();
            else if (mmvv.get(ind).getComparisonFunction().equals("NumericComparison"))
                metrics[ind]=new NumericComparison();
            else if (mmvv.get(ind).getComparisonFunction().equals("NumericEuclideanDistance"))
                metrics[ind]=new NumericEuclideanDistance();
            else if (mmvv.get(ind).getComparisonFunction().equals("WindowEquality"))
                metrics[ind]=new WindowEquality(mmvv.get(ind));
            else if (mmvv.get(ind).getComparisonFunction().equals("Inclusion3Grams"))
                metrics[ind]=new QGramsInclusion();
        }

                
        stm = (Statement)connection.createStatement();
        stm.executeUpdate("DROP TABLE IF EXISTS "+tableNameFinal+";");

        String createString;
        createString="CREATE TABLE "+tableNameFinal+" (KEY_DSA INTEGER UNSIGNED, KEY_DSB INTEGER UNSIGNED,";
        if (blocking) {
            createString=createString+" BLOCK_NUMBER INTEGER, BLOCK VARCHAR(500),";
        }
        createString=createString+" ROWNUMBER BIGINT, PATTERN VARCHAR(150)) ENGINE = MYISAM";
            
        stm.executeUpdate(createString);
        stm.close();
			  
	String selectCount = "SELECT MAX(ROWNUMBER) FROM "+tableNameTemp+";";
	Statement stmCount = (Statement)connection.createStatement();			
	ResultSet rsCount = stmCount.executeQuery(selectCount);
	rsCount.next();
	rowtoload =  rsCount.getDouble(1);
	rsCount.close();
	stmCount.close();
        
        String blockColumns = "0 as BLOCK_NUMBER, 'NO' as BLOCK, ";
        if (blocking) blockColumns="D.BLOCK_NUMBER, C.BLOCK, ";	
	String selectString = "SELECT C.KEY_DSA, C.KEY_DSB, "+blockColumns+"C.ROWNUMBER ";
        /* select matchvar from datsets */
        for (int ind=0; ind< numVar; ind++) {
            selectString=selectString+", A." + rsc.getAttribute(mmvv.get(ind).getMatchingVariable(),"A") + ", B." + rsc.getAttribute(mmvv.get(ind).getMatchingVariable(),"B");
        }
        /* from */
	selectString = selectString + "\n FROM "+TablesName.nameDsa()+" A, "+TablesName.nameDsb()+" B, "+tableNameTemp+" C";
        if (blocking) { selectString=selectString+", "+TablesName.nameBlockModality()+" D"; }
	selectString = selectString + "\n WHERE C.KEY_DSA=A.KEY_DSA AND C.KEY_DSB=B.KEY_DSB ";
        if (blocking) {
            selectString = selectString + " AND C.BLOCK=D.BLOCK_MODALITY ";
        }
        if (blocking && blockNumber>0) { selectString = selectString + " AND C.BLOCK = '"+blockModality+"' AND D.BLOCK_NUMBER = "+blockNumber;}
		    
	PreparedStatement prepInsert;
	String insertString;
        if (blocking) {
            insertString = "INSERT INTO " +tableNameFinal+ " (KEY_DSA, KEY_DSB, ROWNUMBER, PATTERN, BLOCK_NUMBER, BLOCK) VALUES (?,?,?,?,?,?)";
        } else {
            insertString = "INSERT INTO " +tableNameFinal+ " (KEY_DSA, KEY_DSB, ROWNUMBER, PATTERN ) VALUES (?,?,?,?)";
        }
        
	prepInsert = connection.prepareStatement(insertString);
	
	while (rowloaded < rowtoload) 
	{
	  String selectStringDM = selectString;
	  if (rowloaded>0) 
	     selectStringDM = selectStringDM + " AND C.ROWNUMBER > "+ rowloaded;
	  if (rowtoload>(rowloaded+DIMMAX))
	     selectStringDM = selectStringDM + " AND C.ROWNUMBER <= "+ (rowloaded+DIMMAX);
	  stm= (Statement)connection.createStatement();	

          ResultSet rsSelect = stm.executeQuery(selectStringDM);
	  int jj=0; 			
	  while (rsSelect.next())
	  {
	    jj++;
              varBlock = rsSelect.getInt(3);
            denomBlock = rsSelect.getString(4);
                                        
            if (denomBlock.equals(""))
	       denomBlock=" ";
					
            pattern="";
		
           /* evaluation of patternd */
            for (int ii=0; ii< numVar; ii++) {
               if (rsSelect.getString(6+2*ii)==null || rsSelect.getString(7+2*ii)==null || rsSelect.getString(6+2*ii).equals("")) {
                                                    
                pattern=pattern+"0";
               }
	      //Equality
	       else if (metrics[ii]==null) {
		   if (rsSelect.getString(6+2*ii).equals(rsSelect.getString(7+2*ii)))
			pattern=pattern+"1";
		   else
			pattern=pattern+"0";
	       }
	       else {
                   
		   if (metrics[ii].getSimilarity(rsSelect.getString(6+2*ii),rsSelect.getString(7+2*ii))>=mmvv.get(ii).getMetricThreshold())
			pattern=pattern+"1";
		   else
			pattern=pattern+"0";
	       }
						
	
	    }
	 
             /* evaluation of contingency */
	    pfv=this.bpfv.getPatternFreqVector(String.valueOf(varBlock));
				
	    if(pfv == null){
	       pfv = createVector(dim,String.valueOf(varBlock));		
               pfv.getPatternFreq(pattern).increment();
	       this.bpfv.addElement(pfv);
	    }
	    else{
		pfv.getPatternFreq(pattern).increment();
	    }
		
            /* insert value with pattern */
	    prepInsert.setInt(1,rsSelect.getInt(1));
	    prepInsert.setInt(2,rsSelect.getInt(2));
	    prepInsert.setDouble(3,rsSelect.getDouble(5));
	    prepInsert.setString(4,pattern);
            if (blocking) {
                prepInsert.setInt(5,varBlock);
                prepInsert.setString(6,denomBlock);
            }
	    prepInsert.executeUpdate();
	  
          }

	rsSelect.close();
	stm.close();
					
	rowloaded = rowloaded + DIMMAX;
	}
	prepInsert.close();
	
        String[] colCT = mv.getContingencyColumns();
        String createStringColumn = " (";
        String stringColumnsCT="";
        for (int ind=0 ; ind<colCT.length; ind++) {
            createStringColumn = createStringColumn+colCT[ind]+ " CHAR(1), ";
            stringColumnsCT = stringColumnsCT+colCT[ind]+ ", ";
        }
	createStringColumn = createStringColumn + "FREQUENCY BIGINT);";
	stringColumnsCT = stringColumnsCT + "FREQUENCY";
        
        String tableName;
        
        for(int k=0; k<this.bpfv.size(); k++){
            if (blocking) {
                tableName=tableNameConting+"_"+blockingKey.replace(",","_").toUpperCase()+"_"+bpfv.get(k).getBlockVar();
            } else {
                tableName=tableNameConting;
            }

      	
            stm = (Statement)connection.createStatement();
            stm.executeUpdate("DROP TABLE IF EXISTS "+tableName);
						
            createString = "CREATE TABLE "+tableName+createStringColumn;
            stm.executeUpdate(createString);
				
            for(i=0; i<this.bpfv.get(k).size(); i++){
                insertString = "INSERT INTO "+tableName+" (" + stringColumnsCT + ") VALUES (";
	   
                pattern = this.bpfv.get(k).get(i).getPattern();
                for(int ind=0;ind<pattern.length();ind++)
                    insertString = insertString + "'"+pattern.substring(ind, ind+1)+"', ";
                
                insertString = insertString+this.bpfv.get(k).get(i).getFreq()+")";	
		stm.execute(insertString);

            }
         }       
 }

 private PatternFreqVector createVector(int dim, String varBlock) {
     PatternFreqVector pfv = new PatternFreqVector(varBlock);
     for (int i=0;i<dim;i++)
     {
	String pattern ="";
	int nn=i;	
	for (int j=numVar;j>0;j--)
	{
            int r=nn%2;			
	    if (r==0) combinations[i][j-1]=0;
	    else combinations[i][j-1]=1;
	    nn=nn/2;	
	}
	for(int k=0; k<numVar;k++)
	    pattern=pattern+combinations[i][k];
	PatternFreq pf = new PatternFreq(pattern);
	pfv.addElement(pf);	
     }
     return pfv;
 }
 
 public void CreateContingencyTable() throws Exception {
         this.CreateContingencyTable(false, 0, " ");
 }
 
 public void CreateContingencyTableBlocking() throws Exception {
         this.CreateContingencyTable(true, 0, " ");
 }
 
 public void CreateContingencyTableOneBlock(int blockNumber, String blockModality) throws Exception {
         this.CreateContingencyTable(true, blockNumber, blockModality);
 }
  
}

