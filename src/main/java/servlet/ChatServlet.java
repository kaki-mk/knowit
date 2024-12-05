package servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.InfoDAO;
import dao.MessageDAO;
import model.Message;
import model.User;

@WebServlet("/Chat")
public class ChatServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	try {
        // ユーザー情報をセッションから取得
        HttpSession session = request.getSession();
        int senderId = ((User) session.getAttribute("loginUser")).getUSERID();

        // リクエストパラメータ取得
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        String message = request.getParameter("message");
        int recipientId = Integer.parseInt(request.getParameter("recipientId"));

        // メッセージ送信
        MessageDAO messageDAO = new MessageDAO();
        boolean isSuccess = messageDAO.sendMessage(roomId, senderId,recipientId, message);
        System.out.println(roomId);
        System.out.println(recipientId);
        
        // メッセージ送信後に受信者へ通知メールを送信
//        if (isSuccess) {
//            try {
//                // 受信者の情報を取得
//                User recipient = messageDAO.getUserById(recipientId);
//                String recipientEmail = recipient.getMAIL();
//                User loginUser = (User) session.getAttribute("loginUser");
//                String senderName = loginUser.getNAME();
//                
//                // メール送信
//                EmailSender.sendEmail(recipientEmail, senderName);
//            } catch (MessagingException e) {
//                e.printStackTrace();
//            }
//        }
        
        // INFOテーブルに行を追加
        if (isSuccess) {
            InfoDAO infoDAO = new InfoDAO();
            String notificationUrl = "jsp/chat.jsp?senderId=" + senderId; // 通知のリンク 受信者のIDを渡したい
            infoDAO.createNotification(senderId, recipientId, notificationUrl);
            response.setContentType("text/plain");
            response.getWriter().write("success");
        } else {
            response.getWriter().write("error");
        }

    	}catch(Exception e) {
    		e.printStackTrace();
    	}
    }

//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//
//    	try {
//    	
//        int roomId = Integer.parseInt(request.getParameter("roomId"));
//        HttpSession session = request.getSession();
//        User loginUser = (User) session.getAttribute("loginUser");
//        if(loginUser == null) {
//        	System.out.println("null");
//        	
//        }
//        int recipientId = loginUser.getUSERID(); // ログイン中のユーザーが受信者
//
//        MessageDAO messageDAO = new MessageDAO();
//
//        // 既読フラグを更新
//        try {
//            messageDAO.markMessagesAsRead(roomId, recipientId);
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//
//        // メッセージ一覧を取得
//        List<Message> messages = messageDAO.getMessages(roomId);
//
//        // メッセージをHTMLに変換
//        StringBuilder htmlResponse = new StringBuilder();
//        htmlResponse.append("<ul>");
//        for (Message message : messages) {
//            htmlResponse.append("<li>");
//            htmlResponse.append("<b>").append(message.getSenderId()).append(":</b> ")
//                        .append(message.getMsg());
//            // 既読フラグの確認
//            if (message.getSenderId() == recipientId && messageDAO.isMessageRead(message.getMsgId())) {
//                htmlResponse.append(" <span style='color: green;'>既読</span>");
//            }
//            htmlResponse.append(" <small>(").append(message.getSendTime()).append(")</small>");
//            htmlResponse.append("</li>");
//        }
//        htmlResponse.append("</ul>");
//
//        response.setContentType("text/html; charset=UTF-8");
//        response.getWriter().write(htmlResponse.toString());
//    	}catch(Exception e) {
//    		e.printStackTrace();
//    	}
//    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            HttpSession session = request.getSession();
            User loginUser = (User) session.getAttribute("loginUser");
            if (loginUser == null) {
                response.sendRedirect("index.jsp");
                return;
            }
            int recipientId = loginUser.getUSERID(); // ログイン中のユーザーが受信者

            MessageDAO messageDAO = new MessageDAO();

            // 既読フラグを更新
            messageDAO.markMessagesAsRead(roomId, recipientId);

            // メッセージ一覧を取得
            List<Message> messages = messageDAO.getMessages(roomId);

            // メッセージをHTMLに変換
            StringBuilder htmlResponse = new StringBuilder();
            htmlResponse.append("<div class='chat-container'>");

            for (Message message : messages) {
                boolean isOwnMessage = message.getSenderId() == recipientId;

                // 日付と時間:分のフォーマット
                String formattedTime = message.getSendTime().toLocalDateTime()
                    .format(java.time.format.DateTimeFormatter.ofPattern("MM-dd HH:mm"));

                // メッセージブロックのクラスを設定
                String messageClass = isOwnMessage ? "message sent" : "message received";
                String infoClass = isOwnMessage ? "message-info sent" : "message-info received";

                htmlResponse.append("<div class='").append(messageClass).append("'>");

                // メッセージ本文
                htmlResponse.append("<div class='message-box'>");
                htmlResponse.append("<p>").append(message.getMsg()).append("</p>");
                htmlResponse.append("</div>");

                // 時間と既読フラグ
                htmlResponse.append("<div class='").append(infoClass).append("'>");
               
                htmlResponse.append("<span class='time'>").append(formattedTime).append("</span>");
                // 既読フラグを自分のメッセージにのみ表示
                if (isOwnMessage && messageDAO.isMessageRead(message.getMsgId())) {
                    htmlResponse.append("<span class='read-flag'>既読</span>");
                }
                htmlResponse.append("</div>");

                htmlResponse.append("</div>");
            }

            htmlResponse.append("</div>");

            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().write(htmlResponse.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }



}


