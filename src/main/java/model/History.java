package model;

import java.io.InputStream;
import java.sql.Timestamp;

public class History {
	private int HISTORY_ID;
	private int USER_ID;
	private int Q_ID;
	private Timestamp VIEWTIME;//Date型はあとで考えるので放置
	private InputStream QIMG;
	private String EXPLANATION;
	private String QTXT;
	
	


	public History(int USER_ID,int Q_ID, Timestamp VIEWTIME,InputStream QIMG,String EXPLANATION,String QTXT) {
		this.USER_ID = USER_ID;
		this.Q_ID = Q_ID;
		this.VIEWTIME = VIEWTIME;
		this.QIMG = QIMG;
		this.EXPLANATION = EXPLANATION;
		this.QTXT = QTXT;
		
	}
	
	
	
	public History(int USER_ID, int Q_ID, Timestamp VIEWTIME) {//いらないかも
		
		
		this.USER_ID = USER_ID;
		this.Q_ID = Q_ID;
		this.VIEWTIME = VIEWTIME;
	}
	
	
	public History(int USER_ID, int Q_ID) {//いらないかも
		
		
		this.USER_ID = USER_ID;
		this.Q_ID = Q_ID;
	}
	
	
	public History() {}
	
	
	public InputStream getQIMG() {
		return QIMG;
	}
	
	
	
	
	public String getEXPLANATION() {
		return EXPLANATION;
	}
	
	
	
	public String getQTXT() {
		return QTXT;
	}
	
	
	public int getHISTORY_ID() {return HISTORY_ID;}
	public int getUSER_ID() {return USER_ID;}
	public int getQ_ID() {return Q_ID;}
	public Timestamp getVIEWTIME() {return VIEWTIME;}
	
	
	

}
