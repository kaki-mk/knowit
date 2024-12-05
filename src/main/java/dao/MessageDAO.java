/* ************************************
CHATROOM ROOMID , MESSAGE MSGID は自動で連番が振られるように
ROOMID SERIAL NOT NULL のように定義する
*/

package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import model.Message;
import model.User;

public class MessageDAO {
	private final String JDBC_URL = "jdbc:postgresql://10.23.107.251:5432/knowit";
	private final String DB_USER = "user";
	private final String DB_PASS = "password";
	
	public boolean sendMessage(int roomId, int senderId, int recipientId, String messageContent) {
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("JDBCドライバを読み込めませんでした");
		}

		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {

			// チャットルームが存在するか確認
			String checkRoomSql = "SELECT \"ROOMID\" FROM knowit.\"CHATROOM\" WHERE (\"SENDERID\" = ? AND \"RECIPIENTID\" = ?) OR (\"SENDERID\" = ? AND \"RECIPIENTID\" = ?)";
			PreparedStatement checkRoomStmt = conn.prepareStatement(checkRoomSql);
			checkRoomStmt.setInt(1, senderId);
			checkRoomStmt.setInt(2, recipientId);
			checkRoomStmt.setInt(3, recipientId);
			checkRoomStmt.setInt(4, senderId);
			
			ResultSet rs = checkRoomStmt.executeQuery();
			if (rs.next()) {
	            // 既存のROOMIDを取得
	            int existingRoomId = rs.getInt("ROOMID");

	            // 既存のROOMIDを使ってメッセージをMESSAGEテーブルに挿入
	            String sql = "INSERT INTO knowit.\"MESSAGE\" (\"ROOMID\", \"SENDERID\", \"SENDTIME\", \"MSG\", \"READFLAG\") VALUES (?, ?, CURRENT_TIMESTAMP, ?, FALSE)";
	            PreparedStatement pStmt = conn.prepareStatement(sql);
	            pStmt.setInt(1, existingRoomId);  // 既存のROOMIDを使用
	            pStmt.setInt(2, senderId);        // 送信者のID
	            pStmt.setString(3, messageContent); // メッセージ内容

	            // メッセージ挿入を実行
	            int result = pStmt.executeUpdate();
	            return result > 0;
			} else {
				// 新しいチャットルームを作成
				// まず、CHATROOMテーブルにチャットルームを作成する
				String chatRoomSql = "INSERT INTO knowit.\"CHATROOM\" (\"SENDERID\", \"RECIPIENTID\", \"URL\") VALUES (?, ?, ?)";
				PreparedStatement chatRoomStmt = conn.prepareStatement(chatRoomSql,
						PreparedStatement.RETURN_GENERATED_KEYS);
				chatRoomStmt.setInt(1, senderId);
				chatRoomStmt.setInt(2, recipientId);
				chatRoomStmt.setString(3, "URL_to_chat"); // 通知されたメッセージの画面に遷移するURLを指定

				// チャットルーム挿入を実行
				int chatRoomResult = chatRoomStmt.executeUpdate();

				// チャットルームが正常に作成されたか確認
				if (chatRoomResult > 0) {
					// 新しく作成したチャットルームのROOMIDを取得
					ResultSet generatedKeys = chatRoomStmt.getGeneratedKeys();
					if (generatedKeys.next()) {
						int rid = generatedKeys.getInt(1); // ROOMIDを取得

						// 次に、MESSAGEテーブルにメッセージを挿入する
						String sql = "INSERT INTO knowit.\"MESSAGE\" (\"ROOMID\", \"SENDERID\", \"SENDTIME\", \"MSG\", \"READFLAG\") VALUES (?, ?, CURRENT_TIMESTAMP, ?, FALSE)";
						PreparedStatement pStmt = conn.prepareStatement(sql);
						pStmt.setInt(1, rid);
						pStmt.setInt(2, senderId);
						pStmt.setString(3, messageContent);

						// メッセージ挿入を実行
						int result = pStmt.executeUpdate();
						return result > 0;
					}
				}

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public int getRoomId(int senderId, int recipientId) {
	    try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
	        // 1. 既存のチャットルームを検索
	        String sql = "SELECT \"ROOMID\" FROM knowit.\"CHATROOM\" WHERE (\"SENDERID\" = ? AND \"RECIPIENTID\" = ?) OR (\"SENDERID\" = ? AND \"RECIPIENTID\" = ?)";
	        PreparedStatement stmt = conn.prepareStatement(sql);
	        stmt.setInt(1, senderId);
	        stmt.setInt(2, recipientId);
	        stmt.setInt(3, recipientId);
	        stmt.setInt(4, senderId);
	        ResultSet rs = stmt.executeQuery();

	        // 既存のチャットルームがあればROOMIDを返す
	        if (rs.next()) {
	            return rs.getInt("ROOMID");
	        }

	        // 2. 新しいチャットルームを作成
	        String insertRoomSql = "INSERT INTO knowit.\"CHATROOM\" (\"SENDERID\", \"RECIPIENTID\", \"URL\") VALUES (?, ?, ?)";
	        PreparedStatement insertRoomStmt = conn.prepareStatement(insertRoomSql, PreparedStatement.RETURN_GENERATED_KEYS);
	        insertRoomStmt.setInt(1, senderId);
	        insertRoomStmt.setInt(2, recipientId);
	        insertRoomStmt.setString(3, "URL_to_chat"); // チャットルームに関連するURLを設定
	        int result = insertRoomStmt.executeUpdate();

	        // チャットルームが正常に作成された場合、生成されたROOMIDを取得
	        if (result > 0) {
	            ResultSet generatedKeys = insertRoomStmt.getGeneratedKeys();
	            if (generatedKeys.next()) {
	                return generatedKeys.getInt(1); // 新しいROOMIDを返す
	            }
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return -1; // エラーまたは失敗時
	}



    // ユーザーIDでユーザーを取得するメソッド
    public User getUserById(int userId) {
        UserDAO userDAO = new UserDAO();
        return userDAO.getUserById(userId);  // UserDAOのメソッドを呼び出してユーザー情報を取得
    }


	public List<Message> getMessages(int roomId) {
		List<Message> messages = new ArrayList<>();

		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("JDBCドライバを読み込めませんでした");
		}

		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
			String sql = "SELECT \"MSGID\", \"ROOMID\", \"SENDERID\", \"SENDTIME\", \"MSG\" FROM knowit.\"MESSAGE\" WHERE \"ROOMID\" = ? ORDER BY \"SENDTIME\" ASC";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, roomId);

			ResultSet rs = pStmt.executeQuery();
			while (rs.next()) {
				int msgId = rs.getInt("MSGID");
				int senderId = rs.getInt("SENDERID");
				Timestamp sendTime = rs.getTimestamp("SENDTIME");
				String message = rs.getString("MSG");

				messages.add(new Message(msgId, roomId, senderId, sendTime, message));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return messages;
	}
	

	public boolean isMessageRead(int messageId) {
	    try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
	        String sql = "SELECT \"READFLAG\" FROM knowit.\"MESSAGE\" WHERE \"MSGID\" = ?";
	        PreparedStatement stmt = conn.prepareStatement(sql);
	        stmt.setInt(1, messageId);
	        ResultSet rs = stmt.executeQuery();
	        if (rs.next()) {
	            return rs.getBoolean("READFLAG");
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return false;
	}

	public void markMessagesAsRead(int roomId, int recipientId) throws SQLException {
	    try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
	        String sql = "UPDATE knowit.\"MESSAGE\" SET \"READFLAG\" = TRUE " +
	                     "WHERE \"ROOMID\" = ? AND \"SENDERID\" != ? AND \"READFLAG\" = FALSE";
	        PreparedStatement stmt = conn.prepareStatement(sql);
	        stmt.setInt(1, roomId);
	        stmt.setInt(2, recipientId); // 自分以外の送信者
	        stmt.executeUpdate();
	    }
	}
	
	

}