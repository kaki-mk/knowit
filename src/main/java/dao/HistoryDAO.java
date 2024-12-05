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

import model.History;
import model.User;

//import model.History;
public class HistoryDAO {
	//データベース接続に使用する情報
		private final String JDBC_URL =  "jdbc:postgresql://10.23.107.251:5432/knowit";
		private final String DB_USER =  "user";
		private final String DB_PASS = "password";
		
	public List<History> findAll(User user){
			List<History> historyList = new ArrayList<>();
			
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

				String sql = "SELECT V.\"USERID\",V.\"QID\",V.\"VIEWTIME\",Q.\"QIMG\",Q.\"EXPLANATION\",Q.\"QTXT\" FROM knowit.\"VIEWHISTORY\" V "
						   + " LEFT OUTER JOIN knowit.\"QUESTION\" Q ON V.\"QID\" = Q.\"QID\" "
						   + "WHERE V.\"USERID\" = ? "   //IDごとに、履歴を出力できるようにする
						   + "ORDER BY V.\"VIEWTIME\"  DESC "
						   + "LIMIT 30";                                       
				PreparedStatement pStmt = conn.prepareStatement(sql);
				pStmt.setInt(1,user.getUSERID());
				
				//SELECTを実行
				ResultSet rs = pStmt.executeQuery();
				
				//SELECT文の結果をArrayListに追加
				while(rs.next()){//ここから
					
					//int HISTORY_ID = rs.getInt("HISTORYID");//いらないかも
					int USER_ID = rs.getInt("USERID");
					int Q_ID = rs.getInt("QID");
					InputStream QIMG = rs.getBinaryStream("QIMG");
					String EXPLANATION = rs.getString("EXPLANATION");
					String QTXT = rs.getString("QTXT");
					
					
					Timestamp VIEWTIME = rs.getTimestamp("VIEWTIME");//一旦放置
					
					
					History history = new History(USER_ID,Q_ID,VIEWTIME,QIMG,EXPLANATION,QTXT);
					
					historyList.add(history);
					
				}
				
			}catch(SQLException e) {
				
				e.printStackTrace();
				return null;
				
			}
			
			return historyList;
			
		}
	
	     
		
		public boolean historyaddition(History history) {//booleanだが、機能は実装していない
			
			//JDCBドライバを読み込む
			try {
				
				Class.forName("org.postgresql.Driver");
				
			}catch(ClassNotFoundException e) {
				
				throw new IllegalStateException("JDBCドライバを読み込めませんでした");
				
			}
			
			//DB接続USERID

			try(Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)) {
				
				//INSERT文の準備（IDは自動連番）
				String sql = "INSERT INTO knowit.\"VIEWHISTORY\"(\"USERID\",\"QID\",\"VIEWTIME\") VALUES(?, ? ,?)";
				PreparedStatement pStmt = conn.prepareStatement(sql);
				
				//INSERT文中の「？」に使用する値を設定してSQL文を完成
				//pStmt.setInt(1, history.getHISTORY_ID());
				pStmt.setInt(1, history.getUSER_ID());
				pStmt.setInt(2, history.getQ_ID());
				//pStmt.setDate(3, new Date(System.currentTimeMillis()));//2024-11-14　が出力される
				pStmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));//2024-11-14 11:56:30.123 
				
				
				//INSERT文を実行（resultには追加された行数が入る）
				int result = pStmt.executeUpdate();
				if(result != 1) { return false; }
				
			}catch(SQLException e) {
				
				e.printStackTrace();
				return false;
				
			}
			
			return true;
			
		}
		
		
	}



