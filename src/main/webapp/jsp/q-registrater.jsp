<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>問題追加登録</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #007D7A;
        }

        .header {
            padding: 20px;
            border-radius: 15px 15px 0 0; /* 上部のみ角丸 */
            color: white; /* 白文字 */
            display: flex;
            align-items: center; /* 中央揃え */
            width: 100%; /* 幅を100%に */
        }

        .back-button {
            background: none; /* 背景なし */
            border: none; /* ボーダーなし */
            color: white; /* 白文字 */
            cursor: pointer;
            font-size: 20px; /* フォントサイズ */
            margin-right: 10px; /* タイトルとの間隔を調整 */
        }

        .header h1 {
            flex-grow: 1; /* タイトルが横に広がるようにする */
            text-align: center; /* タイトルを中央揃え */
            margin: 0; /* マージンを削除 */
            font-size: 28px; /* フォントサイズ */
        }

        .container {
            padding: 30px;
            border: 1px solid #007D7A;
            border-radius: 15px;
            background-color: #fff;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.2);
            max-width: 700px;
            margin: 0 auto; /* 中央揃え */
        }

        .question, .solution, .answer {
            border: 1px solid #ccc;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            min-height: 80px;
            font-size: 18px;
        }

        .register-btn {
            background-color: #007D7A;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 15px 20px;
            cursor: pointer;
            font-size: 20px;
            width: 100%;
        }

        .register-btn:hover {
            background-color: #005f5b;
        }

        @media (max-width: 600px) {
            .container {
                padding: 20px; /* パディングを調整 */
            }
            .header h1 {
                font-size: 24px; /* タイトルのフォントサイズを調整 */
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <button class="back-button" onclick="window.location.href='t-home.jsp'"> <!-- 遷移先のページを指定 -->
            <i class="fas fa-chevron-left"></i> <!-- 戻るボタン -->
        </button>
        <h1>問題追加登録</h1>
    </div>
    <form action="QUESTION" method="post">
        <div class="container">
            <div>
                <h2>問題</h2>
                <div class="question" contenteditable="true"></div>
            </div>

            <div>
                <h2>解答</h2>
                <div class="solution" contenteditable="true"></div>
            </div>

            <div>
                <h2>解説</h2>
                <div class="answer" contenteditable="true"></div>
            </div>

            <button type="submit" class="register-btn">登録</button>
        </div>
    </form>
</body>
</html>
