package model;

public class ChatRoom {
    private int roomId;
    private int senderId;
    private int recipientId;

    public ChatRoom(int roomId, int senderId, int recipientId) {
        this.roomId = roomId;
        this.senderId = senderId;
        this.recipientId = recipientId;
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

	public int getRecipientId() {
		return recipientId;
	}

	public void setRecipientId(int recipientId) {
		this.recipientId = recipientId;
	}

}
