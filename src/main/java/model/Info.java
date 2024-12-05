package model;

import java.sql.Timestamp;

public class Info {
    private int infoId;
    private int senderId;
    private int recipientId;
    private String url;
    private Timestamp createTime;

    // コンストラクタ
    public Info(int infoId, int senderId, int recipientId, String url, Timestamp createTime) {
        this.infoId = infoId;
        this.senderId = senderId;
        this.recipientId = recipientId;
        this.url = url;
        this.createTime = createTime;
    }

    // ゲッターとセッター
    public int getInfoId() {
        return infoId;
    }

    public void setInfoId(int infoId) {
        this.infoId = infoId;
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

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Timestamp getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }
}
