/*static final String endOfSentenceRegEx = "^\\d[A-Z]?$";;
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package cmpe.sjsu.edu.parser;

import edu.stanford.nlp.tagger.maxent.MaxentTagger;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.ObjectInputStream.GetField;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;



import cmpe.sjsu.edu.parser.tagger.*;
//import java.util.StringTokenizer;
import cmpe.sjsu.edu.parser.TaggedWordsBucket;


public class TaggerExample {

    /**
     * @param args the command line arguments
     */
	static boolean isNegative = false;
	static TaggedWordsBucket bucketObject;
    public void insertIntoDBComment (String sample, int topicId) throws IOException,ClassNotFoundException,Exception {
 
        // Initialize the tagger
        MaxentTagger tagger = new MaxentTagger("D:\\Java\\workspace\\taggerExample\\src\\taggerExample\\tagger\\left3words-wsj-0-18.tagger");
        dbAcessClass database = new dbAcessClass();
       
      String comment = sample;
        String tagged = tagger.tagString(sample);
        // Output the result in the file "posTaggerOutPutFile.txt"
        
        FileWriter outputTaggerFile = new FileWriter("posTaggerOutPutFile.txt", false);
        PrintWriter out1 = new PrintWriter(outputTaggerFile);
         try {
                out1.append(tagged);
            }
         finally {
                        out1.close();
                        outputTaggerFile.close();
         }
    		try {
			/* This is the output file of the pos tagger */
			FileReader taggerFile = new FileReader("posTaggerOutPutFile.txt");
                          /* This is the file that we give as input the processing function */
			 FileOutputStream fileOut = new FileOutputStream("parserOutPutFile.txt");			
                        PrintStream ps = new PrintStream(fileOut);
                        BufferedReader br = new BufferedReader(taggerFile);
                        String taggerFileRecord="";
			
                        try {
        					while(br.ready() && (taggerFileRecord= br.readLine()) != null)
        					{
        						if(taggerFileRecord.contains("/CC"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/CC","@@@@Coordinating Conjunction\n");
        						}
        						if(taggerFileRecord.contains("/CD"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/CD","@@@@Cardinal Number\n");
        						}
        						if(taggerFileRecord.contains("/DT"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/DT","@@@@Determiner\n");
        						}
        						if(taggerFileRecord.contains("/DT"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/DT","@@@@Determiner\n");
        						}
        						if(taggerFileRecord.contains("/EX"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/EX","@@@@Existential There\n");
        						}
        						if(taggerFileRecord.contains("/FW"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/FW","@@@@Foregin Word\n");
        						}
        						if(taggerFileRecord.contains("/IN"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/IN","@@@@Preposition\n");
        						}
        						if(taggerFileRecord.contains("/JJR"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/JJR","@@@@Adjective\n");
        							
        						}
        						if(taggerFileRecord.contains("/JJS"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/JJS","@@@@Adjective\n");
        						}
        						
        						if(taggerFileRecord.contains("/JJ"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/JJ","@@@@Adjective\n");
        						}
        						if(taggerFileRecord.contains("/LS"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/LS","@@@@List Item Marker\n");
        						}
        						if(taggerFileRecord.contains("/MD"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/MD","@@@@Modal\n");
        						}
        						if(taggerFileRecord.contains("/NNPS"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/NNPS","@@@@NounPS\n");
        						}
        						if(taggerFileRecord.contains("/NNP"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/NNP","@@@@NounP\n");
        						}
        						if(taggerFileRecord.contains("/NNS"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/NNS","@@@@NounS\n");
        						}
        						if(taggerFileRecord.contains("/NN"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/NN","@@@@Noun\n");
        						}
        						if(taggerFileRecord.contains("/PDT"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/PDT","@@@@Predeterminer\n");
        							
        						}
        						if(taggerFileRecord.contains("/PRP$"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/PRP$","@@@@Pronoun\n");
        						}
        						if(taggerFileRecord.contains("/PRP"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/PRP","@@@@Personal pronoun\n");
        						}
        						if(taggerFileRecord.contains("/RP"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/RP","@@@@Particle\n");
        						}
        						if(taggerFileRecord.contains("/RBR"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/RB","@@@@Adverb\n");
        						}
        						if(taggerFileRecord.contains("/RBS"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/RB","@@@@Adverb\n");
        						}
        						if(taggerFileRecord.contains("/RB"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/RB","@@@@Adverb\n");
        						}
        						
        						if(taggerFileRecord.contains("/TO"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/TO","@@@@To\n");
        						}
        						if(taggerFileRecord.contains("/UH"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/UH","@@@@Interjunction\n");
        						}
        						if(taggerFileRecord.contains("/VBZ"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/VBZ","@@@@VerbZ\n");
        						}
        						if(taggerFileRecord.contains("/VBP"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/VBP","@@@@VerbP\n");
        						}
        						 if(taggerFileRecord.contains("/VBN"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/VBN","@@@@VerbN\n");
        						}
        						if(taggerFileRecord.contains("/VBD"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/VBD","@@@@VerbD\n");
        						}
        						if(taggerFileRecord.contains("/VBG"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/VBG","@@@@VerbG\n");
        						}
        						
        						if(taggerFileRecord.contains("/WRB"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/WRB","@@@@Wh-Adverb\n");
        						}
        						if(taggerFileRecord.contains("/WR"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/WR","@@@@Wh-Verb\n");
        						}

        						if(taggerFileRecord.contains("/WDT"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/WDT","@@@@Wh-Determiner\n");
        						}
        						if(taggerFileRecord.contains("/WP"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/WP","@@@@Wh-Pronoun\n");
        						}
        						if(taggerFileRecord.contains("/POS"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/POS","@@@@POS\n");
        						}
        						if(taggerFileRecord.contains("/SYM"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/SYM","@@@@Symbol\n");
        						}
        						/* Now we remove all the other tags which are of no use to use */
        						if(taggerFileRecord.contains("/."))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/.","@@@@End\n");
        						}
        						 if(taggerFileRecord.contains("/,"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/,","@@@@Comma\n");
        						}
        						 if(taggerFileRecord.contains("/;"))
        						{
        							taggerFileRecord = taggerFileRecord.replace("/;","@@@@Semicolon\n");
        						}
        						
        						if (taggerFileRecord.contains("\""))
        						{
        							taggerFileRecord = taggerFileRecord.replace("\"","@@@@Double-Quote\n");
        						}
        						
					
					ps.print(taggerFileRecord);
                                        ps.append("e");
				}
				fileOut.close();
				ps.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} 
    		StringReader stringreader=new StringReader();
	                List<TaggedWordsBucket> parsedList = stringreader.readFile("parserOutPutFile.txt");
	                FileWriter prefinalOutputFile = new FileWriter("prefinalOutput.txt", false);
                    PrintWriter preoutput = new PrintWriter(prefinalOutputFile);
                     try {
                            preoutput.print(parsedList);
                        }
                     finally {
                                    preoutput.close();
                                    prefinalOutputFile.close();
                     }
                   
                     System.out.println("parsedList in TaggerExample"+parsedList);
                     database.calculateScores(parsedList, sample, topicId);
                    
              	}

}


    


