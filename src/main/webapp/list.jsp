<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
</head>
<body>
	<h3>게시글 리스트</h3>
	<table border="2">
		<tr>
			<td>번호</td>
			<td>제목</td>
			<td>작성자</td>
			<td>날짜</td>
			<td>이메일</td>
		</tr>
		
		<%
			String level = (String)session.getAttribute("level");
			Connection con = null;
			Statement stmt = null;
			try {
				
				// 데이터베이스 드라이버를 찾아서 데이터베이스 서버에 로그인한다.
				Class.forName("org.mariadb.jdbc.Driver");
				String url = "jdbc:mysql://localhost:3306/testdb3";
				con = DriverManager.getConnection(url, "java", "java");
			} catch (Exception e) {
				out.println("데이터베이스 접속에 문제가 있습니다.<hr>");
				out.println(e.getMessage());
				e.printStackTrace();
			}
			
			// SQL 쿼리를 작성하여 실행한다.
			stmt = con.createStatement();
			String sql = "SELECT * FROM message order by id ASC";
			ResultSet rs = stmt.executeQuery(sql);
			
			if (rs != null) {
				while (rs.next()) {
					int id = Integer.parseInt(rs.getString("id"));
		%>
		<tr>
			<td><%= id%></td>
			<td><a href="display.jsp?id=" <%= id%>>
				<%=rs.getString("subject") %></a></td>
			<td><%=rs.getString("name")%></td>	
			<td><%=rs.getString("time")%></td>
			<td><%=rs.getString("email")%></td>
		</tr>
		
		<%
				}
			}
		%>
	</table>
	
	<%
		if (level.equals("3")) {
	%>
			<a href="write.jsp">게시글 쓰기</a>	
	<%
		}
	%>
	<%
		if (stmt != null)
			stmt.close();
		if (con != null)
			con.close();
	%>
</body>
</html>