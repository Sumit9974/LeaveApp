<%-- 
    Document   : admin
    Created on : Oct 6, 2023, 10:23:41 AM
    Author     : sumit
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%
    if(session.getAttribute("user_email")==null){
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
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
            min-height: 450px;
            overflow: scroll;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            position: relative;
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

        .leave-list {
            padding: 20px;
        }

        .leave-item {
            background-color: #fff;
            border: 1px solid #ddd;
            margin: 10px 0;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            transition: background-color 0.2s ease;
        }

        .leave-item:hover {
            background-color: #f5f5f5;
        }

        .leave-title {
            font-weight: bold;
            font-size: 1.2em;
            color: #333;
            margin-bottom: 10px;
        }

        .leave-details {
            color: #666;
            font-size: 0.9em;
        }

        .button-group {
            display: flex;
            justify-content: flex-end;
            margin-top: 10px;
        }

        .approve-button,
        .deny-button {
            background-color: #27ae60;
            color: #fff;
            padding: 5px 10px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            margin-left: 10px;
        }

        .deny-button {
            background-color: #e74c3c;
        }

        .approve-button:hover,
        .deny-button:hover {
            opacity: 0.8;
        }

        .footer {
            background-color: #3498db;
            color: #fff;
            padding: 10px;
            text-align: center;
            border-bottom-left-radius: 5px;
            border-bottom-right-radius: 5px;
            position: absolute;
            bottom: 0;
            width: calc(100% - 20px);
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
            .nla{
                color:red;
                text-align: center;
            }
    </style>
<!--        <div class="leave-item">
                <div class="leave-title">Leave Application 1</div>
                <div class="leave-details">
                    <p><strong>Username:</strong> John Doe</p>
                    <p><strong>Reason:</strong> Vacation</p>
                    <p><strong>From:</strong> 2023-10-15</p>
                    <p><strong>To:</strong> 2023-10-20</p>
                </div>
                <div class="button-group">
                    <button class="approve-button">Approve</button>
                    <button class="deny-button">Deny</button>
                </div>
            </div>-->
</head>
<body>
      <sql:setDataSource var="con" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/a2_ajava" user="root" password="root" scope="session"/>
      <sql:query dataSource="${con}" var="result">
          select * from leave_application;
      </sql:query>
     <div class="navbar">
            <!--<a href="index.jsp">Home</a>-->
            <a href="Logout">Logout</a>
        </div>
    <div class="container">
        <div class="header">
            <h1>Admin Dashboard</h1>
        </div>
            
        <div class="leave-list">
            <c:set var="availableApplication" value="false" scope="session"/>
          
        <c:forEach var="row" items="${result.rows}">
            <sql:query dataSource="${con}" var="user">
                select * from users where id=?;
                <sql:param value="${row.user_id}"/>
            </sql:query> 
                <c:if test="${row.status==0}">
                    <c:set var="availableApplication" value="true" scope="session"/>
            <div class="leave-item">
                <div class="leave-title">Leave Application</div>
                <div class="leave-details">
                    <p><strong>Name: </strong>${user.rows[0].name}</p>
                    <p><strong>Leave Type: </strong>${row.leave_type}</p>
                    <p><strong>Reason: </strong> ${row.reason}</p>
                    <p><strong>From: </strong> ${row.start_date}</p>
                    <p><strong>To: </strong> ${row.end_date}</p>
                </div>
                <div class="button-group">
                    
                    <a href="LeaveApprovalProcess?id=${row.user_id}&type=approve&leave_type=${row.leave_type}"><button class="approve-button" name="btn" value="approve">Approve</button></a>
                    <a href="LeaveApprovalProcess?id=${row.user_id}&type=deny&leave_type=${row.leave_type}"><button class="deny-button">Deny</button></a>
                </div>
            </div>
    
                </c:if>
        </c:forEach>
             <c:if test="${!availableApplication}">
                <h1 class="nla">No Leave Application Found!</h1>
            </c:if>
           
            <!-- Add more leave application items as needed -->
        </div>
        
        <div class="footer">
            &copy; 2023 Admin Dashboard
        </div>
    </div>
</body>
</html>
