<%@ page trimDirectiveWhitespaces="true" %>
<jsp:useBean id="obj" class="FlightPackage.FlightSearch" />
<%@page import="java.util.* , FlightPackage.*" %>
<% if(request.getParameter("term") != null) {
	String res = obj.searchHelpAjaxHandler(request.getParameter("term"));
	out.println(res);
}
%>