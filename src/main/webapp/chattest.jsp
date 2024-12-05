<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@page import="model.User" %>
<%@page import="dao.MessageDAO" %>
<%@page import="model.Message" %>
<%@page import="java.util.List" %>
<%
User loginUser = (User) session.getAttribute("loginUser");
if (loginUser == null) {
    response.sendRedirect("login.jsp");
    return;
}

//recipientId をリクエストから取得、null の場合はデフォルト値 888 を設定
String recipientIdParam = request.getParameter("recipientId");
int recipientId;

if (recipientIdParam == null || recipientIdParam.isEmpty()) {
 recipientId = 888;
} else {
 try {
     recipientId = Integer.parseInt(recipientIdParam);
 } catch (NumberFormatException e) {
     recipientId = 888;
 }
}
MessageDAO messageDAO = new MessageDAO();
int roomId = messageDAO.getRoomId(loginUser.getUSERID(), recipientId);

%>
<html>
<head>
    <title>チャット</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        const recipientId = <%= recipientId %>; // JSPから受け取った値をJavaScript変数に設定
        const roomId = <%= roomId %>; // 同上

        function sendMessage() {
            const message = $('#messageInput').val();
            $.post("Chat", { roomId: roomId, message: message, recipientId: recipientId }, function(response) {
                if (response === "success") {
                    $('#messageInput').val('');
                    loadMessages();
                }
            });
        }

        function loadMessages() {
            $.get("Chat", { roomId: roomId }, function(response) {
                $('#chatBox').html(response); // チャットボックスにHTMLを表示
            });
        }

        $(document).ready(function() {
            loadMessages();
            setInterval(loadMessages, 2000); // 2秒ごとにメッセージをリロード
        });
    </script>
</head>
<body>
    <div id="chatBox" style="border: 1px solid #ccc; height: 300px; overflow-y: scroll;"></div>
    <input type="text" id="messageInput" />
    <button onclick="sendMessage()">送信</button>
</body>
</html>
