<%-- 
    Document   : leaveApplication
    Created on : Oct 6, 2023, 1:33:13 AM
    Author     : sumit
--%>
<%
//    if(session.getAttribute("email")!=null){
//        response.sendRedirect("login.jsp");
//    }
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if(session.getAttribute("user_email")==null){
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Leave Application</title>
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

            .leave-form {
                padding: 20px;
            }

            label {
                font-weight: bold;
                color: #333;
            }

            select,
            input[type="date"],
            textarea {
                width: calc(100% - 20px);
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                margin-bottom: 20px;
            }

            textarea {
                resize: vertical;
                height: 100px;
            }

            .submit-button {
                background-color: #3498db;
                color: #fff;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            .submit-button:hover {
                background-color: #2980b9;
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
            select{
                width:calc(100% );
            }
        </style>
    </head>
    <body>
        <div class="navbar">
            <a href="index.jsp">Home</a>
            <!--<a href="Logout">Logout</a>-->
        </div>
        <div class="container">
            <div class="header">
                <h1>Leave Application</h1>
            </div>
            <div class="leave-form">
                <form action="leaveApplication.jsp" method="post">
                    <div class="form-group">
                        <label for="leaveType">Leave Type:</label>
                        <select id="leaveType" name="leaveType" required>
                            <option value="sick">Sick Leave</option>
                            <option value="vacation">Vacation Leave</option>
                            <option value="personal">Personal Leave</option>
                            <option value="other">Other Leave</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="startDate">Start Date:</label>
                        <input type="date" id="startDate" name="startDate" required>
                    </div>

                    <div class="form-group">
                        <label for="endDate">End Date:</label>
                        <input type="date" id="endDate" name="endDate" required>
                    </div>

                    <div class="form-group">
                        <label for="reason">Reason:</label>
                        <textarea id="reason" name="reason" rows="4" required></textarea>
                    </div>

                    <input type="submit" value="Submit" name="submit" class="submit-button">
                </form>
            </div>
            <div class="footer">
                &copy; 2023 Leave Application
            </div>
        </div>
         <%
     if("POST".equals(request.getMethod()) && request.getParameter("submit")!=null)
        {
        %>
        

        <sql:setDataSource var="con" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/a2_ajava" user="root" password="root" scope="session"/>
        <sql:update dataSource="${con}" var="result" scope="session">
            insert into leave_application (leave_type,start_date,end_date,reason,user_id) values (?,?,?,?,?);
            <sql:param value="${param.leaveType}"/>
            <sql:param value="${param.startDate}"/>
            <sql:param value="${param.endDate}"/>
            <sql:param value="${param.reason}"/>        
            <sql:param value="${sessionScope.userid}"/>        


        </sql:update>

        <c:if test="${result == 1}">
            <c:redirect url="index.jsp"/>
        </c:if>
        
        <%
            }
        %>
    </body>
</html>
