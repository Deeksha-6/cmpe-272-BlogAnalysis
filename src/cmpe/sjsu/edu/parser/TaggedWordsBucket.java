
package cmpe.sjsu.edu.parser;

/**
 *
 * @author Sony
 */
class TaggedWordsBucket {
    
	
	/* This class is used to hold all the values related to each sentence */
	String inputSentence;
	String positiveWords;
	String negativeWords;
	String contextPostive;
	String contextNegative;
	int sentenceScore;
	String listOfWords;
	String context;
	
	public String getInputSentence() {
		return inputSentence;
	}
	public void setInputSentence(String inputsentence) {
		if(inputSentence == null)
		{
			inputSentence = new String();
			inputSentence = inputsentence;
		}
		else
		{
			inputSentence = inputSentence.concat(inputsentence);
		}
		
	}
	
	// all the words
	public String getWords() {
		return listOfWords;
	}
	public void setWords(String positivewords) {
		if(listOfWords == null)
		{
			listOfWords = new String();
			listOfWords = positivewords;
		}
		else
		{
			listOfWords = listOfWords.concat(","+positivewords);
		}
	}

	
	//positive word
	public String getPositiveWords() {
		return positiveWords;
	}
	public void setPositiveWords(String positivewords) {
		if(positiveWords == null)
		{
			positiveWords = new String();
			positiveWords = positivewords;
		}
		else
		{
			positiveWords = positiveWords.concat(","+positivewords);
		}
	}
	
	//negative words
	public String getNegativeWords() {
		return negativeWords;
	}
	public void setNegativeWords(String negativewords) {
		if(negativeWords == null)
		{
			negativeWords = new String();
			negativeWords = negativewords;
		}
		else
		{
			negativeWords = negativeWords.concat(","+negativewords);
		}
	}
	public int getSentenceScore() {
		return sentenceScore;
	}
	public void setSentenceScore(float totalPostiveScore) {
		this.sentenceScore = (int) totalPostiveScore;
	}

	// all words context
	public String getContext() {
		return context;
	}
	public void setContext(String contextpostive) {
		if(context == null)
		{
			context = new String();
			context = contextpostive;
		}
		else
		{
			context = context.concat(","+contextpostive);
		}
	}
	
	
	public String getContextPostive() {
		return contextPostive;
	}
	public void setContextPostive(String contextpostive) {
		if(contextPostive == null)
		{
			contextPostive = new String();
			contextPostive = contextpostive;
		}
		else
		{
			contextPostive = contextPostive.concat(","+contextpostive);
		}
	}
	public String getContextNegative() {
		return contextNegative;
	}
	public void setContextNegative(String contextnegative) {
		if(contextNegative == null)
		{
			contextNegative = new String();
			contextNegative = contextnegative;
		}
		else
		{
			contextNegative = contextNegative.concat(","+contextnegative);
		}
	}
	public String toString()
	{
		return inputSentence;
	}
}
