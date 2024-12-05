<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Question, java.util.ArrayList, java.util.List, model.SortByScore, dao.QuestionDAO"%>
<% 
    SortByScore sbs = new SortByScore();
    List<Question> questionList = new ArrayList<>();
	
    String fileName = (String)request.getAttribute("fileName");
    List<String[]> records = sbs.execute(fileName); 
    QuestionDAO qDao = new QuestionDAO();
    questionList = qDao.getSimilarQuestion(records);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Know IT</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 10px;
            padding: 0;
            line-height: 2;
        }
        h1 {
            font-size: 20px; /* h1のフォントサイズを調整 */
            margin: 10px 0;
        }
        h2 {
            font-size: 16px; /* h2のフォントサイズを調整 */
            margin: 20px 0 10px; /* h1との間にスペースを追加 */
        }
        p {
            margin: 5px 0 20px;
        }
        .box {
            border: 1px solid #000; /* 枠線 */
            padding: 10px; /* 内側の余白 */
            margin-bottom: 20px; /* 下にスペース */
            border-radius: 20px; /* 角を丸くする */
        }
        .item {
            margin: 5px 0; /* 各項目のマージン */
        }
        .label {
            display: block; /* ブロック要素として表示 */
            margin-bottom: 5px; /* ラベルと内容の間にスペース */
        }
    </style>
</head>

<body>
    <% if (questionList != null && !questionList.isEmpty()) { %>
        <h1><%= questionList.size() %>件ヒット</h1>
        <h2>最も類似した解説</h2>
        <% for (Question question : questionList) { %>
            <div class="box">
               <a href="a-kaisetu.jsp?id=<%= question.getqID() %>" style="text-decoration: none; color: inherit;">
                <div class="item">
                    <span class="label">問題</span><%= question.getQTxt() %>
                </div>
            </div>
            <h2>類似した問題の解説</h2>
    <% }} else { %>
        	<h1>0件ヒット</h1>
    <% } %>
</body>
</html>
