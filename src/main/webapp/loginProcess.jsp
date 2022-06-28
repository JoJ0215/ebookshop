<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

    
<%
	String id = request.getParameter("id");

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		Context init = new InitialContext();
		Class.forName("org.mariadb.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/testdb3", "java", "java");
		
		pstmt = conn.prepareStatement("SELECT * FROM join_member WHERE id=?");
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		
		if (rs.next()) {
			String level = rs.getString("level");
			session.setAttribute("id", id);
			session.setAttribute("level", level);
			out.println("<script>");
			out.println("location.href = 'bogi.jsp'");
			out.println("</script>");
		}

			out.println("<script>");
			out.println("location.href = 'joinForm.jsp'");
			out.println("</script>");
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			rs.close();
			pstmt.close();
			conn.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
%>