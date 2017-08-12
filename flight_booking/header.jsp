<!DOCTYPE html>
<html>
<head>
	<title>Search Flights</title>
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="assets/css/jquery-ui.css">
	<link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <style type="text/css">
        .alert{
            margin-top:100px;
        }
    </style>
</head>
<body>

	 <nav class="navbar navbar-inverse navbar-fixed-top" style="background-color: black" role="navigation">
            <div class="container">
                <div class="navbar-header">
                    <a class="navbar-brand" href="index.jsp"><img src="assets/img/sap.png" height=40 width=40></a>
                </div>
                
                
                <% if( session.getAttribute("isLoggedIn") == null) { %>
                    <ul class="nav navbar-nav navbar-right" style="cursor: pointer;">
                        <li><a id="login"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
                        <li><a href="signup.jsp"><span class="glyphicon glyphicon-log-in"></span> Sign Up</a></li>
                    </ul>
                <% } else { %>
                    <ul class="nav navbar-right">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown"
                             role="button" aria-haspopup="true" aria-expanded="false" style="color: white; background-color: black;">
                             <i class="fa fa-user-o" aria-hidden="true"></i>  <%= session.getAttribute("fname")+" "+session.getAttribute("lname")%> <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="#">Your Miles : <%= session.getAttribute("air_miles")%></a></li>
                                <li><a href="myBookings.jsp">MyBookings</a></li>
                                <li><a href="logout.jsp">Logout</a></li>
                            </ul>
                        </li>
                    </ul>
                <% } %>
                    
                </div>
                }
            </div>
        </nav>        
    
    <% if( session.getAttribute("isLoggedIn") == null) { %>

    <div id="loginModal" class="modal fade " role="dialog">
        <div class="modal-dialog modal-md">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Login </h4>
            </div>
            <div class="modal-body">

             <form class="form-inline" id="loginForm" action="doLogin.jsp" method="POST">
                <div class="form-group">
                    <label class="sr-only" for="InputEmail">Email address</label>
                    <input type="email" class="form-control" id="Email" placeholder="Email" name="email">
                </div>
                <div class="form-group">   
                    <label class="sr-only" for="Password">Password</label>
                    <input type="password" class="form-control" id="Password" placeholder="Password" name="password">
                </div>
         		<button type="button" class="btn btn-default btn-danger pull-right" data-dismiss="modal">Cancel</button>
                <button type="submit" class="btn btn-default btn-info pull-right">Sign in</button>
            </form>

            </div>
        </div>
        </div>
    </div>

    <% } %>

    <% if(request.getParameter("message") != null && request.getParameter("message").toString().equals("login_success")) { %>
        <div class="alert alert-success alert-dismissible"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <strong>Success!</strong> Logged in successfully.
        </div>
    <% } else if(request.getParameter("message") != null && request.getParameter("message").toString().equals("logout_successfull")) { %>
        <div class="alert alert-success alert-dismissible"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <strong>Congratulations!</strong> Succesfully logged out.
        </div>
    <% } else if(request.getParameter("message") != null && request.getParameter("message").toString().equals("login_failed")) { %>
        <div class="alert alert-danger alert-dismissible"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <strong>Oops!</strong> Username/Password incorrect.
        </div>
    <% } else if(request.getParameter("message") != null && request.getParameter("message").toString().equals("booking_success")) { %>
        <div class="alert alert-success alert-dismissible"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <strong>Congratulations!</strong> Your booking is successful.
        </div>
    <% } else if(request.getParameter("message") != null && request.getParameter("message").toString().equals("signup_success")) { %>
        <div class="alert alert-success alert-dismissible"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <strong>Congratulations!</strong> Your account has been created. Please log in.
        </div>
    <% } else if(request.getParameter("message") != null && request.getParameter("message").toString().equals("booking_failure")) { %>
        <div class="alert alert-danger alert-dismissible"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <strong>Sorry!</strong> Your booking failed. Please try again.
        </div>
    <% } else if(request.getParameter("message") != null && request.getParameter("message").toString().equals("not_logged_in")) { %>
        <div class="alert alert-danger alert-dismissible"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <strong>Arey babu!</strong> Kaha ja rahe ho! Pahile login to kariye!!
        </div>
    <% } %>

