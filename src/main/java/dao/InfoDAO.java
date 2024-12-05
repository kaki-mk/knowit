package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import model.Info;

public class InfoDAO {
	private final String JDBC_URL = "jdbc:postgresql://10.23.107.251:5432/knowit";
	private final String DB_USER = "user";
	private final String DB_PASS = "password";

//	// 通知を追加する
//	public boolean createNotification(int senderId, int recipientId, String url) {
//		try {
//			Class.forName("org.h2.Driver");
//		} catch (ClassNotFoundException e) {
//			throw new IllegalStateException("JDBCドライバを読み込めませんでした");
//		}
//		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
//			String sql = "INSERT INTO INFO (SENDERID, RECIPIENTID, URL, CREATETIME) " +
//					"VALUES (?, ?, ?, CURRENT_TIMESTAMP)";
//			PreparedStatement stmt = conn.prepareStatement(sql);
//			stmt.setInt(1, senderId);
//			stmt.setInt(2, recipientId);
//			stmt.setString(3, url);
//
//			return stmt.executeUpdate() > 0;
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return false;
//	}

	public boolean createNotification(int senderId, int recipientId, String url) {
	    try {
	        Class.forName("org.postgresql.Driver");
	    } catch (ClassNotFoundException e) {
	        throw new IllegalStateException("JDBCドライバを読み込めませんでした");
	    }
	    
	    try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
	        
	        // 1. 同じ送信者と受信者の通知が既に存在するか確認する
	        String checkSql = "SELECT COUNT(*) FROM knowit.\"INFO\" WHERE \"SENDERID\" = ? AND \"RECIPIENTID\" = ?";
	        try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
	            checkStmt.setInt(1, senderId);
	            checkStmt.setInt(2, recipientId);
	            
	            ResultSet rs = checkStmt.executeQuery();
	            rs.next();
	            int count = rs.getInt(1);

	            if (count > 0) {
	                // 2. 通知が存在する場合、時間を更新する
	                String updateSql = "UPDATE knowit.\"INFO\" SET \"CREATETIME\" = CURRENT_TIMESTAMP WHERE \"SENDERID\" = ? AND \"RECIPIENTID\" = ?";
	                try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
	                    updateStmt.setInt(1, senderId);
	                    updateStmt.setInt(2, recipientId);
	                    
	                    return updateStmt.executeUpdate() > 0;
	                }
	            } else {
	                // 3. 通知が存在しない場合、新しく通知を挿入する
	                String insertSql = "INSERT INTO knowit.\"INFO\" (\"SENDERID\", \"RECIPIENTID\", \"URL\", \"CREATETIME\") " +
	                                   "VALUES (?, ?, ?, CURRENT_TIMESTAMP)";
	                try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
	                    insertStmt.setInt(1, senderId);
	                    insertStmt.setInt(2, recipientId);
	                    insertStmt.setString(3, url);
	                    
	                    return insertStmt.executeUpdate() > 0;
	                }
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return false;
	}

	
	// 指定した受信者の通知一覧を取得する
	public List<Info> getNotifications(int recipientId) {
		List<Info> notifications = new ArrayList<>();
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("JDBCドライバを読み込めませんでした");
		}
		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
			String sql = "SELECT * FROM knowit.\"INFO\" WHERE \"RECIPIENTID\" = ? ORDER BY \"CREATETIME\" DESC";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, recipientId);

			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				int infoId = rs.getInt("INFOID");
				int senderId = rs.getInt("SENDERID");
				String url = rs.getString("URL");
				Timestamp createTime = rs.getTimestamp("CREATETIME");

				notifications.add(new Info(infoId, senderId, recipientId, url, createTime));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return notifications;
	}

	// 特定の通知を取得する
	public Info getNotificationById(int infoId) {
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("JDBCドライバを読み込めませんでした");
		}
		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
			String sql = "SELECT * FROM knowit.\"INFO\" WHERE \"INFOID\" = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, infoId);

			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				int senderId = rs.getInt("SENDERID");
				int recipientId = rs.getInt("RECIPIENTID");
				String url = rs.getString("URL");
				Timestamp createTime = rs.getTimestamp("CREATETIME");

				return new Info(infoId, senderId, recipientId, url, createTime);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	// 特定の通知を削除する
	public boolean deleteNotification(int infoId) {
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("JDBCドライバを読み込めませんでした");
		}
		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
			String sql = "DELETE FROM knowit.\"INFO\" WHERE \"INFOID\" = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, infoId);

			return stmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	//既読フラグが「TRUE」のメッセージの通知を削除する
	public boolean deleteInfo() {
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
	        String sql = "DELETE FROM knowit.\"INFO\" WHERE \"INFOID\" IN ("
	                   + "SELECT I.\"INFOID\" "
	                   + "FROM INFO I "
	                   + "INNER JOIN knowit.\"MESSAGE\" M ON I.\"SENDERID\" = M.\"SENDERID\" "
	                   + "WHERE M.\"READFLAG\" = TRUE)";
			
			PreparedStatement stmt = conn.prepareStatement(sql);
			return stmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	// 受信者IDに関連するすべての通知を削除する
	public boolean deleteAllNotificationsForRecipient(int recipientId) {
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("JDBCドライバを読み込めませんでした");
		}
		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
			String sql = "DELETE FROM knowit.\"INFO\" WHERE \"RECIPIENTID\" = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, recipientId);

			return stmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
}
