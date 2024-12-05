<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>パスワード再登録 - Know IT</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style>
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
	position: relative; /* 相対位置を指定 */
}

.header {
	color: white; /* 白文字 */
	display: flex;
	align-items: center;
	position: absolute; /* 絶対位置を指定 */
	top: 20px; /* 上からの位置を指定 */
	width: 100%; /* 幅を100%に */
}

.back-button {
	color: white;
	text-decoration: none;
	font-size: 18px;
	margin-right: 10px; /* ボタンとタイトルの間のマージン */
}

.header h1 {
	flex-grow: 1; /* タイトルが横に広がるようにする */
	text-align: center; /* タイトルを中央揃え */
	margin: 0; /* マージンを削除 */
}

.container {
	text-align: center;
	border: 2px solid #007D7A;
	border-radius: 20px;
	padding: 40px; /* パディングを増加 */
	background-color: #fff;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	width: 320px; /* 幅を少し広げる */
}

h1 {
	font-size: 24px;
	margin: 0; /* マージンを削除 */
}

.input-field {
	margin: 15px 0; /* 上下のマージンを増加 */
	text-align: left;
	width: 100%; /* 幅を100%に */
}

.input-field label {
	margin-bottom: 10px; /* ラベルと入力フィールドの間隔を増加 */
	display: block; /* ブロック要素として表示 */
}

.underline {
	border-bottom: 1px solid lightgray;
	margin-top: 5px;
}

.button {
	background-color: #007D7A;
	color: #fff;
	border: none;
	border-radius: 5px;
	padding: 12px 20px; /* パディングを増加 */
	cursor: pointer;
	font-size: 16px;
	margin-top: 30px; /* マージンを増加 */
	transition: background-color 0.3s;
}

.button:hover {
	background-color: #333;
}

</style>
<script>
function submitForm() {
	// ここにパスワードの確認処理を追加することができます
	location.href = 'index.jsp'; // index.jspに遷移
}
</script>
</head>
<body>

	<div class="header">
		<a href="passmail.jsp" class="back-button"> <!-- 戻るボタン -->
			<i class="fas fa-chevron-left"></i>
		</a>
		<h1>パスワード再登録</h1> <!-- タイトル -->
	</div>

	<div class="container">
		<div class="input-field">
			<label class="pass" for="pass">New password</label> 
			<input
				type="password" id="pass" name="PASS" placeholder="新しいパスワード" 
				style="width: 100%; border: none; outline: none;">
			<div class="underline"></div>
		</div>
		
		<button class="button" type="button" onclick="submitForm()">再登録</button>
		
	</div>

</body>
</html>
