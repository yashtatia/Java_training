
<%@page import="javax.servlet.http.*,java.util.*" %>


<HTML>
<HEAD>
TEST
</HEAD>
<BODY>

<jsp:useBean id = "test" class = "Bean.User"/>
<%! ArrayList<MyBooking> bookedFlights = test.getUserBookings(session); %>
<% 

session.setAttribute("userName","c.sritej@gmail.com");


for(int i=0;i<bookedFlights.size();i++){
   // out.println(bookedFlights.get(i).bookingId);
   out.println("sritej");
}

%>
</BODY>
</HTML>

