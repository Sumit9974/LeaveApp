<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            *{
                padding: 0;
                margin: 0;
                box-sizing: border-box;
            }

            .form-container{
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;

            }
            form{
                border-radius: 5px;
                width:25vw;
            }
        </style>

        <%@include file="bootstrap.jsp" %>
    </head>
    <body>
        <div class="form-container bg-success p-2 text-white bg-opacity-75 flex-column">
            <p class="h1" >LOGIN</p>
            <form class="border border-white p-2" action="login.jsp" method='post'>
                <div class="mb-3">
                    <label for="email" class="form-label ">Email address</label>
                    <input type="email" class="form-control" id="email" name="email"  required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
                <span>
                    Don't Have an account? <a href="signup.jsp" class="p-2 link-dark">Sign Up</a>
                </span>
                <div class="container text-center pt-2">


                    <button type="submit" class="btn btn-primary" name='login' value="Login">Login</button>
                </div>
            </form>
        </div>
    </body>

    <%
     if("POST".equals(request.getMethod()) && request.getParameter("login")!=null)
        {
  
        boolean loginProblem=false;
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        Class.forName("com.mysql.jdbc.Driver");
         Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/a2_ajava","root","root");
         Statement st = con.createStatement();
         
         ResultSet checkUser = st.executeQuery("select * from users");
         

        if("admin@gmail.com".equals(email) && "admin".equals(password))
        {
        session.setAttribute("username","Admin");
        session.setAttribute("user_email","admin@gmail.com");
        response.sendRedirect("admin.jsp");
    }else{
    
         while(checkUser.next())
         {
         if(checkUser.getString("email").equals(email) && checkUser.getString("password").equals(password))
         {
    
         loginProblem=false;
         session.setAttribute("username",checkUser.getString("name"));
         session.setAttribute("userid",checkUser.getInt("id"));
         session.setAttribute("user_email",email);
         response.sendRedirect("index.jsp");
    }else{
     loginProblem=true;
    }
         
    }
    
    }
 if(loginProblem)
{
    %>
    <script>alert("Email Address or Password Does not Match!");</script>
    <%
}
        
    }
    
    %>
</html>
