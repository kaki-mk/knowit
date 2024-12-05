<!-- 
*******************************************************
以前のチャットリスト画面からデザインを大幅に変更しています。
（以前のデザイン　共有フォルダ「BU」内　またはPCデスクトップ）
*******************************************************
 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

    // チャット相手のリストを取得するためにDAOを呼び出す
    List<User> chatUsers = (List<User>)request.getAttribute("chatUsers");
%>
<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ChatList</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #007D7A;
            display: flex;
            flex-direction: column;
            align-items: center;
            height: 100vh;
            padding-top: 20px;
        }

        .header {
		display: flex; /* ヘッダー内の要素を横並びに */
		align-items: center; /* 縦方向の中央揃え */
		position: fixed; /* 固定位置 */
		top: 0; /* 上からの距離を0に */
		left: 50%; /* 左からの距離を50%に */
		transform: translateX(-50%); /* 中央に配置 */
		padding: 15px; /* パディングを追加 */
		background-color: rgba(0, 125, 122, 0.8); /* 背景色を半透明にして視認性を向上 */
		z-index: 10; /* 他の要素の上に表示 */
		}

        .back-button {
		background-color: #007D7A; /* 背景色 */
		color: white; /* 文字色 */
		border: none; /* 枠線なし */
		border-radius: 5px; /* 角を丸くする */
		padding: 8px; /* 内側の余白 */
		cursor: pointer; /* ホバー時にカーソルをポインタに */
		font-size: 16px; /* フォントサイズ */
		position: fixed; /* 固定位置 */
		top: 15px; /* 上からの距離 */
		left: 15px; /* 左からの距離 */
		z-index: 10; /* 他の要素の上に表示 */
		}

        h1 {
            color: white;
            font-size: 18px;
            margin: 0;
        }

        .container {
            width: 100%;
            max-width: 400px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            margin-top: 60px;
            
        }

        .message-list {
            padding: 15px;
            max-height: calc(100vh - 100px);
            overflow-y: auto;
        }

        .message-item {
            display: flex;
            align-items: center;
            padding: 10px;
            border-bottom: 1px solid #ddd;
            cursor: pointer;
            text-decoration: none;
            color: #333;
        }

        .message-item:hover {
            background-color: #f1f1f1;
        }

        .message-item:last-child {
            border-bottom: none;
        }

        .message-icon {
            width: 40px;
            height: 40px;
            background-color: #ddd;
            border-radius: 50%;
            margin-right: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            color: white;
            background-color: #007D7A;
        }

        .message-text {
            font-size: 16px;
            color: #333;
        }
    </style>
</head>



<body>

		<div class="header">
			<h1>Chat List</h1>
		</div>
        
        <button class="back-button" onclick="history.back();">
            <i class="fas fa-chevron-left"></i>
        </button>


    <div class="container">
        <div class="message-list">
            <ul style="list-style: none; padding: 0;">
                <% if (chatUsers != null) { %>
                    <% for (User user : chatUsers) { %>
                        <% if (user.getUSERID() != loginUser.getUSERID()) { %>
                            <li>
                                <a class="message-item" href="jsp/chat.jsp?recipientId=<%= user.getUSERID() %>">
                                    <div class="message-icon">
                                        <%= user.getNAME().charAt(0) %> <!-- ユーザー名の頭文字を表示 -->
                                    </div>
                                    <div class="message-text"><%= user.getNAME() %></div>
                                </a>
                            </li>
                        <% } %>
                    <% } %>
                <% } %>
            </ul>
        </div>
    </div>
</body>

</html>
