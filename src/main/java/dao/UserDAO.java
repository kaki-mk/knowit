package dao;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.User;

public class UserDAO {
	//データベース接続に使用する情報
//	private final String JDBC_URL = "jdbc:postgresql://10.23.107.251:5432/knowit";
//	private final String DB_USER = "user";
//	private final String DB_PASS = "password";

	private final String JDBC_URL = "jdbc:postgresql://10.23.107.251:5432/knowit";
	private final String DB_USER = "user";
	private final String DB_PASS = "password";
	
	public List<User> findAll() {
		List<User> userList = new ArrayList<>();
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("JDBCドライバを読み込めませんでした");
		}
		//データベース接続
		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
			//SELECT文の準備
			String sql = "SELECT * FROM knowit.\"USERS\"";
			PreparedStatement pStmt = conn.prepareStatement(sql);

			//SELECT文を実行
			ResultSet rs = pStmt.executeQuery();
			//SELECT文の結果をUserに格納
			while (rs.next()) {
				int USERID = rs.getInt("USERID");
				String NAME = rs.getString("NAME");
				String PASS = rs.getString("PASS");
				String CLASS = rs.getString("CLASS");
				String MAIL = rs.getString("MAIL");
				InputStream ICON = rs.getBinaryStream("ICON");
				int TYPEID = rs.getInt("TYPEID");
				User user = new User(USERID, NAME, PASS, CLASS, MAIL, ICON, TYPEID);
				userList.add(user);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			//			return null;
		}
		return userList;
	}

	public User findUser(int userId, String pass) {
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("JDBCドライバを読み込めませんでした");
		}

		// データベース接続
		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
			// SELECT文の準備
			String sql = "SELECT \"USERID\", \"NAME\", \"PASS\", \"CLASS\", \"MAIL\", \"ICON\", \"TYPEID\" FROM knowit.\"USERS\" WHERE \"USERID\" = ? AND \"PASS\" = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, userId);
			pStmt.setString(2, pass);

			// SELECT文を実行
			ResultSet rs = pStmt.executeQuery();

			// 結果があればUserオブジェクトを生成
			if (rs.next()) {
				int USERID = rs.getInt("USERID");
				String NAME = rs.getString("NAME");
				String PASS = rs.getString("PASS");
				String CLASS = rs.getString("CLASS");
				String MAIL = rs.getString("MAIL");
				InputStream ICON = rs.getBinaryStream("ICON");
				int TYPEID = rs.getInt("TYPEID");
				return new User(USERID, NAME, PASS, CLASS, MAIL, ICON, TYPEID);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		return null;
	}

	public int findType(int userId) {
		//JDBCドライバを読み込む
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("JDBCドライバを読み込めませんでした");
		}
		//データベース接続
		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
			// SELECT文の準備
			String sql = "SELECT \"TYPEID\" FROM knowit.\"USERS\" WHERE \"USERID\" = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, userId);

			// SELECT文を実行
			ResultSet rs = pStmt.executeQuery();

			// 結果があればUserオブジェクトを生成
			if (rs.next()) {
				int type = rs.getInt("TYPEID");
				return type;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}
		return 0;
		//DBのTYPE列の中身によってreturnの内容、返り値の型を変更

	}

	public boolean create(User user) {
		//JDBCドライバを読み込む
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("JDBCドライバを読み込めませんでした");
		}
		//データベース接続
		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
			conn.setAutoCommit(false);
			//INSERT文の準備
			String sql =  "INSERT INTO knowit.\"USERS\"(\"USERID\", \"NAME\", \"PASS\", \"CLASS\", \"MAIL\", \"ICON\", \"TYPEID\") VALUES(?,?,?,?,?,?,?)";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			//INSERT文の「？」に使用する値を設定してSQL文を完成
			pStmt.setInt(1, user.getUSERID());
			pStmt.setString(2, user.getNAME());
			pStmt.setString(3, user.getPASS());
			pStmt.setString(4, user.getCLASS());
			pStmt.setString(5, user.getMAIL());
			pStmt.setBinaryStream(6, user.getICON());

//			pStmt.setBlob(6, user.getICON()); // 画像データをBLOBとして設定
			pStmt.setInt(7, user.getTYPEID());

			//INSERT文を実行
			int result = pStmt.executeUpdate();
		    // コミット
		    conn.commit();
			if (result < 1) {
				return false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
			
		}
		return true;
	}
	
	
	

	public List<User> getChatUsers(int senderId) {
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("JDBCドライバを読み込めませんでした");
		}
		List<User> chatUsers = new ArrayList<>();
		String sql = "SELECT DISTINCT U.\"USERID\", U.\"NAME\" FROM knowit.\"USERS\" U " +
				"JOIN knowit.\"CHATROOM\" C ON (C.\"SENDERID\" = U.\"USERID\" OR C.\"RECIPIENTID\" = U.\"USERID\") " +
				"WHERE (C.\"SENDERID\" = ? OR C.\"RECIPIENTID\" = ?) AND U.\"USERID\" != ?";
		try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
				PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, senderId);
			stmt.setInt(2, senderId);
			stmt.setInt(3, senderId);
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				User user = new User();
				user.setUSERID(rs.getInt("USERID"));
				user.setNAME(rs.getString("NAME"));
				chatUsers.add(user);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return chatUsers;
	}

	public List<User> getUsersByTypeId(int typeId) {
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("JDBCドライバを読み込めませんでした");
		}
	    List<User> users = new ArrayList<>();
	    String sql = "SELECT \"USERID\", \"NAME\" FROM knowit.\"USERS\" WHERE \"TYPEID\" = ?";
	    try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	        stmt.setInt(1, typeId);
	        ResultSet rs = stmt.executeQuery();
	        
	        while (rs.next()) {
	            User user = new User();
	            user.setUSERID(rs.getInt("USERID"));
	            user.setNAME(rs.getString("NAME"));
	            users.add(user);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return users;
	}

	
	public byte[] getUserIcon(int userId) {
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("JDBCドライバを読み込めませんでした");
		}
	    String sql = "SELECT \"ICON\" FROM knowit.\"USERS\" WHERE \"USERID\" = ?";
	    try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	        stmt.setInt(1, userId);
	        ResultSet rs = stmt.executeQuery();
	        if (rs.next()) {
	            byte[] imageData = rs.getBytes("ICON");
                return imageData;
	        }
	        
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return null;
	}
	
    public User getUserById(int userId) {
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("JDBCドライバを読み込めませんでした");
		}
        String sql = "SELECT * FROM knowit.\"USERS\" WHERE \"USERID\" = ?";
        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
        		PreparedStatement stmt = conn.prepareStatement(sql)) {

        	stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
				int USERID = rs.getInt("USERID");
				String NAME = rs.getString("NAME");
				String PASS = rs.getString("PASS");
				String CLASS = rs.getString("CLASS");
				String MAIL = rs.getString("MAIL");
				InputStream ICON = rs.getBinaryStream("ICON");
				int TYPEID = rs.getInt("TYPEID");
                // 他のフィールドも設定
				return new User(USERID, NAME, PASS, CLASS, MAIL, ICON, TYPEID);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean account(User user) {
    	try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("JDBCドライバを読み込めませんでした");
		}
    	try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)){
    		//UPDATE文の準備
    		String sql = "UPDATE knowit.\"USERS\" SET \"NAME\" = ?, \"PASS\" = ?, \"ICON\" = ? WHERE \"USERID\" = ?";
    		PreparedStatement pStm = conn.prepareStatement(sql);
    		pStm.setString(1, user.getNAME());
    		pStm.setString(2, user.getPASS());
    		pStm.setBinaryStream(3, user.getICON());
    		pStm.setInt(4, user.getUSERID());
    		
    		int result = pStm.executeUpdate();
    		if(result < 1) {
    			return false;
    		}
    		
    	}catch(SQLException e) {
    		e.printStackTrace();
    		return false;
    	}
    	return true;
    }
    
    public String userName(int userId) {
    	try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("JDBCドライバを読み込めませんでした");
		}
    	
        String sql = "SELECT \"NAME\" FROM knowit.\"USERS\" WHERE \"USERID\" = ?";
        try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS);
        		PreparedStatement stmt = conn.prepareStatement(sql)) {

        	stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
				String NAME = rs.getString("NAME");
				return NAME;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

}



