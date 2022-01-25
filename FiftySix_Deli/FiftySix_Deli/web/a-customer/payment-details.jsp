<%-- 
    Document   : signup
    Created on : 6 Feb 2021, 07:31:32 am
    Author     : Amirah Haziqah
--%>
<%@page import="henshin.model.paymentBean"%>
<%@page import="henshin.model.menuBean"%>
<a href="payment.jsp"></a>
<%@page import="henshin.dao.menuDAO"%>
<%@page import="henshin.model.cartBean"%>
<%@page import="henshin.connection.ConnectionManager"%>
<%@page import="henshin.dao.cartDAO"%>
<%@page import="java.util.ListIterator"%>
<%@page import="java.util.List"%>
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

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FiftySix Kitchen | Payment</title>
    <!--icons-->
    <link rel="shortcut icon" href="image/logo-56.jpg">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lykmapipo/themify-icons@0.1.2/css/themify-icons.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css">
    
    <link rel="stylesheet" href="css/addons/datatables.min.css">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/mdb.min.css">
    <link rel="stylesheet" href="css/menu.css">
    <link rel="stylesheet" href="css/profile.css">
</head>

<body>
    <div class="main-content">
        <header>
            <div class="website-name">
                <h5>
                    <span>FiftySix Kitchen</span>
                </h5>
            </div>
            <ul>
                <li><a href="a-customer/index.jsp">Home</a></li>
                <li><a href="/FiftySix_Deli/menuController?action=viewMenus">Menu</a></li>
                <li><a href="/FiftySix_Deli/orderCustController?action=viewPending&cust_id=<%= session.getAttribute("cust_id")%>">Orders</a></li>
                <li><a href="/FiftySix_Deli/customerController?action=viewProfile&email=<%= session.getAttribute("email")%>">My Profile</a></li>
                <li><a class="active" href="/FiftySix_Deli/cartController?action=viewCart&email=<%= session.getAttribute("email") %>&cust_id=<%= session.getAttribute("cust_id") %>"><i class="fa fa-shopping-cart"></i></a></li>
              <li><a href="a-customer/LogoutServlet"><i class="fas fa-sign-out-alt"></i></a></li>
            </ul>
        </header>
       
    
    <% 
        double total = Double.parseDouble(request.getParameter("total"));
    
    %>   
                 <main> 
                     <br>
                     <h4>Your Order Details</h4><br>
                     <table id="dt-basic-checkbox" class="table table-striped table-bordered" cellspacing="0" width="100%">
                          <thead>
                              <tr>
                                  <td width="5%">No</td>
                                  <td width="60%">Menu Name</td>
                                  <td width="5%" >Quantity</td>
                                  <td width="20%">Menu Price (RM)</td>
                              </tr>
                          </thead>
                     <c:set var="i" value="1" scope="page"/>
                      <c:forEach items="${pays}" var="pays"> 
                          <tr>
                              <td><c:out value="${i}"/></td>
                              <td><c:out value="${pays.menuName}"/></td>
                              <td><c:out value="${pays.qty}"/></td>
                              <td><c:out value="${pays.menuPrice}"/></td>
                          </tr>
                        <c:set var="i" value="${i+1}" scope="page"/>
                      </c:forEach>
                      <tr>
                          <td colspan="3" style="text-align: right"><strong>Total Amount(RM)</strong></td>
                          <td colspan="1" style="text-align: left"><strong><%=total %></strong></td>
                      </tr>   
                  </table>   
                      <a href="/FiftySix_Deli/paymentController?action=viewPaymentDetails&email=<%= session.getAttribute("email")%>&total=<%=total %>&cust_id=<%= session.getAttribute("cust_id") %>&order_id=<%= session.getAttribute("order_id") %>"> <button  class="button btn2">Proceed to Payment</button></a> 
                      <a  onclick="javascript:history.go(-1)"><button class="button btn2">Back</button></a>
      
                </main> 
</div>
</body>
</html>