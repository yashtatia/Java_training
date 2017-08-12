<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.* , FlightPackage.* , java.security.*" %>
<jsp:useBean id="obj" class="FlightPackage.User" />

<% if(request.getParameter("email") != null &&
	request.getParameter("password") != null &&
	request.getParameter("contact") != null &&
	request.getParameter("fname") != null &&
	request.getParameter("lname") != null &&
	request.getParameter("billing_address") != null) {

		//md5 password
		String password = request.getParameter("password");
		byte[] bytesOfMessage = password.getBytes("UTF-8");
		MessageDigest md = MessageDigest.getInstance("MD5");
		byte[] encodedPassword = md.digest(bytesOfMessage);
		StringBuffer buf = new StringBuffer();
		for (int i = 0; i < encodedPassword.length; i++) {
			if (((int) encodedPassword[i] & 0xff) < 0x10) {
				buf.append("0");
			}
			buf.append(Long.toString((int) encodedPassword[i] & 0xff, 16));
		}
		String passw = buf.toString(); 

		if(obj.signUp(
						request.getParameter("email"),
						request.getParameter("contact"),
						passw,
						request.getParameter("fname"),
						request.getParameter("lname"),
						request.getParameter("billing_address")
						)
					){
			response.sendRedirect("index.jsp?message=signup_success");
		}else{
			response.sendRedirect("index.jsp?message=signup_failed");
		}
}
%>