<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Know IT Screen</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: Arial, sans-serif;
	background-color: #fff;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	position: relative;
}

.container {
	width: 100%;
	max-width: 400px;
	/* Limits the width for larger screens */
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	overflow: hidden;
}

/* Header */
.header {
	display: flex;
	align-items: center;
	padding: 15px;
	background-color: #007D7A;
}

.header .logo {
	font-weight: bold;
	color: #000;
	font-size: 20px;
	margin-right: auto;
}

.header .icons {
	display: flex;
	align-items: center;
	gap: 15px;
}

/* Icon Button Styles */
.icon-button {
	background: none;
	border: none;
	cursor: pointer;
	color: #000;
	font-size: 20px;
	padding: 0;
}

.icon-button:focus {
	outline: none;
}

/* Message List */
.message-list {
	padding: 15px;
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
	/* 下から20pxの位置 */
	right: 7px;
	/* 右から20pxの位置 */
	width: 60px;
	height: 60px;
	background-color: #007D7A;
	border-radius: 50%;
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 30px;
	color: #000;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	cursor: pointer;
	z-index: 9999;
}

.add-button:hover {
	background-color: #007D7A;
}

/* モバイル表示のためのレスポンシブ設定 */
@media ( max-width : 480px) {
	.container {
		max-width: 90%;
		/* スマホ画面向けに最大幅を設定 */
		padding: 10px;
	}
	.header .logo {
		font-size: 18px;
		/* ロゴサイズ調整 */
	}
	.message-text {
		font-size: 12px;
		/* メッセージのフォントサイズ調整 */
	}
	.add-button {
		position: fixed;
		bottom: 80px; /* 下からの位置 */
		right: 20px; /* 右からの位置 */
		width: 60px;
		height: 60px;
		background-color: #007D7A;
		border-radius: 50%;
		display: flex;
		justify-content: center;
		align-items: center;
		font-size: 30px;
		color: #000;
		box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
		cursor: pointer;
		z-index: 9999;
	}
	.add-button a {
		text-decoration: none; /* リンクの下線を消す */
		color: inherit; /* 親要素の色を継承 */
		display: flex;
		justify-content: center;
		align-items: center;
		width: 100%;
		height: 100%;
	}
	.add-button:hover {
		background-color: #005f5b; /* ホバー時の色 */
	}

	/* モバイルでも＋ボタンが表示されるように */
	@media ( max-width : 480px) {
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
}
</style>
</head>

<body>
	<div class="container">
		<!-- Header -->
		<div class="header">
			<div class="logo">Know IT</div>
			<div class="icons">
				<button class="icon-button" aria-label="User">
					<i class="fas fa-user"></i>
					<!-- Person Icon -->
				</button>
				<button class="icon-button" aria-label="Chat">
					<i class="fas fa-comments"></i>
					<!-- Chat Icon -->
				</button>
			</div>
		</div>

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
		</div>
	</div>

	<!-- Floating Add Button -->
	<div class="add-button">
		<a href="teacherregistrater.jsp">+</a>
	</div>

</body>

</html>