<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Base64" %>
<%
    // リクエスト属性からBase64エンコードされた画像を取得
    String base64Image = (String) request.getAttribute("base64Image");
    String msg = (String)request.getAttribute("msg"); %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>account information</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: Arial, sans-serif;
	display: flex;
	justify-content: center;
	align-items: center;
	width: 90vw; /* 画面幅の90% */
	height: 90vh; /* 画面高さの90% */
	margin: 0 auto;
	padding: 20px;
	background-color: #007D7A;
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
	font-size: 20px; /* h1のフォントサイズを調整 */
	color: white;
	text-align: center; /* テキストを中央揃え */
	flex-grow: 1; /* h1が余分なスペースを占める */
	margin: 0; /* マージンをリセット */
}

.container {
	width: 320px;
	padding: 30px; /* 余白を増加 */
	border: 1px solid #007D7A;
	border-radius: 15px;
	background-color: #fff;
	text-align: center;
	box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2); /* 影を追加して浮き上がった印象に */
}

.container h1 {
	font-size: 20px;
	margin-bottom: 20px;
}

.profile-photo {
	width: 80px;
	height: 80px;
	border: 1px solid #000;
	border-radius: 50%;
	margin: 0 auto 50px; /* 下の余白を調整 */
	display: block; /* 横並びではなく縦並びにする */
	text-align: center; /* テキストを中央揃え */
	cursor: pointer; /* クリック可能であることを示す */
}

.profile-photo p {
	font-size: 12px;
	margin-top: 2px; /* 画像とテキストの間に少し余白を追加 */
}


.info {
	text-align: left;
	margin: 15px 0; /* 上下の間隔を増やす */
	display: flex;
	align-items: center;
	flex-wrap: nowrap; /* 改行を防ぐ */
}

.info label {
	font-weight: bold;
	width: 60px;
}

.info input {
	font-size: 14px;
	padding: 8px; /* 入力フィールドの余白を増加 */
	flex: 1;
	border: none;
	border-bottom: 1px solid lightgray; /* 下線の色をライトグレーに変更 */
	outline: none;
	margin-right: 10px;
	box-sizing: border-box;
	color: rgba(0, 0, 0, 0.5); /* 入力文字を半透明にする */
}

.info input::placeholder {
	color: rgba(0, 0, 0, 0.5); /* プレースホルダーの色を半透明にする */
}

.password {
	display: flex;
	align-items: center;
	flex: 1;
	position: relative;
}

.password input {
	width: 100%;
}

.password .eye-icon {
	position: absolute;
	right: 10px;
	cursor: pointer;
}

.logout-btn {
	width: 100%;
	padding: 10px;
	font-size: 1em;
	color: #fff;
	background-color: #007D7A;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	margin-top: 10px;
}

.logout-btn:hover {
	background-color: #333;
}

/* 非表示のファイル入力 */
.file-input {
	display: none; /* 隠す */
}

/* フォーカス時（クリックされた時）の背景を白に変更 */
form input[type="text"]:focus, form input[type="password"]:focus {
	width: 280px;
	background-color: #ffffff; /* 背景を白に */
	color: #000; /* テキストの色を黒に */
}
</style>
</head>
<body>
	<div class="header">
		<button class="back-button" onclick="history.back();">
			<i class="fas fa-chevron-left"></i>
		</button>
		<h1>Account Information</h1>
	</div>
<form action="AccountServlet" method="post"enctype="multipart/form-data">
	<div class="container">

			        <h1 style="color: #000">アカウント情報</h1>
			
			<div class="profile-photo" onclick="document.getElementById('file-input').click();">
    <!-- 画像表示：base64エンコードされた画像を表示 -->
    <img id="profile-image" src="data:image/jpeg;base64,<%= base64Image %>" alt="ユーザーアイコン">
    <p>写真を編集</p>
</div>

<input type="file" id="file-input" class="file-input" accept="image/*"
    onchange="previewImage(event)" name="ICON">

		<div class="info">
			<label for="name">Name</label> <input type="text" name="NAME"
				placeholder="名前">
		</div>
		<div class="info">
			<label for="password">Pass</label>
			<div class="password">
				<input type="password" id="password" name="PASS" placeholder="パスワード">
				<span class="eye-icon" onclick="togglePassword()">👁️</span>
			</div>
		</div>


		<button type="submit" class="logout-btn">保存</button>
		
	<!-- msgを画面下に表示して欲しいです -->
	<%if(msg != null){ %>
	<p><%=msg %></p>
	<%} %>
	</div>
	</form>
	

<script>
    // パスワード表示/非表示切り替え
	function togglePassword() {
		const passwordField = document.getElementById('password');
		const eyeIcon = document.querySelector('.eye-icon');

		if (passwordField.type === 'password') {
			passwordField.type = 'text';
			eyeIcon.textContent = '🙈'; // 表示アイコンを切り替える
		} else {
			passwordField.type = 'password';
			eyeIcon.textContent = '👁️';
		}
	}

	// 画像のプレビュー処理
	function previewImage(event) {
		const file = event.target.files[0];
		if (file) {
			const reader = new FileReader();
			reader.onload = function(e) {
				// 現在の画像を新しい画像に差し替える
				const img = document.getElementById('profile-image');
				img.src = e.target.result; // 新しい画像に更新

				// 画像のスタイルを適用
				img.style.width = '80px'; // 幅を指定
				img.style.height = '80px'; // 高さを指定
				img.style.borderRadius = '50%'; // 円形にする
				img.style.objectFit = 'cover'; // 画像のトリミング
			};
			reader.readAsDataURL(file);
		}
	}

	// ページ読み込み後に画像スタイルを適用
	window.onload = function() {
		const img = document.getElementById('profile-image');
		
		// 画像のスタイルを適用
		img.style.width = '80px'; // 幅を指定
		img.style.height = '80px'; // 高さを指定
		img.style.borderRadius = '50%'; // 円形にする
		img.style.objectFit = 'cover'; // 画像をトリミングしてフィットさせる
	};
</script>


</body>
</html>
