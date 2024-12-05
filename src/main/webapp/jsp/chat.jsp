<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@page import="dao.MessageDAO"%>
<%@page import="dao.UserDAO"%>
<%@page import="model.Message"%>
<%@page import="java.util.List"%>
<%
User loginUser = (User) session.getAttribute("loginUser");
if (loginUser == null) {
	response.sendRedirect("login.jsp");
	return;
}

String recipientIdParam = request.getParameter("recipientId");
int recipientId;
int roomId;

if (recipientIdParam != null && !recipientIdParam.isEmpty()) {
	try {
		recipientId = Integer.parseInt(recipientIdParam);
	} catch (NumberFormatException e) {
		recipientId = 888; // 不正な値の場合のデフォルト
	}
} else {
	Object recipientIdAttr = request.getAttribute("recipientId");
	if (recipientIdAttr != null) {
		try {
	recipientId = Integer.parseInt(recipientIdAttr.toString());
		} catch (NumberFormatException e) {
	recipientId = 888; // 不正な値の場合のデフォルト
		}
	} else {
		recipientId = 888; // デフォルト値
	}
}

String senderIdParam = request.getParameter("senderId");
int senderId;

if (senderIdParam != null && !senderIdParam.isEmpty()) {
	try {
		senderId = Integer.parseInt(senderIdParam);
	} catch (NumberFormatException e) {
		senderId = 888; // 不正な値の場合のデフォルト
	}
} else {
	Object senderIdAttr = request.getAttribute("senderId");
	if (senderIdAttr != null) {
		try {
	senderId = Integer.parseInt(senderIdAttr.toString());
		} catch (NumberFormatException e) {
	senderId = 888; // 不正な値の場合のデフォルト
		}
	} else {
		senderId = 888; // デフォルト値
	}
}

MessageDAO messageDAO = new MessageDAO();
UserDAO userDAO = new UserDAO();
String name;

//if (senderId != 888) {
	//roomId = messageDAO.getRoomId(loginUser.getUSERID(), senderId);
	//name = userDAO.userName(senderId);
//} else {
//	roomId = messageDAO.getRoomId(loginUser.getUSERID(), recipientId);
//	name = userDAO.userName(recipientId);
//}
roomId = messageDAO.getRoomId(loginUser.getUSERID(), recipientId);
name = userDAO.userName(recipientId);

System.out.println(roomId);
System.out.println(senderId);
System.out.println(recipientId);
%>

<!DOCTYPE html>
<html lang="ja">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Chat</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
/* デザインのCSSをコピー */
/* グローバルスタイル */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: Arial, sans-serif;
	display: flex;
	flex-direction: column;
	height: 100vh;
	background-color: #f7f7f7;
}

/* ヘッダー部分 */
.header {
	background-color: #007D7A;
	color: white;
	padding: 15px;
	display: flex;
	align-items: center;
}

.back-button {
	background-color: #007D7A;
	color: white;
	border: none;
	border-radius: 5px;
	padding: 8px;
	cursor: pointer;
	font-size: 16px;
}

.username {
	font-size: 1.2em;
	margin-left: 10px;
}

/* チャットコンテナ */
.chat-container {
	flex-grow: 1;
	width: 100%;
	max-width: 400px;
	margin: 0 auto;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	padding: 15px;
	overflow-y: auto;
	display: flex;
	flex-direction: column;
	gap: 10px;
}

/* メッセージ共通スタイル */

.message {
	display: flex;
	align-items: flex-end;
	max-width: 70%;
	font-family: Arial, sans-serif;
}

/* 自分のメッセージ */
.message.sent {
	align-self: flex-end;
	flex-direction: column;
	background-color: #007D7A;
	color: white;
	padding: 10px;
	border-radius: 10px 10px 0 10px;
	position: relative;
}

/* 相手のメッセージ */
.message.received {
	align-self: flex-start;
	flex-direction: column;
	background-color: #f1f1f1;
	color: green;
	padding: 10px;
	border-radius: 10px 10px 10px 0;
	position: relative;
}

/* 時間と既読表示部分 */
.message-info.sent {
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    align-items: flex-start;
    font-size: 12px;
    color: black;
    margin-left: 0px;
    position: absolute;
    left: -70px;
}

.message-info.received {
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    align-items: flex-start;
    font-size: 12px;
    color: black;
    margin-left: 0px;
    position: absolute;
    right: -70px;  /* 右側に寄せて表示 */
	}

.message-info .read-flag {
    color: green;
    margin-left: 10px; /* 時間と既読フラグの間隔 */
}


/* 入力部分 */
.input-container {
	display: flex;
	padding: 10px;
	background-color: #fff;
	border-top: 1px solid #ddd;
	width: 100%;
	max-width: 400px;
	margin: 0 auto;
}

.input-box {
	flex-grow: 1;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 5px;
	margin-right: 5px;
}

.send-button {
	background-color: #007D7A;
	color: white;
	border: none;
	border-radius: 5px;
	padding: 10px 15px;
	cursor: pointer;
	font-size: 14px;
}

.send-button:hover {
	background-color: #005f5b;
}

a {
	text-decoration: none;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	const recipientId =
<%=recipientId%>
	;
	const roomId =
<%=roomId%>
	;
	function sendMessage() {
	    const message = $('.input-box').val();
	    $.post("/knowit/Chat", {
	        roomId: roomId,
	        message: message,
	        recipientId: recipientId
	    }, function(response) {
	        if (response === "success") {
	            $('.input-box').val('');
	            loadMessages();
	        }
	    });
	}


	//function loadMessages() {
	//	$.get("/knowit/Chat", {
	//		roomId : roomId
	//	}, function(response) {
	//		$('.chat-container').html(response);
	//	});
	//}
function loadMessages() {
    $.get("/knowit/Chat", {
        roomId: roomId
    }, function(response) {
        $('.chat-container').html(response);

        // メッセージ表示後にスクロール位置を最下部に設定
        var chatContainer = $('.chat-container')[0];
        chatContainer.scrollTop = chatContainer.scrollHeight;
    });
}


		
$(document).ready(function() {
    loadMessages();
    // ページが読み込まれた時にスクロール位置を最下部に設定
    var chatContainer = $('.chat-container')[0];
    chatContainer.scrollTop = chatContainer.scrollHeight;
});

</script>
</head>

<body>
	<div class="header">
		<button class="back-button" onclick="history.back();">
			<i class="fas fa-chevron-left"></i>
		</button>
		<div class="username"><%=name%></div>
	</div>
	<div class="chat-container">
		<!-- ここにメッセージが動的に追加される -->
	</div>
	<div class="input-container">
		<input type="text" class="input-box" placeholder="メッセージを入力..." />
		<button class="send-button" onclick="sendMessage()">送信</button>
	</div>
</body>

</html>
