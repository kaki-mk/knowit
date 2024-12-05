<!DOCTYPE html>
<html lang="ja">
<head>
<%@ page contentType="text/html; charset=UTF-8" %>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Know IT ログイン</title>
<style>
body {
    font-family: Arial, sans-serif;
    display: flex;
    flex-direction: column; /* 縦に並べる */
    justify-content: center;
    align-items: center;
    width: 90vw;
    height: 90vh;
    margin: 0 auto;
    padding: 20px;
    background-color: #007D7A;
}

 h1 {
    font-size: 30px;
    margin-bottom: 20px;
    color: white;
    text-align: center;
}

.container {
    width: 320px;
    padding: 30px;
    border: 1px solid #007D7A;
    border-radius: 15px;
    background-color: #fff;
    text-align: center;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
}

.info {
    text-align: left;
    margin: 15px 0;
    display: flex;
    align-items: center;
    flex-wrap: nowrap;
}

.info label {
    width: 60px;
    font-size: 14px;
}

.info input {
    font-size: 14px;
    padding: 8px;
    flex: 1;
    border: none;
    border-bottom: 1px solid lightgray;
    outline: none;
    margin-right: 10px;
    box-sizing: border-box;
    color: #000;
    transition: transform 0.3s ease, border-color 0.3s ease;
}

.info input:focus {
    transform: scale(1.05);
    border-bottom: 2px solid #007D7A;
}

.info input::placeholder {
    color: rgba(0, 0, 0, 0.5);
}

/* スピンボタンを非表示にする */
input[type="number"]::-webkit-outer-spin-button, 
input[type="number"]::-webkit-inner-spin-button { 
    -webkit-appearance: none; 
    margin: 0; 
} 

.login {
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;
    width: 150px;
    margin: 20px auto;
    margin-top: 30px;
    padding: 0.6em 2em;
    border: 1px solid #007d7a;
    border-radius: 10px;
    background-color: #007d7a;
    color: #fff;
    font-size: 1em;
    transition: all 0.3s ease;
}

.login:hover {
    background-color: #fff;
    color: #007d7a;
    border: 1px solid #007d7a;
}

/* リンクのスタイル */
.link {
    margin-top: -10px; /* 上下の間隔を調整 */
}

.link a {
    color: #007D7A; /* リンクの色 */
    text-decoration: underline; /* 下線をつける */
    transition: color 0.3s ease; /* ホバー時のトランジション */
}

.link a:hover {
    color: #000; /* ホバー時の色 */
}
</style>
</head>
<body>
<h1>Know IT</h1>
	<div class="container">
		<form action="Login" method="post">
			<div class="form-box">
				<div class="info">
                <label for="id">ID</label>
                <input type="number" id="id" name="USERID" placeholder="学籍番号 , 社員番号" required>
            </div>
            <div class="info">
                <label for="pass">Pass</label>
                <input type="password" id="pass" name="PASS" placeholder="パスワード" required>
            </div>
            <button type="submit" class="login">ログイン</button>
            <div class="link" style="margin-top: 20px;">
                <p><a href="register.jsp">新規登録</a></p>
            </div>
            <div class="link" style="margin-top: -10px;">
                <p><a href="passmail.jsp">パスワードを忘れた方</a></p>
            </div>
		</form>
	</div>

</body>
</html>
