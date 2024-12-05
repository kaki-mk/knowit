<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<title>Know IT Home</title>

<style>

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	background-color: #007D7A;
	display: flex;
	justify-content: center;
	align-items: center;
	position: relative;
}

header {
    display: flex;
    align-items: center; /* 縦方向の中央揃え */
    justify-content: space-between; /* 左右に配置 */
    width: 100%; /* 幅を100%に設定 */
    position: fixed; /* 固定位置 */
    top: 10px; /* 上からの距離 */
    background-color: #007D7A; /* 背景色を設定 */
    z-index: 1000; /* 他の要素の上に表示されるように */
    
}

h1 {
	color: white;
	font-size: 30px;
	margin-right: auto; /* 自動マージンで左側に寄せる */
	padding: 0 5px; /* 左右にパディングを追加 */
}



.icons {
	display: flex;
	align-items: center;
	gap: 15px;
	

}

/* アイコンボタンのスタイル */
.icon-button {
	background: none;
	border: none;
	cursor: pointer;
	color: #fff; /* アイコンの色を白に変更 */
	font-size: 20px;
	padding: 10px;
	margin-left: -20px; /* 左側にマイナスマージンを追加 */
}

.icon-button:focus {
	outline: none;
}

/* コンテナ */
.container {
	width: 100%;
	max-width: 400px;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	overflow: hidden;
	margin: 0px auto; /* 中央に配置 */
	flex: 0 1 auto; /* 高さを自動に設定 */
	margin-top: 90px; /* 上部の余白を追加 */
}

/* メッセージリスト */
.message-list {
	padding: 15px;
	max-height: 600px; /* 高さを設定（必要に応じて調整） */
	overflow-y: auto; /* スクロール可能に */
	max-height: calc(100vh - 160px); /* ヘッダーとボタンを考慮 */
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

.add-button {
	position: fixed;
	bottom: 80px;
	right: 7px;
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

/* モバイル表示のためのレスポンシブ設定 */
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
}
</style>
</head>

<body>

	<!-- Header -->
	<header>
    <h1>Know IT</h1>
    <div class="icons">
        <button class="icon-button" aria-label="User" onclick="location.href='account.jsp';">
            <i class="fas fa-user"></i>
        </button>
        <button class="icon-button" aria-label="Chat" onclick="location.href='s-chatlist.jsp';">
            <i class="fas fa-comments"></i>
        </button>
    </div>
	</header>

	<div class="container">
		<!-- Message List -->
		<div class="message-list">
			<div class="message-item">
				<div class="message-icon"></div>
				<div class="message-text">〇〇さんがメッセージを・・</div>
			</div>
			<div class="message-item">
				<div class="message-icon"></div>
				<div class="message-text">〇〇さんがメッセージを・・</div>
			</div>
			<div class="message-item">
				<div class="message-icon"></div>
				<div class="message-text">〇〇さんがメッセージを・・</div>
			</div>
			<div class="message-item">
				<div class="message-icon"></div>
				<div class="message-text">〇〇さんがメッセージを・・</div>
			</div>
			<div class="message-item">
				<div class="message-icon"></div>
				<div class="message-text">〇〇さんがメッセージを・・</div>
			</div>
			<div class="message-item">
				<div class="message-icon"></div>
				<div class="message-text">〇〇さんがメッセージを・・</div>
			</div>
			<div class="message-item">
				<div class="message-icon"></div>
				<div class="message-text">〇〇さんがメッセージを・・</div>
			</div>
			<div class="message-item">
				<div class="message-icon"></div>
				<div class="message-text">〇〇さんがメッセージを・・</div>
			</div>
			<div class="message-item">
				<div class="message-icon"></div>
				<div class="message-text">〇〇さんがメッセージを・・</div>
			</div>
			<div class="message-item">
				<div class="message-icon"></div>
				<div class="message-text">〇〇さんがメッセージを・・</div>
			</div>
			<div class="message-item">
				<div class="message-icon"></div>
				<div class="message-text">〇〇さんがメッセージを・・</div>
			</div>
			<div class="message-item">
				<div class="message-icon"></div>
				<div class="message-text">〇〇さんがメッセージを・・</div>
			</div>
		</div>
	</div>

	<!-- Floating Add Button -->
	<div class="add-button">
	    <a href="q-register.jsp" style="color: #007D7A; text-decoration: none;">+</a>
	    <button class=".add-button"  onclick="location.href='account.jsp';"></button>
	</div>

</body>

</html>
