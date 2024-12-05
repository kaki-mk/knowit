<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page
	import="java.util.List,model.User,model.Question"%>
<%

//int qid = questionDAO.getqID(loginUser.getUSERID(), recipientId);
List<Question> questionList = (List)session.getAttribute("questionList");
String idx = request.getParameter("id");
Question question = questionList.get(Integer.parseInt(idx) - 1);
int qId = question.getqID();
User user = (User) session.getAttribute("loginUser");

// int qid = questionDAO.getqID(loginUser.getUSERID(), recipientId);
<!--List<History> historyList = (List)session.getAttribute("historyList");-->
<!--String idx = request.getParameter("id");-->
<!--History h = historyList.get(Integer.parseInt(idx) - 1);-->
<!--int hId = h.getHISTORY_ID();-->
<!--User user = (User) session.getAttribute("loginUser");-->
%>
<!DOCTYPE html>
<html>
<head>
<title>Know IT</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"> <!-- Font Awesomeのリンク -->

<style>
body {
	font-family: Arial, sans-serif;
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column; /* 縦方向に並べる */
	height: 90vh; /* 画面高さの90% */
	margin: 0 auto;
	padding: 15px;
	background-color: #007D7A;
	position: relative; /* 絶対位置のために相対位置を指定 */
}

.header {
	display: flex; /* ヘッダー内の要素を横並びに */
	align-items: center; /* 縦方向の中央揃え */
	position: fixed; /* 固定位置 */
	top: 0; /* 上からの距離を0に */
	left: 50%; /* 左からの距離を50%に */
	transform: translateX(-50%); /* 中央に配置 */
	padding: 15px; /* パディングを追加 */
	background-color: rgba(0, 125, 122, 0.8); /* 背景色を半透明にして視認性を向上 */
	z-index: 10; /* 他の要素の上に表示 */
}

.back-button {
	background-color: #007D7A; /* 背景色 */
	color: white; /* 文字色 */
	border: none; /* 枠線なし */
	border-radius: 5px; /* 角を丸くする */
	padding: 8px; /* 内側の余白 */
	cursor: pointer; /* ホバー時にカーソルをポインタに */
	font-size: 16px; /* フォントサイズ */
	position: fixed; /* 固定位置 */
	top: 15px; /* 上からの距離 */
	left: 15px; /* 左からの距離 */
	z-index: 10; /* 他の要素の上に表示 */
}

h1 {
	font-size: 20px; /* h1のフォントサイズを調整 */
	color: white;
	margin: 0; /* マージンをリセット */
}

.container {
    position: relative; /* コンテナを相対位置に設定 */
    padding: 30px 30px 60px; /* 上下と左右に余白を増加。下に60pxの余白を追加 */
    border: 1px solid #007D7A;
    border-radius: 8px;
    background-color: #fff;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2); /* 影を追加して浮き上がった印象に */
    width: 90%; /* 幅を90%に設定 */
    max-width: 600px; /* 最大幅を設定 */
    margin: 60px auto; /* 上部に60pxのマージン、左右は自動で中央揃え */
}

.chat-button {
    position: absolute; /* コンテナ内に絶対位置を設定 */
    bottom: 20px; /* 下からの距離 */
    right: 20px; /* 右からの距離 */
    color: white; /* ボタンの文字色 */
    border: none; /* 枠線なし */
    border-radius: 50px; /* 角を丸くする */
    padding: 10px 15px; /* 内側の余白 */
    cursor: pointer; /* ホバー時にカーソルをポインタに */
    font-size: 25px; /* フォントサイズ */
    background-color: #007D7A; /* 背景色 */
    z-index: 10; /* 他の要素の上に表示 */
}




.box {
	border: 1px solid #fff; /* 枠線 */
	padding: 10px; /* 内側の余白 */
	margin-bottom: 20px; /* 下にスペース */
	border-radius: 20px; /* 角を丸くする */
	position: relative; /* トグルボタンを絶対位置で配置するために相対位置を指定 */
}

.item {
	margin: 5px 0; /* 各項目のマージン */
}

.label {
	display: block; /* ブロック要素として表示 */
	margin-bottom: 5px; /* ラベルと内容の間にスペース */
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


    
</style>
<script>
const data = new URLSearchParams();
data.append('qId', '<%= qId %>');
data.append('userId', '<%= user.getUSERID() %>');

fetch('http://localhost:8080/knowit/Historyservlet', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
    },
    body: data.toString()
})
.then(response => {
    if (!response.ok) {
        throw new Error('Network response was not ok: ' + response.statusText);
    }
    return response.text();
})
.then(text => console.log('Response:', text))
.catch(error => console.error('Fetch error:', error));

function toggleSwitch(element) {
	element.classList.toggle('on');
}

</script>
</head>

<body>

<div class="header">
	<h1>解説<%= qId %><%= user.getUSERID() %></h1>
</div>

<button class="back-button" onclick="history.back();">
	<i class="fas fa-chevron-left"></i> 
</button>


<div class="container">
    <form action="QUESTION" method="post">
        <div class="box">
            <div class="toggle" onclick="toggleSwitch(this)">★</div>
            <div class="item">
                <span class="label"><br>問題</span><%= question.getQTxt() %>
            </div>
            <div class="item">
            </div>
            <div class="item">
                <span class="label"><br>解説</span><%= question.getExplanation() %>
            </div>
        </div>
    </form>
    <button class="chat-button" onclick="location.href='s-chatlist.jsp'">💬</button> <!-- チャットボタン -->
</div>





</body>
</html>
