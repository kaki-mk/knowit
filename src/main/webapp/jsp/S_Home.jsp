<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Know IT</title>
<style>
body {
	background-color: #007D7A; /* 背景色を#007D7Aに変更 */
	color: white; /* テキストを見やすくするために色を白に */
}

#menu {
	display: none;
	position: fixed;
	bottom: 0;
	left: 0;
	right: 0;
	background-color: white;
	box-shadow: 0 -2px 5px rgba(0, 0, 0, 0.2);
	animation: slideUp 0.7s forwards;
	padding: 30px;
}

@keyframes slideUp {
	from { transform: translateY(100%); }
	to { transform: translateY(0); }
}

.menu-header {
	padding: 10px 0;
	font-size: 15px;
	text-align: center;
	border-radius: 5px 5px 0 0;
}

.menu-bar {
	width: 10%;
	height: 5px;
	background-color: lightgray;
	margin: 0 auto 10px;
	border-radius: 5px;
}

.menu-item {
	margin: 30px 0;
	cursor: pointer;
	font-size: 20px;
	text-align: center;
	position: relative;
}

.menu-item::after {
	content: "";
	display: block;
	width: 70%;
	height: 2px;
	background-color: lightgray;
	margin: 5px auto 0;
	position: relative;
	top: 5px;
}

button, #upload-label {
	background-color: white; /* ボタンの色を白に変更 */
	color: #007D7A; /* ボタン上のテキスト色を変更 */
	border: none; /* ボタンのボーダーをなしに */
}

#upload-label {
    border: 2px solid #ccc;
    border-radius: 15px;
    display: inline-block;
    padding: 30px;
    cursor: pointer;
    position: relative;
    height: auto;
    width: auto;
    margin-bottom: 40px; /* Nextボタンとの間隔 */
    center: -10px; /* アップロードボタンを少し上に */
}

#next-button {
	width: 100px;
	padding: 10px 20px;
	font-size: 25px;
	border-radius: 5px;
	color: #007D7A; /* テキスト色 */
	cursor: pointer;
}

h1 {
	color: white; /* ヘッダーのタイトル色を白に */
}

a{
	color: #333333;
	text-decoration: none;
}
</style>
</head>
<body>
	<header>
		<h1 style="display: inline;">Know IT</h1>
		<div style="display: inline; float: right; font-size: 28px;">
			<div style="display: inline; cursor: pointer; margin-left: 10px;">
			<!-- 
			<img src="img2/chat.png" alt="Chat"> -->
			<a href="ChatListServlet">💬</a>
			</div>
			<div id="menu-toggle"
				style="display: inline; cursor: pointer; margin-left: 10px;">☰</div>
		</div>
	</header>
    
	<main>
		<form id="upload-form" method="post" action="S_Home"
			enctype="multipart/form-data">
			<div style="text-align: center; margin-top: 50px;">
				<label id="upload-label" for="file-upload">
					<span id="upload-text" style="font-size: 20px"><br><br>[ + アップロード ]<br><br><br></span> <img id="image-preview"
					src="" alt="プレビュー"
					style="max-width: 100%; max-height: 200px; display: none; border-radius: 15px;" />
				</label> <input type="file" id="file-upload" accept="image/*" name="image" required
					style="display: none;" />
			</div>
			<div id="next-button-container"
				style="text-align: center; margin-top: 20px;">
				<button id="next-button" type="submit">Next</button>
			</div>
		</form>
	</main>

	<div id="menu" style="color: Black">
		<div class="menu-bar" style="color: Black"></div>
		<div class="menu-header" style="color: Black">メニュー</div>
		<div class="menu-item" style="color: Black"><a href="Bookmarkservlet" style="text-decoration:none;">ブックマーク</div>
		<div class="menu-item" style="color: Black"><a href="Historyservlet" style="text-decoration:none;">問題履歴</div>
		<div class="menu-item" style="color: Black"><a href="AccountServlet" style="text-decoration:none;">アカウント情報</div>
	<div class="menu-item" style="color: Black"><a href="LogoutServlet" style="text-decoration:none;">ログアウト</a></div>
	</div>

	<script>
		document
				.getElementById('file-upload')
				.addEventListener(
						'change',
						function(event) {
							const file = event.target.files[0];
							if (file) {
								const reader = new FileReader();
								reader.onload = function(e) {
									const img = document
											.getElementById('image-preview');
									img.src = e.target.result;
									img.style.display = 'block';

									const label = document
											.getElementById('upload-label');
									label.style.border = 'none';
									label.style.padding = '0';

									const uploadText = document
											.getElementById('upload-text');
									uploadText.style.display = 'none';

									const nextButtonContainer = document
											.getElementById('next-button-container');
									nextButtonContainer.style.marginTop = img.offsetHeight
											+ 20 + 'px';
								}
								reader.readAsDataURL(file);
							}
						});

		document.getElementById('menu-toggle').addEventListener(
				'click',
				function() {
					const menu = document.getElementById('menu');
					menu.style.display = menu.style.display === 'none'
							|| menu.style.display === '' ? 'block' : 'none';
				});
	</script>
</body>
</html>
