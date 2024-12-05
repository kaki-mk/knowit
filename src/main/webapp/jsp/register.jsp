<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Know IT 登録</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	display: flex; /* フレックスボックスを使用 */
    flex-direction: column; /* 縦方向に配置 */
    align-items: center; /* 水平方向に中央揃え */
    justify-content: center; /* 垂直方向に中央揃え */
    height: 100vh; /* 画面全体の高さを確保 */
    margin: 0; /* 余白をリセット */
    background-color: #007D7A; /* 背景色を設定 */
    font-family: Arial, sans-serif; /* フォントを設定 */
    color: white; /* 全体の文字色を白に設定 */
}

.header {
	color: white; /* 白文字 */
	display: flex;
	align-items: center;
	justify-content: space-between; /* 左右に配置 */
	position: absolute; /* 絶対位置を指定 */
	top: -5px; /* 上からの位置を指定 */
	left: 25px;
	width: 100%; /* 幅を100%に */
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
	margin-top: 0; /* 上部の余白をリセット */
    margin-bottom: 20px; /* 下部の余白 */
    font-size: 36px; /* フォントサイズ */
    font-weight: bold; /* 太字に設定 */
    text-align: center; /* 中央揃え */
}

.container {
	background-color: white; /* フォームの背景色 */
    padding: 20px; /* 内側の余白 */
    border-radius: 10px; /* 角を丸める */
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1); /* 影を追加 */
    width: 300px; /* 固定幅 */
    text-align: center; /* 中央揃え */
}

.upload-container {
	position: relative;
	display: inline-block;
}

.upload-button {
	position: absolute;
	bottom: 3px;
	right: 0px;
	background-color: white;
	border: 2px solid black; /* 境界の色 */
	border-radius: 50%;
	width: 25px;
	height: 25px;
	cursor: pointer;
	font-size: 20px;
	text-align: center;
}

#profilePic {
	width: 80%;
	height: 80%;
	border-radius: 50%;
	display: none;
}

.form-container {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	flex-wrap: wrap;
	margin-bottom: 50px;
}

.radio-container {
	text-align: left;
	flex: 1; /* フレックスボックスの設定 */
	min-width: 150px; /* 最小幅を設定 */
	margin-right: 20px; /* 右のマージンを追加 */
}

.photo-upload {
	text-align: center;
	flex: 0 0 100px; /* 固定幅を設定 */
}

.custom-radio {
	display: none; /* 元のラジオボタンを非表示にする */
}

.custom-radio-label {
	position: relative;
	padding-left: 30px;
	cursor: pointer;
	user-select: none;
	color: #000000;
}

.custom-radio-label:before {
	content: '';
	position: absolute;
	left: 0;
	top: 50%;
	transform: translateY(-50%);
	width: 15px; /* カスタムラジオボタンのサイズ */
	height: 15px;
	border: 2px solid black; /* 境界の色 */
	border-radius: 50%; /* 丸型 */
	background-color: white; /* 背景色 */
}

.custom-radio:checked+.custom-radio-label:before {
	border: 2px solid black; /* チェック時の境界の色 */
	background-color: white; /* チェック時の背景色 */
}

.custom-radio:checked+.custom-radio-label:after {
	content: '';
	position: absolute;
	left: 4px; /* 中央に配置するための調整 */
	top: 65%;
	transform: translateY(-80%);
	width: 10px; /* 中央の点のサイズ */
	height: 10px;
	border-radius: 50%; /* 丸型 */
	background-color: black; /* 中央の点の色 */
}

.label {
	color: black; /* 黒色 */
	margin-top: 10px;
	display: block; /* ブロック要素 */
}

.input-field {
	margin: 10px 0; /* 上下のマージンを均等に */
	text-align: left;
	width: 100%; /* 幅を100%に */
}

.underline {
	border-bottom: 1px solid lightgray;
	margin-top: 5px;
}

.input-group {
	display: flex; /* フレックスボックスを使用 */
	justify-content: space-between; /* 等間隔に配置 */
	margin: 10px 0; /* 上下にスペースを追加 */
	flex-wrap: wrap; /* ラップを有効にする */
}

.input-group .input-field {
	flex: 1; /* 各フィールドが均等にスペースを取る */
	margin-right: 10px; /* フィールドの間にスペースを追加 */
	min-width: 120px; /* 最小幅を設定 */
}

.input-group .input-field:last-child {
	margin-right: 0; /* 最後のフィールドにはマージンを適用しない */
}

/* 登録ボタンのスタイル */
.register-button {
	background-color: #007D7A; /* 背景色 */
	color: white; /* 文字色 */
	border: none;
	border-radius: 10px; /* 丸みを帯びた角 */
	padding: 10px 20px; /* 内側にスペースを追加 */
	cursor: pointer;
	font-size: 16px; /* フォントサイズ */
	margin-top: 20px; /* 上部にスペースを追加 */
	width: 100%; /* 幅を100%に */
	max-width: 200px; /* 最大幅を設定 */
}

.register-button:hover {
	background-color: #333; /* ホバー時の色 */
}

/* プレースホルダーのスタイル（半透明） */
form input[type="text"]::placeholder, form input[type="password"]::placeholder
	{
	color: rgba(255, 255, 255, 0.5); /* 半透明の白 */
}

/* フォーカス時（クリックされた時）の背景を白に変更 */
form input[type="text"]:focus, form input[type="password"]:focus {
	width: 280px;
	background-color: #ffffff; /* 背景を白に */
	color: #000; /* テキストの色を黒に */
}

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
	.aaa {
		position: fixed;
		top: 20px; /* 上部からの距離 */
		left: 20px; /* 左側からの距離 */
	}
	
	.button:hover {
		background-color: #333;
	}
}


</style>
</head>
<body>
	<div class="header">
	<button class="back-button" onclick="window.location.href='index.jsp'">
			<i class="fas fa-chevron-left"></i>
		</button>
	</div>
	
	<h1>Know IT</h1>
		<!-- タイトル -->
	
	<form action="Register" method="post" enctype="multipart/form-data">
		<div
			style="border-radius: 20px; display: inline-block; padding: 25px; width: 300px; background-color: white; margin: 20px 20px 20px 20px;">
			<!-- 左側のマージンを調整 -->
			<div class="form-container"
				style="position: relative; padding: 10px;">
				<div class="radio-container">
					<input type="radio" id="student" name="TYPEID" value=102
						class="custom-radio"> <label for="student"
						class="custom-radio-label">Student</label><br> <input
						type="radio" id="teacher" name="TYPEID" value=101
						class="custom-radio"> <label for="teacher"
						class="custom-radio-label">Teacher</label>
				</div>

				<div class="photo-upload">
					<div class="upload-container"
						style="width: 80px; height: 80px; border: 2px solid black; border-radius: 50%; background-color: white; position: absolute; top: 10px; right: 10px;">
						<img id="profilePic" src="" alt="プロフィール画像"> <input
							type="file" accept="image/*" onchange="previewImage(event)"
							style="display: none;" id="upload" name="ICON">
						<button class="upload-button" type="button"
							onclick="document.getElementById('upload').click();">+</button>
					</div>
				</div>
			</div>

			<div class="input-field">
				<label class="label" for="id">ID</label> <input type="text" id="id"
					name="USERID" placeholder="学籍番号 , 社員番号"
					style="width: 100%; border: none; outline: none;">
				<div class="underline"></div>
			</div>
			<div class="input-field">
				<label class="label" for="email">Mail address</label> <input
					type="email" id="email" name="MAIL"
					style="width: 100%; border: none; outline: none;">
				<div class="underline"></div>
			</div>
			<div class="input-field">
				<label class="label" for="pass">Pass</label> <input type="password"
					id="pass" name="PASS" placeholder="パスワード"
					style="width: 100%; border: none; outline: none;">
				<div class="underline"></div>
			</div>

			<!-- ClassとNameを横に並べるためのinput-group -->
			<div class="input-group">
				<div class="input-field">
					<label class="label" for="class">Class</label> <select id="class"
						name="CLASS" placeholder="クラス"
						style="width: 100%; border: none; outline: none;"
						onchange="hideDefaultOption()">
						<option value="default" selected style="display: none;"></option>
						<option value="F1A1">F1A1</option>
						<option value="F1A2">F1A2</option>
						<option value="F2A1">F2A1</option>
						<option value="F2A2">F2A2</option>
						<option value="P1A1">P1A1</option>
						<option value="P1A2">P1A2</option>
						<option value="P2A1">P2A1</option>
						<option value="P2A2">P2A2</option>
						<option value="P3A1">P3A1</option>
						<option value="P3A2">P3A2</option>
						<option value="R1A1">R1A1</option>
						<option value="R2A1">R2A1</option>
						<option value="R3A1">R3A1</option>
						<option value="R4A1">R4A1</option>
					</select>
					<div class="underline"></div>
				</div>

				<div class="input-field">
					<label class="label" for="name">Name</label> <input type="text"
						id="name" name="NAME" placeholder="名前"
						style="width: 100%; border: none; outline: none;">
					<div class="underline"></div>
				</div>
			</div>
			<button type="submit" class="register-button">登録</button>
		</div>
	</form>

	<script>
		function previewImage(event) {
			const reader = new FileReader();
			reader.onload = function() {
				const output = document.getElementById('profilePic');
				output.src = reader.result;
				output.style.display = 'block';
			}
			reader.readAsDataURL(event.target.files[0]);
		}

		function hideDefaultOption() {
			const selectElement = document.getElementById('class');
			const defaultOption = selectElement.options[0];

			if (selectElement.value !== "default") {
				defaultOption.style.display = 'none'; // 初期オプションを非表示にする
			} else {
				defaultOption.style.display = 'block'; // 初期状態に戻したい場合は表示する
			}
		}
	</script>

</body>
</html>
