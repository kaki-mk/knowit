<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"> <!-- Font Awesomeのリンク -->
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@700&display=swap" rel="stylesheet"> <!-- フォントのリンク -->

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
	justify-content: center;
	align-items: center;
	height: 100vh;
	position: relative;
}

.header {
	display: flex; /* ヘッダー内の要素を横並びに */
	align-items: center; /* 縦方向の中央揃え */
	justify-content: space-between; /* 左右に配置 */
	width: 100%; /* 幅を100%に設定 */
	position: absolute; /* 絶対位置 */
	top: 20px; /* 上からの距離 */
	padding: 0 20px; /* 左右のパディング */
}

.back-button {
	background-color: #007D7A; /* 背景色 */
	color: white; /* 文字色 */
	border: none; /* 枠線なし */
	border-radius: 5px; /* 角を丸くする */
	padding: 8px; /* 内側の余白 */
	cursor: pointer; /* ホバー時にカーソルをポインタに */
	font-size: 16px; /* フォントサイズ */
}

h1 {
	font-size: 40px; /* h1のフォントサイズを調整 */
	color: white; /* テキストカラーを指定 */
	font-family: 'Roboto', serif; /* 画像に合わせたフォントを指定 */
	margin: 0; /* マージンをリセット */
	text-align: center; /* テキストを中央揃え */
	position: absolute; /* 位置を絶対位置に設定 */
	top: 10%; /* 上からの距離を調整 */
	left: 50%; /* 左からの位置を50%に設定 */
	transform: translateX(-50%); /* 水平方向に中央揃え */
}
.container {
	width: 100%;
	max-width: 400px;
	background-color: #fff;
	border-radius: 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	overflow: hidden;
	top: 50px;
}

/* Message List */
.message-list {
    padding: 15px;
    max-height: 600px; /* 高さを設定（必要に応じて調整） */
    overflow-y: auto; /* 垂直方向にスクロール可能に */
    overflow-x: hidden; /* 水平方向のオーバーフローを隠す */
}

.message-item {
	display: flex;
	align-items: center;
	padding: 10px;
	border-bottom: 1px solid #ddd;
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
}

.message-text {
	color: #333;
	font-size: 14px;
}

/* Floating Add Button */
.add-button {
	position: fixed;
	bottom: 80px;
	right: 20px;
	width: 60px;
	height: 60px;
	background-color: white;
	border-radius: 50%;
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 30px;
	color: #007D7A;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	cursor: pointer;
	z-index: 9999;
}

/* Icon Button Styles */
.icon-button {
	background: none;
	border: none;
	cursor: pointer;
	color: white;
	font-size: 20px;
	padding: 0;
	position: absolute;
	top: 15px;
	right: 70px; /* アイコンボタンの位置を調整 */
}

.icon-button:focus {
	outline: none;
}

@media (max-width: 480px) {
	.container {
		max-width: 90%;
		padding: 10px;
	}
	.header .logo {
		font-size: 18px;
	}
	.message-text {
		font-size: 12px;
	}
	.add-button {
		bottom: 80px;
		right: 7px;
		transform: translateX(-50%);
		z-index: 9999;
	}
}
</style>
</head>

<body>
	<div class="header">
		<button class="back-button" onclick="history.back();">
			<i class="fas fa-chevron-left"></i> 
		</button>
		<h1>Chat</h1>
	</div>	

	<div class="container">

		<!-- Message List -->
		<form action="CHATROOM" method="post">
		<div class="message-list">
			<div class="message-item" onclick="location.href='s-chat.jsp';">
				<div class="message-icon"></div>
				<div class="message-text">ここに直前までのメッセージ</div>
			</div>
			<div class="message-item" onclick="location.href='s-chat.jsp';">
				<div class="message-icon"></div>
				<div class="message-text">ここに直前までのメッセージ</div>
			</div>
			<div class="message-item" onclick="location.href='s-chat.jsp';">
        		<div class="message-icon"></div>
        		<div class="message-text">ここに直前までのメッセージ</div>
   		 	</div>
   		 	<div class="message-item" onclick="location.href='s-chat.jsp';">
				<div class="message-icon"></div>
				<div class="message-text">ここに直前までのメッセージ</div>
			</div>
			<div class="message-item" onclick="location.href='s-chat.jsp';">
				<div class="message-icon"></div>
				<div class="message-text">ここに直前までのメッセージ</div>
			</div>
			<div class="message-item" onclick="location.href='s-chat.jsp';">
        		<div class="message-icon"></div>
        		<div class="message-text">ここに直前までのメッセージ</div>
   		 	</div>
   		 	<div class="message-item" onclick="location.href='s-chat.jsp';">
				<div class="message-icon"></div>
				<div class="message-text">ここに直前までのメッセージ</div>
			</div>
			<div class="message-item" onclick="location.href='s-chat.jsp';">
				<div class="message-icon"></div>
				<div class="message-text">ここに直前までのメッセージ</div>
			</div>
			<div class="message-item" onclick="location.href='s-chat.jsp';">
        		<div class="message-icon"></div>
        		<div class="message-text">ここに直前までのメッセージ</div>
   		 	</div>
   		 	<div class="message-item" onclick="location.href='s-chat.jsp';">
				<div class="message-icon"></div>
				<div class="message-text">ここに直前までのメッセージ</div>
			</div>
			<div class="message-item" onclick="location.href='s-chat.jsp';">
				<div class="message-icon"></div>
				<div class="message-text">ここに直前までのメッセージ</div>
			</div>
			<div class="message-item" onclick="location.href='s-chat.jsp';">
        		<div class="message-icon"></div>
        		<div class="message-text">ここに直前までのメッセージ</div>
   		 	</div>
   		 	<div class="message-item" onclick="location.href='s-chat.jsp';">
				<div class="message-icon"></div>
				<div class="message-text">ここに直前までのメッセージ</div>
			</div>
			<div class="message-item" onclick="location.href='s-chat.jsp';">
				<div class="message-icon"></div>
				<div class="message-text">ここに直前までのメッセージ</div>
			</div>
			<div class="message-item" onclick="location.href='s-chat.jsp';">
        		<div class="message-icon"></div>
        		<div class="message-text">ここに直前までのメッセージ</div>
   		 	</div>
   		 	<div class="message-item" onclick="location.href='s-chat.jsp';">
				<div class="message-icon"></div>
				<div class="message-text">ここに直前までのメッセージ</div>
			</div>
			<div class="message-item" onclick="location.href='s-chat.jsp';">
				<div class="message-icon"></div>
				<div class="message-text">ここに直前までのメッセージ</div>
			</div>
			<div class="message-item" onclick="location.href='s-chat.jsp';">
        		<div class="message-icon"></div>
        		<div class="message-text">ここに直前までのメッセージ</div>
   		 	</div>
   		 	<div class="message-item" onclick="location.href='s-chat.jsp';">
				<div class="message-icon"></div>
				<div class="message-text">ここに直前までのメッセージ</div>
			</div>
			<div class="message-item" onclick="location.href='s-chat.jsp';">
				<div class="message-icon"></div>
				<div class="message-text">ここに直前までのメッセージ</div>
			</div>
			<div class="message-item" onclick="location.href='s-chat.jsp';">
        		<div class="message-icon"></div>
        		<div class="message-text">ここに直前までのメッセージ</div>
   		 	</div>
   		 	<div class="message-item" onclick="location.href='s-chat.jsp';">
				<div class="message-icon"></div>
				<div class="message-text">ここに直前までのメッセージ</div>
			</div>
			<div class="message-item" onclick="location.href='s-chat.jsp';">
				<div class="message-icon"></div>
				<div class="message-text">ここに直前までのメッセージ</div>
			</div>
			<div class="message-item" onclick="location.href='s-chat.jsp';">
        		<div class="message-icon"></div>
        		<div class="message-text">ここに直前までのメッセージ</div>
   		 	</div>
   		 	
		</div>
		</form>
	</div>

</body>

</html>
