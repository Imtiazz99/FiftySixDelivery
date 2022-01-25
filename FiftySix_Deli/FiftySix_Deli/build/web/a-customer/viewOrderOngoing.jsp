<%-- 
    Document   : viewOrderOngoing
    Created on : 15 Feb 2021, 5:22:45 pm
    Author     : TK
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@page import="henshin.model.LoginBean"%>
<% 
    response.setHeader("Cache-Control","no-cache, no-store,must-revalidate");  
    response.setHeader("Pragma","no-cache"); 
    response.setHeader("Expires","0");
    
    LoginBean rider = (LoginBean) session.getAttribute("logUser");
    if(rider==null){
        response.sendRedirect("a-customer/login.jsp");
    }
%>
<html>
    <head>
    <meta charset="UTF-8">
    <title>FiftySix | Order Tracking</title>
    <link rel="shortcut icon" href="image/logo-56.jpg">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lykmapipo/themify-icons@0.1.2/css/themify-icons.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/addons/datatables.min.css">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/dashboard.css">
    <link rel="stylesheet" href="css/mdb.min.css">  
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/menu.css">
    <style>
     .mySlides {display:none;}
    </style>
</head>
    <body>
        <header>
            <div class="website-name">
                <h5>
                    <span>FiftySix Kitchen</span>
                </h5>
            </div>
            <ul>
                <li><a href="a-customer/index.jsp">Home</a></li>
                <li><a href="/FiftySix_Deli/menuController?action=viewMenus">Menu</a></li>
                <li><a href="/FiftySix_Deli/orderCustController?action=viewPending&cust_id=<%= session.getAttribute("cust_id")%>" class="active">Orders</a></li>
                <li><a href="/FiftySix_Deli/customerController?action=viewProfile&email=<%= session.getAttribute("email")%>" >My Profile</a></li>
                <li><a href="/FiftySix_Deli/cartController?action=viewCart&email=<%= session.getAttribute("email") %>&cust_id=<%= session.getAttribute("cust_id") %>"><i class="fa fa-shopping-cart"></i></a></li>
              <li><a href="a-customer/LogoutServlet"><i class="fas fa-sign-out-alt"></i></a></li>
            </ul>
        </header>
            
    <main style="padding: 40px;">
        <h4>List of on Going Order</h4>        
        <div class="category" >
            <ul>
                <li ><a href="/FiftySix_Deli/orderCustController?action=viewPending&cust_id=<%= session.getAttribute("cust_id")%>">Pending</a></li>
                <li class="active"><a href="#" >On-going</a></li>
                <li><a href= "/FiftySix_Deli/orderCustController?action=orderCustomer&cust_id=<%= session.getAttribute("cust_id")%>">Completed</a></li>
            </ul>                           
            </div>
        <br><br>
        <table id="dt-basic-checkbox" class="table table-striped table-bordered" cellspacing="0" width="100%">
            <thead>
            <tr>
                <th>No.</th>
                <th>Order ID</th>
                <th>Menu Name</th>
                <th>Quantity</th>
                <th>Total (RM)</th>
                <th>Status</th>
            </tr>
            </thead>
            <tbody>
                
            <c:set var="i" value="1" scope="page"/>  
            <c:forEach items= "${orders}" var= "orders" >
                <c:if test="${orders.statusID == '1' || orders.statusID == '2' || orders.statusID == '3'}">
                <tr>
                 <td><c:out value="${i}"/></td>   
                 <td><c:out value="${orders.orderid}"/></td>
                 <td><c:out value="${orders.menuname}"/></td>
                 <td><c:out value="${orders.quantity}"/></td>
                 <td><c:out value="${orders.totPayment}"/></td>
                 <td><c:out value="${orders.status}"/></td>
                 </c:if>
                 </tr>
                <c:set var="i" value="${i+1}" scope="page"/>
                </c:forEach>
            </tbody>    
        </table>
    </main>
    </div><!--close div main-content -->
    </body>
</html>
