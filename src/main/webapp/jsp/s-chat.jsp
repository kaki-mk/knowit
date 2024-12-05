<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chat</title>
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
            flex-direction: column;
            height: 100vh;
            background-color: #f7f7f7;
        }

        .chat-header {
            background-color: #007D7A;
            color: white;
            padding: 15px;
            display: flex;
            align-items: center;
        }

        .back-button {
            background: none;
            border: none;
            color: white;
            font-size: 20px;
            cursor: pointer;
            margin-right: 10px; /* ボタンと名前の間にスペース */
        }

        .chat-header .username {
            font-size: 1.2em;
        }

        .chat-container {
            flex-grow: 1;
            width: 100%;
            max-width: 400px; /* 最大幅を400pxに設定 */
            margin: 0 auto; /* 中央揃え */
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 15px;
            overflow-y: auto; /* スクロール可能にする */
        }

        .message {
            display: flex;
            align-items: flex-end;
            margin-bottom: 10px;
        }

        .message-box {
            border-radius: 15px;
            padding: 10px;
            max-width: 70%; /* メッセージボックスの最大幅 */
            position: relative; /* ふきだしを作成するために必要 */
        }

        .message.sent .message-box {
            background-color: #007D7A; /* 送信者のメッセージの色 */
            color: white;
            margin-left: auto; /* 右寄せ */
            border-bottom-right-radius: 0; /* 吹き出しの形状 */
        }

        .message.received {
            align-items: flex-start; /* アイコンを受信メッセージの上に配置 */
        }

        .message.received .message-box {
            background-color: #007D7A; /* 受信者のメッセージの色 */
            color: white;
            margin-right: auto; /* 左寄せ */
            border-bottom-left-radius: 0; /* 吹き出しの形状 */
        }

        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #007D7A; /* アイコンの背景色 */
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            margin-right: 10px; /* メッセージボックスとのスペース */
        }

        .input-container {
            display: flex;
            padding: 10px;
            background-color: #fff;
            border-top: 1px solid #ddd;
            position: relative; /* 固定しない */
            width: 100%; /* 幅を100%に */
            max-width: 400px; /* 最大幅をチャットコンテナに合わせる */
            margin: 0 auto; /* 中央揃え */
        }

        .input-box {
            flex-grow: 1; /* 入力フィールドが残りのスペースを占める */
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin-right: 5px;
        }

        .send-button {
            background-color: #007D7A;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 15px;
            cursor: pointer;
        }

        .send-button:hover {
            background-color: #005f5b;
        }

        a {
            text-decoration: none;
        }
    </style>
</head>

<body>

    <div class="chat-header">
        <a href="chatlist.jsp" class="back-button"> <!-- 遷移先のページを指定 -->
            <i class="fas fa-chevron-left"></i> <!-- 戻るボタン -->
        </a>
        <div class="username">チャット相手の名前</div>
    </div>
    <div class="chat-container">
        <div class="message sent">
            <div class="message-box">こんにちは！何かお手伝いできることはありますか？</div>
        </div>
        <div class="message received">
            <div class="avatar">A</div> <!-- アイコン表示 -->
            <div class="message-box">いいえ、大丈夫です！ありがとう！</div>
        </div>
        <!-- ここに新しいメッセージが追加される -->
    </div>
    <div class="input-container">
        <input type="text" class="input-box" placeholder="メッセージを入力..." />
        <button class="send-button">送信</button>
    </div>
</body>

</html>
