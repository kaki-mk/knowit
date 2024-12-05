<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@page import="model.User" %>
<%@page import="java.util.List" %>
<%@page import="dao.UserDAO" %>
<%
// セッションスコープからユーザー情報を取得
User loginUser = (User) session.getAttribute("loginUser");
if (loginUser == null) {
    response.sendRedirect("login.jsp");
    return;
}

//
List<User> chatUsers = (List<User>)request.getAttribute("chatUsers");

// チャット相手のリストを取得するためにDAOを呼び出す
//UserDAO userDAO = new UserDAO();
//List<User> users = userDAO.getChatUsers(loginUser.getUSERID());
%>
<html>
<head>
    <title>チャットリスト</title>
</head>
<body>
    <h1>チャット相手を選択</h1>

        <ul>
    <%if(chatUsers != null){ %>
        <% for (User user : chatUsers) { %>
        <%if(user.getUSERID() != loginUser.getUSERID()){ %>
            <li>
                <a href="chat.jsp?recipientId=<%= user.getUSERID() %>">
                    <%= user.getNAME() %>
                </a>
            </li>
        <% } %>
        <% } %>
        <%} %>
    </ul>
</body>
</html>
