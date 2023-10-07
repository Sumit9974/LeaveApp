<%-- 
    Document   : leaveStatus
    Created on : Oct 6, 2023, 1:49:42 AM
    Author     : sumit
--%>
<%
    if(session.getAttribute("user_email")==null){
        response.sendRedirect("login.jsp");
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Leave Application Status</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f5f5f5;
            }

            .container {
                max-width: 800px;
                margin: 20px auto;
                background-color: #fff;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
                overflow: hidden;
            }

            .header {
                background-color: #3498db;
                color: #fff;
                padding: 20px;
                text-align: center;
                border-top-left-radius: 5px;
                border-top-right-radius: 5px;
            }

            h1 {
                margin: 0;
            }

            .status-list-container {
                max-height: 400px; /* Set a fixed height for the scrollable container */
                overflow: auto; /* Enable vertical scrolling */
            }

            .status-list {
                padding: 20px;
            }

            .status-item {
                background-color: #fff;
                border: 1px solid #ddd;
                margin: 10px 0;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .status-item:hover {
                background-color: #f5f5f5;
            }

            .status-details {
                flex: 1;
            }

            .status {
                font-weight: bold;
                color: #27ae60;
                text-align: right;
                flex: 0.3;
            }

            .footer {
                background-color: #3498db;
                color: #fff;
                padding: 10px;
                text-align: center;
                border-bottom-left-radius: 5px;
                border-bottom-right-radius: 5px;
            }
            .navbar {
                background-color: #3498db;
                overflow: hidden;
            }

            .navbar a {
                float: right;
                display: block;
                color: #fff;
                text-align: center;
                padding: 14px 16px;
                text-decoration: none;
            }

            .navbar a:hover {
                background-color: #2980b9;
            }
            .green{
                color:green;
            }
            .red,.nla{
                color:red;
            }
            .orange{
                color:#FF5D3B;
            }
        </style>
    </head>
    <body>
        <%
               Class.forName("com.mysql.jdbc.Driver");
               Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/a2_ajava","root","root");
               Statement st = con.createStatement();
               ResultSet leaveApplicationListRS = st.executeQuery("select * from leave_application where user_id="+(int)session.getAttribute("userid"));
            
        %>
        <div class="navbar">
            <a href="index.jsp">Home</a>
            <!--<a href="Logout">Logout</a>-->
        </div>

        <!--        <div class="status-item">
                            <div class="status-details">
                                <h3>Leave Application 2</h3>
                                <p>Requested: 2023-11-03 to 2023-11-05</p>
                            </div>
                            <div class="status">Approved</div>
                        </div>-->

        <div class="container">
            <div class="header">
                <h1>Leave Application Status</h1>
            </div>
            <div class="status-list-container">
                <div class="status-list">
                    <c:set var="availableApplication" value="false" scope="session"/>
                    <%
        while(leaveApplicationListRS.next())
        {
                    %>
                    <c:set var="availableApplication" value="true" scope="session"/>

                    <div class="status-item">
                        <div class="status-details">
                            <h3> <%= leaveApplicationListRS.getString("leave_type")%></h3>
                            <p>Requested: <%= leaveApplicationListRS.getString("start_date")%> to <%= leaveApplicationListRS.getString("end_date")%></p>
                        </div>
                        <div class="status <%= leaveApplicationListRS.getInt("status")==1?"green":leaveApplicationListRS.getInt("status")==0?"orange":"red" %>"><%= leaveApplicationListRS.getInt("status")==1?"Approved":leaveApplicationListRS.getInt("status")==0?"Pending":"Rejected" %></div>
                    </div>




                    <%
                         
                }
                    %>
                    
                     <c:if test="${!availableApplication}">
                <h1 class="nla" style="text-align:center;">No Leave Application Found!</h1>
            </c:if>

                </div>
            </div>
            <div class="footer">
                &copy; 2023 Leave Application Status
            </div>
        </div>
    </body>
</html>
