<%
	session.invalidate();
	response.sendRedirect("index.jsp?message=logout_successfull");
%>