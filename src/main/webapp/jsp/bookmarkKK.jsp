<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="model.User,model.Bookmark,java.util.List" %>
<%
    List<Bookmark> bookmarkList = (List<Bookmark>) request.getAttribute("bookmarkList");
    User user = (User) session.getAttribute("loginUser");
    Integer userIdObj = (Integer) request.getAttribute("userid");
    int userId = userIdObj != null ? userIdObj.intValue() : 0;
    
%>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ブックマーク</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
        }
        .problem {
            border: 1px solid #000;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            width: calc(100% - 40px);
            max-width: 500px;
            margin-left: auto;
            margin-right: auto;
            position: relative;
        }
        .problem-title {
            font-size: 18px;
            margin: 0;
        }
        .problem-content {
            font-size: 14px;
            margin: 5px 0;
        }
        .problem-description {
            font-size: 14px;
            margin-top: 10px;
            color: #555;
        }
        .toggle {
            font-size: 24px;
            color: #ccc;
            position: absolute;
            top: 15px;
            right: 15px;
            cursor: pointer;
            transition: color 0.3s;
        }
        .toggle.on {
            color: #4CAF50;
        }
        .toggle.off {
            color: gray;
        }
        h1 {
            font-size: 22px;
            margin-bottom: 20px;
            text-align: left;
        }
        @media (max-width: 600px) {
            .problem {
                padding: 10px;
                width: calc(100% - 20px);
            }
            h1 {
                font-size: 20px;
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

</body>
</html>
