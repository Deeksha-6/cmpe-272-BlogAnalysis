package cmpe.sjsu.edu.parser;
import java.lang.*;
import java.util.List;
import java.util.StringTokenizer;
import cmpe.sjsu.edu.parser.TaggedWordsBucket;
import cmpe.sjsu.edu.parser.*;
import java.sql.*;

public class StringParser {
	
	public List<TaggedWordsBucket> parseString(String record,List<TaggedWordsBucket> completeList) {
        
		/* This function is used to seperate the String based on our criteria 
		 * and insert all of them in to the list */
        boolean  isExistingSentence = true;
	int sentenceCounter = 1;
	boolean tempEndOfSentenceVariable = true;
	int listSize = 0;
	
    TaggedWordsBucket bucketObject;
	if(isExistingSentence)
	{
	/* This means that this is still an existing sentence */
        	
            if(completeList.size()>0)
            {
            	listSize = sentenceCounter-1;
            	bucketObject = completeList.get(listSize);
		
            }
            else
            {
            	listSize = sentenceCounter-1;
            	bucketObject = new TaggedWordsBucket();
            	completeList.add(bucketObject);
		    }
    }
	else 
	{
	/* This means we are getting a new sentence */
	   	listSize = sentenceCounter-1;
        isExistingSentence = true;
		bucketObject = new TaggedWordsBucket();
			if(completeList.size() < sentenceCounter)
			{
					completeList.add(bucketObject);
			}
	}
    StringTokenizer tokenString = new StringTokenizer(record,"@@@@");
         
	String word = tokenString.nextToken();
	System.out.println("word::"+word);
	String type = tokenString.nextToken();
	System.out.println("type::"+type);
	
//	System.out.println("value of if"+(type.trim().equalsIgnoreCase("Adverb")||type.equalsIgnoreCase("adjective")));
	if(type.trim().equalsIgnoreCase("Adverb")||type.equalsIgnoreCase("adjective"))
	{
		System.out.println("Word containing \".\""+word);
		
		if(word.trim().contains("."))
		{
		/* This means that there is full stop followed by space */
			tempEndOfSentenceVariable = false;
			sentenceCounter++;
			System.out.println("sentConter::"+sentenceCounter);
			isExistingSentence=false;
			String splitSent[]=word.split(".");
			if(!splitSent[0].equals("."))
				bucketObject.setWords(splitSent[0]);
			else
				bucketObject.setWords(splitSent[1]);
			
		}
	   	
	     	bucketObject.setWords(word);
           	bucketObject.setContextPostive(type);
	}
	bucketObject.setInputSentence(word);
	completeList.set(listSize,bucketObject);

	if(!tempEndOfSentenceVariable)
	{
			isExistingSentence = false;
	}
    return completeList;
  }


}
