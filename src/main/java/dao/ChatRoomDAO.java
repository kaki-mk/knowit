package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class ChatRoomDAO {
	private final String JDBC_URL = "jdbc:postgresql://10.23.107.251:5432/knowit";
	private final String DB_USER = "user";
	private final String DB_PASS = "password";

    public int createChatRoom(int senderId, int recipientId, String url) {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new IllegalStateException("JDBCドライバを読み込めませんでした");
        }

        // データベース接続
        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
            // INSERT文の準備
            String sql = "INSERT INTO knowit.\"CHATROOM\" (\"SENDERID\", \"RECIPIENTID\", \"URL\") VALUES (?, ?, ?)";
            PreparedStatement pStmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pStmt.setInt(1, senderId);
            pStmt.setInt(2, recipientId);
            pStmt.setString(3, url);

            int result = pStmt.executeUpdate();

            // ROOMIDを取得して返す
            if (result > 0) {
                ResultSet rs = pStmt.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // エラー時
    }
}
