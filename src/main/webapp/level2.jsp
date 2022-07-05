<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String level = (String)session.getAttribute("level");

	if (level.equals("1")) {
		out.println("<script>");
		out.println("location.href = 'level1.jsp'");
		out.println("</script>");
	} else {
		out.println("<script>");
		out.println("location.href = 'list.jsp'");
		out.println("</script>");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>