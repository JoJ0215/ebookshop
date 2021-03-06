<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<body>
<%
	String name, email, subject, memo, time;

	// HTTP 요청에서 인수들을 추출한다.
	name = request.getParameter("name");
	email = request.getParameter("email");
	time = request.getParameter("time");
	subject = request.getParameter("subject");
	memo = request.getParameter("memo");
	
	ResultSet rs = null;
	String sql;
	Connection con = null;
	Statement stmt = null;
	try {
		Class.forName("org.mariadb.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/testdb3";
		con = DriverManager.getConnection(url, "java", "java");
	}
	catch (Exception e) {
		out.println("데이터베이스 접속에 문제가 있습니다.<hr>");
		out.println(e.getMessage());
		e.printStackTrace();
	}
	stmt = con.createStatement();
	
	// 데이터베이스 서버에 게시물을 저장한다.
	sql = "INSERT INTO message " + "(subject, name, time, memo, email) "
								 + "VALUES (" + "'" + subject + "', '" + name + "', '" + time + "', '" + memo + "', '" + email + "');";
	try {
		stmt.executeUpdate(sql);
	}
	catch (Exception e) {
		out.println("데이터베이스 삽입 연산이 실패하였습니다.<hr>");
		out.println(e.getMessage());
		e.printStackTrace();
	}
%>
<h3>게시글이 등록되었습니다.</h3>
<a href="list.jsp">게시글 리스트 보기</a>
</body>
</html>