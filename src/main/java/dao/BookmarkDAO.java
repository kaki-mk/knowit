package dao;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import model.Bookmark;
import model.User;





//import model.History;
public class BookmarkDAO {
	//データベース接続に使用する情報
	private final String JDBC_URL =  "jdbc:postgresql://10.23.107.251:5432/knowit";
	private final String DB_USER =  "user";
	private final String DB_PASS = "password";
		
	public List<Bookmark> findAll(User user){
			List<Bookmark> bookmarkList = new ArrayList<>();
			
			//JDBCドライバを読み込む
			try {
				Class.forName("org.postgresql.Driver");
			}catch(ClassNotFoundException e){
				throw new IllegalStateException("JDBCドライバを読み込めませんでした");
			}
			
			//DBに接続
			try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)){
				
				//SELECTの準備
				//VIEWHISTORY

				String sql ="SELECT B.\"BOOKID\", Q.\"QID\", B.\"USERID\", Q.\"QIMG\", Q.\"EXPLANATION\", Q.\"QTXT\", B.\"BVIEWTIME\", B.\"BMARK\" FROM knowit.\"BOOKMARK\" B "//userIDでの結合も必要
						   + "LEFT OUTER JOIN knowit.\"QUESTION\" Q ON B.\"QID\" = Q.\"QID\" "
						   + "WHERE B.\"BMARK\" = TRUE AND B.\"USERID\" = ?"
						   + "ORDER BY B.\"BVIEWTIME\"  DESC";
				PreparedStatement pStmt = conn.prepareStatement(sql);//error
				pStmt.setInt(1, user.getUSERID());
				//SELECTを実行
				ResultSet rs = pStmt.executeQuery();
				
				//SELECT文の結果をArrayListに追加
				while(rs.next()){
					
					int BOOKID = rs.getInt("BOOKID");
					int QID = rs.getInt("QID");
					int USERID = rs.getInt("USERID");
					InputStream QIMG = rs.getBinaryStream("QIMG");
					String EXPLANATION = rs.getString("EXPLANATION");
					String QTXT = rs.getString("QTXT");
					//Date BVIEWTIME = rs.getDate("BVIEWTIME");
					Timestamp BVIEWTIME = rs.getTimestamp("BVIEWTIME");
					boolean BMARK = rs.getBoolean("BMARK");
					
					
					 Bookmark bookmark = new Bookmark(BOOKID,QID,USERID,QIMG,EXPLANATION,QTXT,BVIEWTIME,BMARK);
					
					bookmarkList.add(bookmark);
					
				}
				
			}catch(SQLException e) {
				
				e.printStackTrace();
				return null;
				
			}
			
			return bookmarkList;
			
		}
		
		public boolean bookmarkaddition(Bookmark bookmark) {//QID USERID BMARK
			
			//JDCBドライバを読み込む
			try {
				
				Class.forName("org.postgresql.Driver");
				
			}catch(ClassNotFoundException e) {
				
				throw new IllegalStateException("JDBCドライバを読み込めませんでした");
				
			}
			
			//DB接続USERID

			try(Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
				
				//INSERT文の準備（IDは自動連番）
				String sql = "INSERT INTO knowit.\"BOOKMARK\"(\"QID\",\"USERID\",\"BVIEWTIME\",\"BMARK\") VALUES(?,?,?,?)";
				PreparedStatement pStmt = conn.prepareStatement(sql);
				
				//INSERT文中の「？」に使用する値を設定してSQL文を完成
				pStmt.setInt(1, bookmark.getQID());
				pStmt.setInt(2, bookmark.getUSERID());
				pStmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));//2024-11-14 11:56:30.123 
				//pStmt.setDate(3, new Date(System.currentTimeMillis()));//2024-11-14　が出力される
				pStmt.setBoolean(4, bookmark.getisBMARK());//true=1 false=0
				//pStmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));//2024-11-14 11:56:30.123 
				
				
				//INSERT文を実行（resultには追加された行数が入る）
				int result = pStmt.executeUpdate();
				if(result != 1) { return false; }
				
			}catch(SQLException e) {
				
				e.printStackTrace();
				return false;
				
			}
			
			return true;
			
		}
		//booleanのエラー処理書く
		public boolean bookmarkupd(Bookmark bookmark) {//デリートになるかも
			//JDCBドライバを読み込む
			try {
				
				Class.forName("org.postgresql.Driver");
				
			}catch(ClassNotFoundException e) {
				
				throw new IllegalStateException("JDBCドライバを読み込めませんでした");
				
			}
			
			//DB接続USERID

			try(Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
				
				
				String sql = "UPDATE knowit.\"BOOKMARK\" SET \"BVIEWTIME\" = ?, \"BMARK\" = ? WHERE \"BOOKID\" = ?";
				PreparedStatement pStmt = conn.prepareStatement(sql);
				
				pStmt.setTimestamp(1, new Timestamp(System.currentTimeMillis()));//2024-11-14 11:56:30.123 
				//pStmt.setDate(1, new Date(System.currentTimeMillis()));
				pStmt.setBoolean(2, bookmark.getisBMARK() );
				pStmt.setInt(3, bookmark.getBOOKID());
				
				
				int result = pStmt.executeUpdate();
				if(result != 1) { return false;}
				
			}catch(SQLException e) {
				e.printStackTrace();
				return false;
			}
			return true;
		}
		
		public boolean bookmarkdelete(Bookmark bookmark) {//デリート BOOKID BMARK
			//JDCBドライバを読み込む
			try {
				
				Class.forName("org.postgresql.Driver");
				
			}catch(ClassNotFoundException e) {
				
				throw new IllegalStateException("JDBCドライバを読み込めませんでした");
				
			}
			
			//DB接続USERID

			try(Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
				
				
				String sql = "DELETE FROM knowit.\"BOOKMARK\" WHERE \"BOOKID\" = ?";
				PreparedStatement pStmt = conn.prepareStatement(sql);
				
				pStmt.setInt(1, bookmark.getBOOKID());				
				
				int result = pStmt.executeUpdate();
				if(result != 1) { return false;}
				
			}catch(SQLException e) {
				e.printStackTrace();
				return false;
			}
			return true;
		}
		
		
	}



