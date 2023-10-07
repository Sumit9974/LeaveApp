<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*,java.sql.*"%>

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

            <p class="h1" >SIGN UP</p>
            <form class="border border-white p-2 d-flex flex-column" action="signup.jsp" method='post'> 
                <div class="mb-3">
                    <label for="name" class="form-label ">Name</label>
                    <input type="name" class="form-control" id="name" name="name" required>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label ">Email address</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Confirm Password</label>
                    <input type="password" class="form-control" id="cnf_password" name="cnf_password" required>
                </div>

                <span>
                    Already have an account?<a href="login.jsp" class="p-2 link-dark">Login</a>

                </span>
                <div class="container text-center pt-3">                

                    <button type="submit" class="btn btn-primary" name='signup' value="SignUp">Sign Up</button>
                </div>
            </form>
        </div>
        <% 
 
        boolean duplicateUserFound=false;
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/a2_ajava","root","root");
        Statement st = con.createStatement();
        if("POST".equals(request.getMethod()) && request.getParameter("signup")!=null)
        {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String cnf_password = request.getParameter("cnf_password");
        
        ResultSet validateUser = st.executeQuery("select * from users");
        
        while(validateUser.next())
        {
        if(validateUser.getString("email").equals(email))
        {
        %>
        <script>alert("User with this Email Already Exists!");</script>
        <%
            duplicateUserFound=true;
            break;
            }
        }

if(!duplicateUserFound)
{
    String query = "insert into users (name,email,password) values (?,?,?)";
PreparedStatement pstmt = con.prepareStatement(query);
pstmt.setString(1,name);
pstmt.setString(2,email);
pstmt.setString(3,password);

int result = pstmt.executeUpdate();

if(result == 1)
{
        %>
        <script>
            alert("User Registered Successfully!");
            window.location.href = "login.jsp";
        </script>
        <%
}
}
        
        
        
        
            }
        
        
           
         
        %>

    </body>

</html>
