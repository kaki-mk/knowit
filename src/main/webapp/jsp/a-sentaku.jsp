<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Question, java.util.ArrayList, java.util.List, model.SortByScore, dao.QuestionDAO"%>
<% 
    SortByScore sbs = new SortByScore();
    List<Question> questionList = new ArrayList<>();
	
    String fileName = (String)request.getAttribute("fileName");
    List<String[]> records = sbs.execute(fileName); 
    QuestionDAO qDao = new QuestionDAO();
    questionList = qDao.getSimilarQuestion(records);
    System.out.println(questionList);
    session.setAttribute("questionList", questionList);

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
    margin: 0; /* マージンをリセット */
    padding: 0;
    line-height: 2;
    background-color: #007D7A;
}

.back-button {
    position: fixed; /* 固定位置 */
    top: 10px; /* 上からの距離 */
    left: 10px; /* 左からの距離 */
    background-color: #007D7A; /* 背景色 */
    color: white; /* 文字色 */
    border: none; /* 枠線なし */
    border-radius: 5px; /* 角を丸くする */
    padding: 8px; /* 内側の余白 */
    cursor: pointer; /* ホバー時にカーソルをポインタに */
    font-size: 16px; /* フォントサイズ */
    z-index: 10; /* 他の要素の上に表示 */
}

.header {
    position: fixed; /* 固定位置 */
    top: 10px; /* 上からの距離 */
    left: 50%; /* 左から50% */
    transform: translateX(-50%); /* 中央に配置 */
    z-index: 9; /* ボタンの下に表示 */
    text-align: center; /* 中央揃え */
}

h1 {
    font-size: 20px; /* h1のフォントサイズを調整 */
    margin: 0; /* マージンをリセット */
    color: #fff;
}

h2 {
    font-size: 16px; /* h2のフォントサイズを調整 */
    margin: 20px 20px 10px; /* 上下にスペースを追加、左右に20pxのマージンを確保 */
    margin-left: 30px; /* 左に30pxのマージンを追加 */
    color: #fff;
}


.container {
    padding: 30px; /* 上下の余白を増加 */
    padding-left: 20px; /* 左側の余白 */
    padding-right: 20px; /* 右側の余白 */
    border: 1px solid #007D7A;
    border-radius: 15px;
    background-color: #fff;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2); /* 影を追加して浮き上がった印象に */
    width: 90%; /* 幅を90%に設定 */
    margin: 15px auto; /* 上部に60pxのマージン、左右は自動で中央揃え */
}

.box {
    border: 1px solid #ddd; /* 明るい枠線 */
    padding: 20px; /* 内側の余白を増やす */
    margin: 20px; /* ボックス間に余白を追加 */
    border-radius: 15px; /* 角を丸くする */
    background-color: #fff; /* 背景を白に */
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2); /* うっすら影を追加 */
}


.item {
    margin: 5px 0; /* 各項目のマージン */
    color: #000;
}

.label {
    display: block; /* ブロック要素として表示 */
    margin-bottom: 5px; /* ラベルと内容の間にスペース */
}

</style>
</head>

<body>

<div class="header">
    <h1>解説選択</h1>
</div>

<button class="back-button" onclick="history.back();">
    <i class="fas fa-chevron-left"></i>
</button>

<% if (questionList != null && !questionList.isEmpty()) { %>
    <h1 style="margin-top: 80px; margin-left: 30px;"><%= questionList.size() %>件ヒット</h1>

    <h2>最も類似した問題</h2>
    <% 
    int cnt = 0;
    for (Question question : questionList) { 
    	cnt++;
        
        if(cnt==2){%>
            <h2>その他類似した問題</h2>
        <% } %>
        <div class="box">
                <a href="jsp/a-kaisetu.jsp?id=<%= cnt %>" style="text-decoration: none; color: inherit;">
                    <div class="item">
                        <span class="label"></span><%= question.getQTxt() %>
                    </div>
                </a>
        </div>
    <% }} else { %>
        <h1>見つかりませんでした。。。</h1>
<% } %>

<!-- <div class="container"> </div> -->

</body>
</html>
