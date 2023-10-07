<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,java.util.*"%>
<%
    if(session.getAttribute("user_email")==null){
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>User Dashboard</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f5f5f5;
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

            .welcome {
                font-size: 24px;
                padding: 20px;
                text-align: center;
            }

            .leave-section {
                max-height: 300px; /* Set a maximum height for the leave list */
                overflow-y: auto; /* Add vertical scroll when needed */
                padding: 20px;
            }

            .leave-section h2 {
                color: #3498db;
                font-size: 24px;
            }

            .leave-list {
                list-style: none;
                padding: 0;
            }

            .leave-item {
                background-color: #fff;
                border: 1px solid #ddd;
                margin: 10px 0;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
                cursor: pointer;
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
                display: none;
            }

            .leave-status {
                float: right;
                font-weight: bold;
                color: #27ae60;
            }

            .footer {
                background-color: #3498db;
                color: #fff;
                padding: 10px;
                text-align: center;
                border-bottom-left-radius: 5px;
                border-bottom-right-radius: 5px;
            }
        </style>
    </head>
    <body>
        <sql:setDataSource var="con" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/a2_ajava" user="root" password="root" scope="session"/>
        <sql:query dataSource="${con}" var="result">
            select * from leave_application where user_id=?;
            <sql:param value="${sessionScope.userid}"/>
        </sql:query>

        <div class="navbar">
            <a href="Logout">Logout</a>
            <a href="leaveStatus.jsp">Leave Status</a>
            <a href="leaveApplication.jsp">Apply for Leave</a>
        </div>
        <div class="container">
            <div class="header">
                <h1>User Dashboard</h1>
            </div>
            <div class="welcome">
                Welcome, ${sessionScope.username}
            </div>
            <div class="leave-section">
                <h2>Approved Leaves</h2>
                <ul class="leave-list">
                    <c:forEach var="row" items="${result.rows}">
                        <sql:query dataSource="${con}" var="user">
                            select * from users where id=?;
                            <sql:param value="${row.user_id}"/>
                        </sql:query> 
                        <c:set var="availableApplication" value="false" scope="session"/>
                        <c:if test="${row.status==1}">
                            <c:set var="availableApplication" value="true" scope="session"/>
                            <li class="leave-item">
                                <div class="leave-title">Leave Application</div>
                                <div class="leave-details">
                                    <p><strong>Username:</strong> ${user.rows[0].name}</p>
                                    <p><strong>Leave Type: </strong>${row.leave_type}</p>
                                    <p><strong>Reason:</strong> ${row.reason}</p>
                                    <p><strong>From:</strong> ${row.start_date}</p>
                                    <p><strong>To:</strong> ${row.end_date}</p>
                                    <span class="leave-status">Approved</span>
                                </div>
                            </li>

                        </c:if>
                    </c:forEach>
                    <c:if test="${!availableApplication}">
                        <h1  style="text-align:center;color:red;">No Approved Leave Application Found!</h1>
                    </c:if>
                    <!--                <li class="leave-item">
                                        <div class="leave-title">Leave Application 2</div>
                                        <div class="leave-details">
                                            <p><strong>Username:</strong> Jane Smith</p>
                                            <p><strong>Reason:</strong> Sick Leave</p>
                                            <p><strong>From:</strong> 2023-11-03</p>
                                            <p><strong>To:</strong> 2023-11-05</p>
                                            <span class="leave-status">Approved</span>
                                        </div>
                                    </li>-->
                    <!-- Add more leave application items as needed -->
                </ul>
            </div>
            <div class="footer">
                &copy; 2023 User Dashboard
            </div>
        </div>
        <script>
            const leaveItems = document.querySelectorAll('.leave-item');
            leaveItems.forEach((item) => {
                item.addEventListener('click', () => {
                    const leaveDetails = item.querySelector('.leave-details');
                    leaveDetails.style.display = (leaveDetails.style.display === 'none') ? 'block' : 'none';
                    leaveDetails.style.overflowY = (leaveDetails.style.overflowY === 'hidden') ? 'auto' : 'hidden';
                });
            });
        </script>
    </body>
</html>
