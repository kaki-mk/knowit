package model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Question implements Serializable {
	private int qID;
	private String qImage;
	private String explanation;
	private int categoryID;
	private Timestamp datetime;
	private String qTxt;

	public Question() {
	}

	public Question(int qID, String qImage, String explanation, int categoryID, Timestamp datetime, String qTxt) {
		this.qID = qID;
		this.qImage = qImage;
		this.explanation = explanation;
		this.categoryID = categoryID;
		this.datetime = datetime;
		this.qTxt = qTxt;
	}

	public int getqID() {
		return qID;
	}

	public void setqID(int qID) {
		this.qID = qID;
	}

	public String getqImage() {
		return qImage;
	}

	public void setqImage(String qImage) {
		this.qImage = qImage;
	}

	public String getExplanation() {
		return explanation;
	}

	public void setExplanation(String explanation) {
		this.explanation = explanation;
	}

	public int getCategoryID() {
		return categoryID;
	}

	public void setCategoryID(int categoryID) {
		this.categoryID = categoryID;
	}

	public Timestamp getDatetime() {
		return datetime;
	}

	public void setDatetime(Timestamp datetime) {
		this.datetime = datetime;
	}
	
	public String getQTxt() {
		return qTxt;
	}

	public void setQTxt(String qTxt) {
		this.qTxt = qTxt;
	}

}
