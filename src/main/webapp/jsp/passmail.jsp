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
            height: 100vh;
            margin: 0;
            background-color: #007D7A;
        }

        .header {
            position: absolute;
            top: 20px; /* 上部からの距離 */
            left: 20px; /* 左側からの距離 */
        }

        .container {
            text-align: center;
            border: 2px solid #007D7A;
            border-radius: 20px;
            padding: 40px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 320px;
        }

        h1 {
            font-size: 24px;
            margin-bottom: 30px;
        }

        p {
            margin: 15px 0;
            font-size: 14px;
            color: #333;
        }

        .input-field {
            margin: 15px 0;
            text-align: left;
            width: 100%;
        }

        .input-field label {
            margin-bottom: 10px;
            display: block;
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
            padding: 12px 20px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 30px;
            transition: background-color 0.3s;
        }

        .back-button {
            background: none;
            border: none;
            color: white;
            cursor: pointer;
            font-size: 20px;
            margin-right: 10px;
        }

        .button:hover {
            background-color: #333;
        }
    </style>
</head>
<body>

    <div class="header">
        <button class="back-button" onclick="window.location.href='index.jsp'">
            <i class="fas fa-chevron-left"></i>
        </button>
    </div>
    <div class="container">
        <h1>パスワード再登録</h1>
        
        <form action="index.jsp" method="post">
            <div class="input-field">
                <label class="email" for="email">Mail address</label> 
                <input
                    type="email" id="email" name="MAIL" placeholder="メールアドレス" 
                    style="width: 100%; border: none; outline: none;" required>
                <div class="underline"></div>
            </div>
            
            <p>再登録メールを送信します。<br>
            新規登録時に入力したメールアドレスで<br>
            確認してください。</p>
            <button type="submit" class="button">再登録メールを送信</button>
        </form>
    </div>

</body>
</html>
