package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Question;

public class QuestionDAO {

	private final String JDBC_URL = "jdbc:postgresql://10.23.107.251:5432/knowit";
	private final String DB_USER = "user";
	private final String DB_PASS = "password";
	
	public List<Question> getAllQuestion() {
		List<Question> questionList = new ArrayList<Question>();

		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("読み込み失敗");
		}
 
		
		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
			String sql = "SELECT * FROM knowit.\"QUESTION\"";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			ResultSet rs = pStmt.executeQuery();

			while (rs.next()) {
				Question question = new Question();
				question.setqID(rs.getInt("QID"));
				question.setqImage(rs.getString("QIMG"));
				question.setExplanation(rs.getString("EXPLANATION"));
				question.setCategoryID(rs.getInt("CATEGORYID"));
				question.setDatetime(rs.getTimestamp("ADDTIME"));
				question.setQTxt(rs.getString("QTXT"));
				questionList.add(question);
			}

		} catch (

		SQLException e) {
			e.printStackTrace();
			return null;
		}
		return questionList;
	}

	public List<Question> getSimilarQuestion(List<String[]> records) {
		List<Question> questionList = new ArrayList<Question>();

		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("読み込み失敗");
		}

		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
			String sql = "SELECT * FROM knowit.\"QUESTION\" WHERE \"QID\" = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			for (String[] record : records) {
				pStmt.setInt(1, Integer.parseInt(record[0]));
				ResultSet rs = pStmt.executeQuery();

				while (rs.next()) {
					Question question = new Question();
					question.setqID(rs.getInt("QID"));
					question.setqImage(rs.getString("QIMG"));
					question.setExplanation(rs.getString("EXPLANATION"));
					question.setCategoryID(rs.getInt("CATEGORYID"));
					question.setDatetime(rs.getTimestamp("ADDTIME"));
					question.setQTxt(rs.getString("QTXT"));
					questionList.add(question);
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		return questionList;
	}
}
