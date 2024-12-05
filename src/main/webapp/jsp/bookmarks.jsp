<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- ビューポート設定 -->
    <title>ブックマーク</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #007D7A;
 
        }
        .problem {
            border: 1px solid #007D7A; /* 枠を黒に設定 */
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            background-color: #fff; /* 背景色を白に設定 */
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 影を追加 */
            width: calc(100% - 40px); /* 幅を100% - パディングを考慮 */
            max-width: 500px; /* 最大幅を設定 */
            margin-left: auto; /* 中央揃え */
            margin-right: auto; /* 中央揃え */
            position: relative; /* 相対位置を設定 */
        }
        .problem-title {
            font-size: 18px; /* 問題タイトルのフォントサイズ */
            margin: 0; /* マージンをゼロに */
        }
        .problem-content {
            font-size: 14px; /* 問題内容のフォントサイズ */
            margin: 5px 0; /* 上下のマージンを設定 */
        }
        .problem-description {
            font-size: 14px; /* 解説のフォントサイズ */
            margin-top: 10px; /* 上部にマージンを追加 */
            color: #555; /* 解説の色を変更 */
        }
        .toggle {
            font-size: 24px; /* 星のサイズ */
            color: #ccc; /* 星の色 */
            position: absolute;
            top: 15px; /* 上からの位置 */
            right: 15px; /* 右からの位置 */
            cursor: pointer;
            transition: color 0.3s; /* 色の変化をスムーズに */
        }
        .toggle.on {
            color: #007D7A; /* トグルがオンの時の色 */
        }
        h1 {
            font-size: 22px; /* タイトルのフォントサイズ */
            margin-bottom: 20px;
            text-align: left; /* 左揃え */
            color: #fff;
        }
        @media (max-width: 600px) {
            .problem {
                padding: 10px; /* パディングを調整 */
                width: calc(100% - 20px); /* スマホの幅に合わせる */
            }
            h1 {
                font-size: 20px; /* タイトルのフォントサイズを調整 */
            }
        }
    </style>
    <script>
        function toggleSwitch(el, formId) {//toggleを押したときに実行される関数
            el.classList.toggle('on');
            el.classList.toggle('off');
            var formElement = document.getElementById(formId); // フォーム要素を取得
            var hiddenField = formElement.getElementsByClassName('hiddenField')[0]; // フォーム内の hiddenField 要素を取得 リストですべでのhiddenFieldが返されるので、[0]は最初の要素
            hiddenField.value = el.classList.contains('off') ? 'false' : 'true'; // 'off' のときに 'false' を設定。 クリックされた要素が、offかどうかをチェック。offクラスを持っている場合は、hiddenfield.valueにfalseを設定、そうでない場合はtrueを設定する。ブックマーク機能を実現
            //console.log(`Form ID: ${formId}, Hidden Field Value: ${hiddenField.value}`); // デバッグ用
            
            // フォームデータを収集
            var formData = new FormData(formElement);//フォームに含まれているデータを簡単に操作できるようになる
            //フォームデータをまとめて収集し、あとで送信するため
            
            // フォームデータをURLエンコードされた文字列に変換
            var urlEncodedData = new URLSearchParams(formData).toString();//データを安全に送信するため
            //サーバが正しく解釈し、処理できるようになる↑
            
            // 非同期リクエストの作成と送信
            var xhr = new XMLHttpRequest();//オブジェクト作成
            xhr.open("POST", formElement.action, true);//HTTP陸エスを初期化
            //POSTメソッドを使用、フォームのaction(Bookmarkservlet)属性に設定されたURLに対して非同期(特定のタスクの処理をまつことなく実行)でリクエスト
            
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");//サーバーに送信する形式を指定、URLエンコードされたフォームデータを送信することを示す

            xhr.onreadystatechange = function() {//リクエストの状態が変化したときに呼び出される関数
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {//リクエストが完了し、ステータスが200（成功）であれば、フォームが正常に送信されたことをコンソールに出力
                        console.log("Form submitted successfully");
                    } else {//エラーメッセージを出力
                        console.error("Error submitting form: " + xhr.status);
                    }
                }
            };
            
            xhr.send(urlEncodedData);//URLエンコードされたデータをサーバに送信
        }//非同期リクエストを使用することで、ページのリフレッシュをすることなく、サーバに送信することができます。
         //操作がしやすくなります。
    </script>
</head>
<body>

<h1>ブックマーク</h1>

<% if (bookmarkList != null) { %>
    <% for(int i = 0; i < bookmarkList.size(); i++) { %>
        <% Bookmark bok = bookmarkList.get(i); %>
        <div class="problem">
            <form id="form-<%= i %>" action="Bookmarkservlet" method="post">
                <div class="toggle <%= bok.getisBMARK() ? "on" : "off" %>" onclick="toggleSwitch(this, 'form-<%= i %>')">★</div><!-- トグルボタン★を作成し、onclickイベントでtoggkeSwitch関数を呼び出す。
                                                                                                                                  ボタンのクラスはbok.getisBMARK()の値に基づいてonまたはoffになります -->
                <h2 class="problem-title"><%= bok.getQID() %></h2>
                <p class="problem-content"><%= bok.getQTXT() %></p>
                <input type="hidden" class="hiddenField" name="bmark" value="<%= bok.getisBMARK() ? "true" : "false" %>"><!-- ここで真であるか偽であるかを評価。サーブレットに送信 -->
                <input type="hidden" name="userid" value="<%= bok.getUSERID() %>">
                <input type="hidden" name="bookid" value="<%= bok.getBOOKID() %>">
                <input type="hidden" name="qid" value="<%= bok.getQID() %>">
            </form>
        </div>
    <% } %>
<% } %>

<!-- 
<div class="problem">
    <div class="toggle on" onclick="toggleSwitch(this)">★</div>
    <h2 class="problem-title">問題1</h2>
    <p class="problem-content">問題内容</p>
    <p class="problem-description">解説: サンプル 1</p>
</div>

<div class="problem">
     <div class="toggle on" onclick="toggleSwitch(this)">★</div>
    <h2 class="problem-title">問題2</h2>
    <p class="problem-content">問題内容</p>
    <p class="problem-description">解説: サンプル 2</p>
</div>

<div class="problem">
     <div class="toggle on" onclick="toggleSwitch(this)">★</div>
    <h2 class="problem-title">問題3</h2>
    <p class="problem-content">問題内容</p>
    <p class="problem-description">解説: サンプル 3</p>
</div>

<div class="problem">
     <div class="toggle on" onclick="toggleSwitch(this)">★</div>
    <h2 class="problem-title">問題4</h2>
    <p class="problem-content">問題内容</p>
    <p class="problem-description">解説: サンプル 4</p>
</div>
 -->
</body>
</html>
