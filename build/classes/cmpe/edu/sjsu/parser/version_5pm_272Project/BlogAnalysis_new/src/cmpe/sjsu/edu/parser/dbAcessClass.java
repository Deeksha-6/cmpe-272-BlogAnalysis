package cmpe.sjsu.edu.parser;

//package taggerExample;

/**
 *
 * @author Sony
 */

//package mining.blog.db;

import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.StringTokenizer;

//import mining.blog.Constants.Constants;
import cmpe.sjsu.edu.parser.TaggedWordsBucket;

public class dbAcessClass {
	/*
	 * To change this template, choose Tools | Templates and open the template
	 * in the editor.
	 */

	/*
	 * This class is used to calculate the scores for each sentence by querying
	 * the database
	 */
	boolean SECOND_PASS = false;
	float unFaithfulPosScore = 0;
	float unFaithfulNegScore = 0;

	Connection conn = null;
	String url = "jdbc:mysql://sql3.freemysqlhosting.net:3306/sql339736";
	String dbName = "sql339736";
	String driver = "sun.jdbc.odbc.JdbcOdbcDriver";
	String userName = "sql339736";
	String password = "xS8*xZ3!";
	String query = "INSERT INTO sentiwords (" + " Context," + " PosId,"
			+ " PosScore," + " NegScore," + " Word)VALUES (" + "?, ?, ?, ?, ?)";

	public void calculateScores(List<TaggedWordsBucket> parsedList,
			String comment, int topicId) throws SQLException {
		System.out.println("in Database access class)parsedList items"
				+ parsedList);
		System.out.println("parsed list ize" + parsedList.size());
		float totalPostiveScore = 0;
		float totalNegativeScore = 0;

		String positiveWords;
		String positiveContext;
		String negativeContext;
		String negativeWords;
		String time;

		Calendar cal = Calendar.getInstance();
		cal.getTime();
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
		time = sdf.format(cal.getTime());

		String POSIVE_SQL_QUERY = "select PosScore,NegScore from sentiwords s where word in (?) and context in (?)";
		String NEGATIVE_SQL_QUERY = "select PosScore.NegScore from sentiwords s where word in (?) and context in (?)";
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(
					"jdbc:mysql://sql3.freemysqlhosting.net:3306/sql339736",
					userName, password);
			PreparedStatement pstmt = null;
			ResultSet rs;
			TaggedWordsBucket tempObject = parsedList.get(0);
			System.out.println("tempObject.getWords()::"
					+ tempObject.getWords());
			String wordList[] = tempObject.getWords().split(",");
			String contextList[] = tempObject.getContextPostive().split(",");
			// System.out.println("positive words after split"+positiveWordList.length);
			System.out.println("positive context after split"
					+ contextList.length);

			if (tempObject.getWords() != null
					&& !tempObject.getWords().isEmpty()) {
				/*
				 * This means that the positve words are not null and not empty
				 */

				for (int i = 0; i < wordList.length; i++) {
					SECOND_PASS = false;
					unFaithfulNegScore = 0;
					unFaithfulNegScore = 0;

					/* This code is used to get the score for positive words */

					/*
					 * we take each word with context and calculate scores
					 */
					String tempWord = wordList[i].trim();
					String tempContext = contextList[i].trim();
					System.out.println("tempowrd list after trim" + tempWord);
					System.out.println("temp context after trim" + tempContext);

					pstmt = conn.prepareStatement(POSIVE_SQL_QUERY); // create a
																		// statement
					pstmt.setString(1, tempWord);

					if (tempContext.equalsIgnoreCase("Adverb"))
						pstmt.setString(2, "r");
					if (tempContext.equalsIgnoreCase("Adjective"))
						pstmt.setString(2, "a");
					int numRows = 0;
					ArrayList<Float> tempListOfPosScore = new ArrayList<Float>();
					// float tempListOfPosScore[] = new float[];
					ArrayList<Float> tempListOfNegScore = new ArrayList<Float>();

					// float tempListOfNegScore[]=new float[] {};

					rs = pstmt.executeQuery();
					while (rs.next()) {
						numRows++;
						tempListOfPosScore.add(rs.getFloat("PosScore"));
						tempListOfNegScore.add(rs.getFloat("NegScore"));

					}

					System.out.println("now of row retrieved" + numRows);

					if (numRows >= 5) {
						float posscore = getMax(tempListOfPosScore);
						float negscore = getMax(tempListOfNegScore);

						System.out.println("posscore for >5 rows::" + posscore);
						System.out.println("negscore for >5 rows::" + negscore);

						if (posscore > 0 && negscore == 0) {
							/* [ good ] */
							System.out.println("posscore > 0 && negscore == 0");
							totalPostiveScore = totalPostiveScore + posscore;
							System.out.println(i + "th totalPostiveScore::"
									+ totalPostiveScore);
						}
						if (posscore == 0 && negscore > 0) {
							System.out.println("posscore == 0 && negscore > 0");
							/* [ unfaithful ] */
							totalPostiveScore = totalPostiveScore - negscore;
						}
						if (posscore > 0 && negscore > 0) {
							/* [ wrong ] */
							System.out.println("posscore > 0 && negscore > 0");
							SECOND_PASS = true;
							unFaithfulPosScore = unFaithfulPosScore + posscore;
							unFaithfulNegScore = unFaithfulNegScore + negscore;

						}
						if (posscore == 0 && negscore == 0) {

							/* [ last ] */
							System.out
									.println("posscore == 0 && negscore == 0");
						}

						if (SECOND_PASS) {
							if (totalPostiveScore > 0 || posscore > negscore) {
								/* We add all the unfaithful postive values */
								totalPostiveScore = totalPostiveScore
										+ unFaithfulPosScore;
								System.out.println(i
										+ "th(unfaith+ pos)totalPostiveScore::"
										+ totalPostiveScore);

							} else if (totalPostiveScore < 0
									|| posscore < negscore) {
								/* We add all the unfaithful negative values */
								totalPostiveScore = totalPostiveScore
										- unFaithfulNegScore;
								System.out.println(i + "th totalPostiveScore::"
										+ totalPostiveScore);

							}
							SECOND_PASS = false;
						} else {
							/*
							 * We dont modify the values contained in the total
							 * postive score
							 */
						}
						System.out.println(i + "th final_totalPostiveScore::"
								+ totalPostiveScore);

						tempObject.setSentenceScore(totalPostiveScore);
						System.out.println("sent.Score::"
								+ tempObject.getSentenceScore());
						// parsedList.set(i, tempObject);

					} else {
						rs = pstmt.executeQuery();
						while (rs.next()) {

							float posscore = rs.getFloat("PosScore");
							float negscore = rs.getFloat("NegScore");
							// if()
							/* Algorithm : Word polarity disambiguation */
							/*
							 * CASE-A Posscore > 0 Negscore = 0 [ good ] CASE-B
							 * Posscore = 0 Negscore > 0 [unfaithful ] CASE-C
							 * Posscore > 0 Negscore > 0 [ wrong ] CASE-D
							 * Posscore = 0 Negscore = 0 [ last ]
							 */
							if (posscore > 0 && negscore == 0) {
								/* [ good ] */
								System.out
										.println("posscore > 0 && negscore == 0");
								totalPostiveScore = totalPostiveScore
										+ posscore;
								System.out.println(i + "th totalPostiveScore::"
										+ totalPostiveScore);
							}
							if (posscore == 0 && negscore > 0) {
								System.out
										.println("posscore == 0 && negscore > 0");
								/* [ unfaithful ] */
								totalPostiveScore = totalPostiveScore
										- negscore;
							}
							if (posscore > 0 && negscore > 0) {
								/* [ wrong ] */
								System.out
										.println("posscore > 0 && negscore > 0");
								SECOND_PASS = true;
								unFaithfulPosScore = unFaithfulPosScore
										+ posscore;
								unFaithfulNegScore = unFaithfulNegScore
										+ negscore;

							}
							if (posscore == 0 && negscore == 0) {

								/* [ last ] */
								System.out
										.println("posscore == 0 && negscore == 0");
							}

							if (SECOND_PASS) {
								if (totalPostiveScore > 0
										|| posscore > negscore) {
									/* We add all the unfaithful postive values */
									totalPostiveScore = totalPostiveScore
											+ unFaithfulPosScore;
									System.out
											.println(i
													+ "th(unfaith+ pos)totalPostiveScore::"
													+ totalPostiveScore);

								} else if (totalPostiveScore < 0
										|| posscore < negscore) {
									/* We add all the unfaithful negative values */
									totalPostiveScore = totalPostiveScore
											- unFaithfulNegScore;
									System.out.println(i
											+ "th totalPostiveScore::"
											+ totalPostiveScore);

								}
								SECOND_PASS = false;
							} else {
								/*
								 * We dont modify the values contained in the
								 * total postive score
								 */
							}
							System.out.println(i
									+ "th final_totalPostiveScore::"
									+ totalPostiveScore);

							tempObject.setSentenceScore(totalPostiveScore);
							System.out.println("sent.Score::"
									+ tempObject.getSentenceScore());
							// parsedList.set(i, tempObject);

						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		String insertSentenceDetailsToDatabase = "INSERT INTO blogcomments (TopicId,Comment,Date,Score) VALUES (?,?,?,?) ";
		PreparedStatement ps = conn
				.prepareStatement(insertSentenceDetailsToDatabase);
		ps.setInt(1, topicId);
		System.out.println("comment" + comment);
		ps.setString(2, comment);
		System.out.println("current Date" + getCurrentDate());
		ps.setDate(3, getCurrentDate());
		System.out.println("totAL POSITIVE SCORE:" + totalPostiveScore);
		ps.setDouble(4, totalPostiveScore);
		int i = ps.executeUpdate();
		System.out.println("query executed for the second time count::" + i);

		// System.out.println("time=" + time);

		// return parsedList;
	}

	private static java.sql.Date getCurrentDate() {
		java.util.Date today = new java.util.Date();
		return new java.sql.Date(today.getTime());
	}

	float getMin(ArrayList<Float> tempList) {
		float min = tempList.get(0);
		for (int i = 1; i < tempList.size(); i++) {

			if (min > tempList.get(i) && tempList.get(i) > 0)
				min = tempList.get(i);
		}

		return min;
	}

	float getMax(ArrayList<Float> tempList) {
		float min = tempList.get(0);
		for (int i = 1; i < tempList.size(); i++) {

			if (min < tempList.get(i))
				min = tempList.get(i);
		}

		return min;
	}

}