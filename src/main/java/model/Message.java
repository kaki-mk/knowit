package model;

import java.sql.Timestamp;

public class Message {
    private int msgId;
    private int roomId;
    private int senderId;
    private Timestamp sendTime;
    private String msg;

    public Message(int msgId, int roomId, int senderId, Timestamp sendTime, String msg) {
        this.msgId = msgId;
        this.roomId = roomId;
        this.senderId = senderId;
        this.sendTime = sendTime;
        this.msg = msg;
    }

	public int getMsgId() {
		return msgId;
	}

	public void setMsgId(int msgId) {
		this.msgId = msgId;
	}

	public int getRoomId() {
		return roomId;
	}

	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}

	public int getSenderId() {
		return senderId;
	}

	public void setSenderId(int senderId) {
		this.senderId = senderId;
	}

	public Timestamp getSendTime() {
		return sendTime;
	}

	public void setSendTime(Timestamp sendTime) {
		this.sendTime = sendTime;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}


}
