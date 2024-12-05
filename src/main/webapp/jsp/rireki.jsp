<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE html>
<%@ page import="model.History, java.util.List"%>
<%
List<History> historyList = (List<History>) request.getAttribute("historyList");
%>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- ビューポート設定 -->
<title>利用者履歴</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 20px;
}

.problem {
	border: 1px solid #000; /* 枠を黒に設定 */
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
	margin: 15px 0; /* 上下のマージンを設定 */
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
}

h1 {
	font-size: 20px; /* タイトルのフォントサイズを調整 */
}
}
</style>
<script>
	function toggleSwitch(el) {
		el.classList.toggle('on');
	}
</script>
</head>
<body>

	<h1>利用者履歴</h1>

	<%
	if (historyList != null) {
		int cnt = 0;
	%>
	<%
	for (History history : historyList) {
		cnt++;
	%>
	<!--  <form action="VIEWHISTORY" method="post">-->
	<div class="problem">
		<a href="jsp/a-kaisetu.jsp?id=<%=cnt%>"
			style="text-decoration: none; color: inherit;">
			<div class="toggle" onclick="toggleSwitch(this)">★</div>
			<p><%=history.getQ_ID()%></p>
			<%
			java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
			String formattedTime = formatter.format(history.getVIEWTIME());
			 %>
			<h3><%=formattedTime%></h3>
			<p class="problem-content"><%=history.getQTXT()%></p>
		</a>
	</div>
	<% }} %>

</body>
</html>