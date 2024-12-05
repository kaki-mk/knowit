package model;

import java.io.InputStream;
import java.sql.Timestamp;


public class Bookmark {
	private int BOOKID;
	private int QID;
	private int USERID;
	private InputStream QIMG;
	private String EXPLANATION;
	private String QTXT;
	private  Timestamp BVIEWTIME;
	private boolean BMARK;
	
	public Bookmark(int BOOKID ,int QID, int USERID, InputStream QIMG, String EXPLANATION, String QTXT,Timestamp BVIEWTIME , boolean BMARK) {
		this.BOOKID = BOOKID;
		this.QID = QID;
		this.USERID = USERID;
		this.QIMG = QIMG;
		this.EXPLANATION = EXPLANATION;
		this.QTXT = QTXT;
		this.BVIEWTIME = BVIEWTIME;
		this.BMARK = BMARK;
	}
	
	public Bookmark(int QID, int USERID, boolean BMARK) {
		this.QID = QID;
		this.USERID = USERID;
		this.BMARK = BMARK;
	}
	
	public Bookmark(int BOOKID , boolean BMARK) {
		this.BOOKID = BOOKID;
		this.BMARK = BMARK;
	}
	
	public int getBOOKID() {
		return BOOKID;
	}

	public int getQID() {
		return QID;
	}
	
	public int getUSERID() {
		return USERID;
	}

	public InputStream getQIMG() {
		return QIMG;
	}

	public String getEXPLANATION() {
		return EXPLANATION;
	}
	
	public String getQTXT() {
		return QTXT;
	}
	
	public Timestamp getBVIEWTIME() {
		return BVIEWTIME;
	}

	public boolean getisBMARK() {
		return BMARK;
	}
	
	
	
	
	
	

}
