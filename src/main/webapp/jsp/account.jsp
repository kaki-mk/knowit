<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"> <!-- Font Awesomeのリンク -->
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@700&display=swap" rel="stylesheet"> <!-- フォントのリンク -->
<title>アカウント情報</title>

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
    text-align: center;
    display: flex; /* ヘッダー内の要素を横並びに */
    align-items: center; /* 縦方向の中央揃え */
    justify-content: center; /* 左右に配置を中央に */
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
    color: white;
    font-family: 'Roboto', serif; /* 画像に合わせたフォントを指定 */
    margin: 0; /* マージンをリセット */
    margin-top: 20px;
    flex-grow: 1; /* h1が余分なスペースを占める */
    text-align: center; /* テキストを中央揃え */
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

.profile-photo {
    width: 80px;
    height: 80px;
    border: 1px solid #000;
    border-radius: 50%;
    margin: 0 auto 15px;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer; /* クリック可能であることを示す */
    margin: 0 auto 25px; /* 下に20pxの余白を追加 */
}

.profile-photo p {
    font-size: 12px;
    margin-top: 5px;
}

.info {
    text-align: left;
    margin: 15px 0; /* 上下の間隔を増やす */
    display: flex;
    align-items: center;
    flex-wrap: nowrap; /* 改行を防ぐ */
}

.info label {
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
    color: #000;
    transition: transform 0.3s ease, border-color 0.3s ease; /* アニメーションの追加 */
}

.info input:focus {
    transform: scale(1.05); /* フォーカス時に少し拡大 */
    border-bottom: 2px solid #007D7A; /* フォーカス時の下線の色を変更 */
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

.hozon-btn {
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;
    width: 150px;
    margin: 20px auto; /* 上下に20pxの余白、左右は中央揃え */
    margin-top: 50px; /* ボタンをさらに下に移動 */
    padding: 0.6em 2em;
    border: 1px solid #007d7a;
    border-radius: 10px;
    background-color: #fff; /* 通常時の背景色 */
    color: #007d7a; /* 通常時の文字色 */
    font-size: 1em;
    transition: all 0.3s ease; /* スムーズな変化を追加 */
}

.hozon-btn:hover {
    background-color: #007d7a; /* ホバー時の背景色を白に */
    color: #fff; /* ホバー時の文字色を通常時の背景色に */
    border: 1px solid #007d7a; /* ボーダー色も調整 */
}

@keyframes anima-hozon-btn {
    0% {
        box-shadow: 0 0 0 0 rgb(0 125 122 / 50%);
    }
    100% {
        box-shadow: 0 0 0 1.2em rgb(0 0 0 / 0%);
    }
}

/* 非表示のファイル入力 */
.file-input {
    display: none; /* 隠す */
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

    <div class="container">
        <div class="profile-photo"
            onclick="document.getElementById('file-input').click();">
            <p>写真を編集</p>
        </div>
        <input type="file" id="file-input" class="file-input" accept="image/*"
            onchange="previewImage(event)">

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

        <button type="submit" class="hozon-btn">保存</button>
    </div>

    <script>
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

        function previewImage(event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const profilePhoto = document
                            .querySelector('.profile-photo p');
                    profilePhoto.textContent = ''; // テキストを空にする
                    const img = document.createElement('img');
                    img.src = e.target.result;
                    img.style.width = '80px'; // 幅を指定
                    img.style.height = '80px'; // 高さを指定
                    img.style.borderRadius = '50%'; // 円形にする
                    img.style.objectFit = 'cover'; // 画像のトリミング
                    profilePhoto.appendChild(img); // 画像を追加
                };
                reader.readAsDataURL(file);
            }
        }
    </script>
</body>
</html>
                    
