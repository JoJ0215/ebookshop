<%@ page import="java.util.*, java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<!-- <meta charset="UTF-8"> -->
<title>온라인 서점 예제</title>
</head>
<body>
<h1>인터넷 프로그래머 문고</h1>
<h3>제목을 입력하세요:</h3>
<form method="post">
책 제목: <input type="text" name="title"><br>
	   <input type="submit" value="검색">
</form>

<%
	String title = request.getParameter("title");
	
	if (title != null) {
%>	
<%
	// mysql 드라이버를 찾는다.
	Class.forName("org.mariadb.jdbc.Driver");

	// MySQL 서버에 접속한다.
	Connection conn = DriverManager.getConnection ("jdbc:mysql://localhost:3306/testdb3", "java", "java");
	
	Statement stmt = conn.createStatement();
	
	// SQL 문자열을 생성한다.
	String sqlStr = "SELECT * FROM book_table WHERE title LIKE";
			sqlStr += "'%" + title + "%'";
	sqlStr += "ORDER BY title ASC";
	ResultSet rset = stmt.executeQuery(sqlStr);
%>
<hr>
<form method="post" action="order_proc.jsp">
<table border=1 cellpadding=5>
<tr>
<th>주문</th>
<th>저자</th>
<th>제목</th>
<th>가격</th>
<th>남아있는 수량</th>
</tr>
<%
	while (rset.next()) {
		int id = rset.getInt("id");
%>
<tr>

<!-- 결과 집합의 값들을 꺼내어 테이블을 작성한다. -->
<td><input type="checkbox" name="id" value="<%= id %>"></td>
<td><%= rset.getString("author") %></td>
<td><%= rset.getString("title") %></td>
<td><%= rset.getInt("price") %>원</td>
<td><%= rset.getInt("qty") %>권</td>
</tr>
<%
	}
%>
</table>
<br><input type="submit" value="주문">
	<input type="reset" value="초기화">
</form>
<a href="<%= request.getRequestURI() %>"><h3>다시 주문하기</h3></a>
<%
	rset.close();
	stmt.close();
	conn.close();
	}
%>
</body>
</html>