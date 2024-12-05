<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"> <!-- Font Awesomeのリンク -->
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@700&display=swap" rel="stylesheet"> <!-- フォントのリンク -->

<title>問題追加登録</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
/* 既存のスタイルをここに追加 */
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 20px;
	background-color: #007D7A;
}

.header {
	justify-content: space-between; /* 左右に配置 */
	padding: 0 20px;
	border-radius: 15px 15px 0 0;
	color: white;
	display: flex;
	align-items: center;
	position: fixed; /* 固定位置にする */
	top: 0; /* 上端に配置 */
	left: 0; /* 左端に配置 */
	width: 100%;
	height: 60px; /* ヘッダーの高さ */
	z-index: 1000; /* 他の要素より前面に表示 */
}

.back-button {
	background: none;
	border: none;
	color: white;
	cursor: pointer;
	font-size: 20px;
	margin-right: 10px;
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
	padding: 30px;
	border: 1px solid #007D7A;
	border-radius: 15px;
	background-color: #fff;
	box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.2);
	max-width: 700px;
	margin: 0 auto;
	position: relative;
	bottom: -80px;
}

.button-container {
	display: flex;
	justify-content: flex-end;
	margin-bottom: 20px;
}

.upload-btn, .confirm-btn, .register-btn {
	background-color: #007D7A;
	color: white;
	border: none;
	border-radius: 5px;
	padding: 10px 15px;
	cursor: pointer;
	font-size: 16px;
	margin-right: 10px;
}

.upload-btn:hover, .confirm-btn:hover, .register-btn:hover {
	background-color: #005f5b;
}

.file-name {
	font-size: 16px; /* フォントサイズ */
	color: #007D7A; /* 色を設定 */
	align-self: center; /* 垂直中央揃え */
	white-space: nowrap; /* テキストが折り返されないようにする */
}

.input-box {
	border: 1px solid #ccc;
	padding: 15px;
	margin-bottom: 20px;
	border-radius: 5px;
	min-height: 120px; /* 最小高さを調整 */
	font-size: 18px;
}

textarea {
	width: 100%; /* 幅を100%に設定 */
	min-height: 120px; /* 最小高さを設定 */
	border: none; /* ボーダーを削除 */
	outline: none; /* アウトラインを削除 */
	resize: none; /* リサイズを無効にする */
}

input[type="text"], select {
	width: 100%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 16px;
	box-sizing: border-box;
	margin-bottom: 20px;
}

/* ファイル入力を非表示にする */
input[type="file"] {
	display: none;
}

@media ( max-width : 600px) {
	.container {
		padding: 20px;
	}
	.header h1 {
		font-size: 40px;
	}
}
</style>
<script>
	function triggerFileUpload() {
		document.getElementById('file-upload').click(); // ファイル入力をクリック
	}

	function displayFileName() {
		const fileInput = document.getElementById('file-upload');
		const fileNameDisplay = document.getElementById('file-name');
		const confirmButton = document.getElementById('confirm-btn');

		if (fileInput.files.length > 0) {
			fileNameDisplay.textContent = fileInput.files[0].name; // ファイル名を表示
			confirmButton.style.display = 'inline-block'; // 確定ボタンを表示
		} else {
			fileNameDisplay.textContent = ''; // ファイルが選択されていない場合は空に
			confirmButton.style.display = 'none'; // 確定ボタンを非表示
		}
	}
</script>
</head>
<body>
	<div class="header">
		<button class="back-button"
			onclick="window.location.href='t-home.jsp'">
			<i class="fas fa-chevron-left"></i>
		</button>
		<h1>Question-Register</h1>
	</div>
	<form action="QUESTION" method="post">
		<div class="container">
			<div class="button-container">
				<div class="file-name" id="file-name" style="margin-right: 10px;"></div>
				<button type="button" class="upload-btn"
					onclick="triggerFileUpload()">[ + アップロード ]</button>
				<button type="button" id="confirm-btn" class="confirm-btn"
					onclick="confirmUpload()" style="display: none;">確定</button>
			</div>

			<input type="file" id="file-upload" name="image" accept="image/*"
				onchange="displayFileName()">

			<div>
				<div>
					<h2>問題</h2>
					<div class="input-box">
						<textarea placeholder="ここに問題を入力してください" required rows="5"
							style="border: none; width: 100%; height: 100%; outline: none; resize: none;"></textarea>
					</div>
				</div>
				<div>
					<h2>カテゴリー</h2>
					<select name="category" required>
						<option value="" disabled selected>カテゴリーを選択してください</option>
						<option value="security">セキュリティ</option>
						<option value="network">ネットワーク</option>
						<option value="database">データベース</option>
					</select>
				</div>
				<div>
					<h2>解説</h2>
					<div class="input-box">
						<textarea placeholder="解説を入力してください" required rows="5"
							style="border: none; width: 100%; height: 100%; outline: none; resize: none;"></textarea>
					</div>
				</div>
				<button type="submit" class="register-btn">登録</button>
			</div>
	</form>
</body>
</html>
