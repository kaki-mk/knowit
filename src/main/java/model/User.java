package model;
import java.io.InputStream;

public class User {
	private int USERID;
	private String NAME;
	private String PASS;
	private String CLASS;
	private String MAIL;
	private InputStream  ICON;
	private int TYPEID;
	


	public User() {}
	
	//ログイン用
	public User(int USERID, String PASS) {
		this.USERID = USERID;
		this.PASS = PASS;
	}
	
	public User(int USERID) {
		this.USERID = USERID;
	}
	
public User(int USERID, String NAME, String PASS, String CLASS, String MAIL, InputStream ICON, int TYPEID) {
		super();
		this.USERID = USERID;
		this.NAME = NAME;
		this.PASS = PASS;
		this.CLASS = CLASS;
		this.MAIL = MAIL;
		this.ICON = ICON;
		this.TYPEID = TYPEID;
	}

//	public User(String USER_ID, String PASS, String NAME, String ICON) {
//		this(USER_ID,PASS);
//		this.NAME = NAME;
//		this.ICON = ICON;
//	}
	
	

	public int getUSERID() {
		return USERID;
	}

	public void setUSERID(int uSERID) {
		USERID = uSERID;
	}

	public String getNAME() {
		return NAME;
	}

	public void setNAME(String nAME) {
		NAME = nAME;
	}

	public String getPASS() {
		return PASS;
	}

	public void setPASS(String pASS) {
		PASS = pASS;
	}

	public String getCLASS() {
		return CLASS;
	}

	public void setCLASS(String cLASS) {
		CLASS = cLASS;
	}

	public String getMAIL() {
		return MAIL;
	}

	public void setMAIL(String mAIL) {
		MAIL = mAIL;
	}

	public InputStream getICON() {
		return ICON;
	}

	public void setICON(InputStream iCON) {
		ICON = iCON;
	}

	public int getTYPEID() {
		return TYPEID;
	}

	public void setTYPE(int tYPEID) {
		TYPEID = tYPEID;
	}
}


