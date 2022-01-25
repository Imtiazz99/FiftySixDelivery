<%-- 
    Document   : orderComplete
    Created on : 11 Feb 2021, 12:31:25 am
    Author     : TK
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language ="java" %>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*,java.io.*,java.util.*" %>
<%@page import="henshin.model.RiderLoginBean"%>
<% 
    response.setHeader("Cache-Control","no-cache, no-store,must-revalidate");  
    response.setHeader("Pragma","no-cache"); 
    response.setHeader("Expires","0");
    
    RiderLoginBean rider = (RiderLoginBean) session.getAttribute("logRider");
    if(rider==null){
        response.sendRedirect("a-rider/riderlogin.jsp");
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lykmapipo/themify-icons@0.1.2/css/themify-icons.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
        <link rel="stylesheet" href="css/addons/datatables.min.css">
        <link rel="stylesheet" href="css/profile.css">    
        <link rel="stylesheet" href="css/dashboard.css">
        <link rel="stylesheet" href="css/mdb.min.css">
        <title>Order Complete</title>
    </head>
    <body>      
    <div class="sidebar">
        <div class="sidebar-user">
            <img src="image/fox.png">
            <div class="user-image">
                  <p>Rider: <%=session.getAttribute("rider_email")%> </p>
            </div>
        </div>
        <div class="sidebar-menu">
            <hr>
            <ul>
                <li><a href="/FiftySix_Deli/a-rider/index.jsp">Home</a></li>
                  <li><a href="/FiftySix_Deli/riderController?action=viewProfile&email=<%= session.getAttribute("rider_email")%>">My Profile</a></li>
                <li class="active">
                    <a href="#" class="feat-btn">Manage Order
                        <span class="fas fa-caret-down"></span>
                    </a>
                </li>
                <ul class="feat-show">
                    <li><a href="/FiftySix_Deli/orderCustController?action=viewOrderCust&ID=<%= session.getAttribute("rider_id")%>">On-going</a></li>
                    <li><a href="/FiftySix_Deli/orderCustController?action=viewCompOrder&ID=<%= session.getAttribute("rider_id")%>">Completed</a></li>
                </ul>
                <li><a href="a-rider/RiderLogoutServlet">Logout</a></li>
            </ul>
        </div>
    </div>
        
        <div class="main-content">
            <header>
            <div class="website-name">
              <h5>
                <span>FiftySix Kitchen</span>
              </h5>
            </div>
        </header>
            <main>
        <h1 style="margin-top:100px;">Completed Orders</h1>
        <table id="dt-basic-checkbox" class="table table-striped table-bordered" cellspacing="0" width="100%">
            <thead>
            <tr>
                <th>Customer Name</th>
                <th>Phone Number</th>
                <th>Address</th>
                <th>Menu Name</th>
                <th>Quantity</th>
                <th>Order Time</th>
                <th>Delivery Time</th>
                <th>Complete Time</th>  
                <th>Price (RM)</th> 
            </tr>
            </thead>
            <tbody>
            <c:forEach items= "${orders}" var= "orders" >
                 <c:if test="${orders.statusID == 4}">
                 <tr>                 
                 <td><c:out value="${orders.cust_name}"/></td>
                 <td><c:out value="${orders.phone_no}"/></td>
                 <td><c:out value="${orders.street}"/> <c:out value="${orders.city}"/> <c:out value="${orders.state}"/> <c:out value="${orders.postcode}"/></td>
                 <td><c:out value="${orders.menuname}"/></td>
                 <td><c:out value="${orders.quantity}"/></td>
                 <td><c:out value="${orders.order_time}"/></td>
                 <td><c:out value="${orders.delivery_time}"/></td>
                 <td><c:out value="${orders.complete_time}"/></td> 
                 <td><c:out value="${orders.totPayment}"/></td>
                </tr>  
                 </c:if>
            </c:forEach>  
            </tbody>    
          </table>
        </main>
    </div><!--close div main-content -->
    <!--semua table-->
  <script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
  <!-- Bootstrap tooltips -->
  <script type="text/javascript" src="js/popper.min.js"></script>
  <!-- Bootstrap core JavaScript -->
  <script type="text/javascript" src="js/bootstrap.min.js"></script>
  <!-- MDB core JavaScript -->
  <script type="text/javascript" src="js/mdb.min.js"></script>
  <script type="text/javascript" src="js/addons/datatables.min.js"></script>
  <!-- sidebar tunjuk anak2-->
  <script>
      $('.feat-btn').click(function(){
          $('.sidebar ul .feat-show').toggleClass("show");
      });
  </script>
  <!--table-->
  <script>
  function checkAll(bx) {
  var cbs = document.getElementsByTagName('input');
  for(var i=0; i < cbs.length; i++) {
    if(cbs[i].type === 'checkbox') {
      cbs[i].checked = bx.checked;
    }
  }
}

$(document).ready(function() {
    $('#example').DataTable(

         {

      "aLengthMenu": [[5, 10, 25, -1], [5, 10, 25, "All"]],
        "iDisplayLength": 5
       }
        );
} );

$('#dt-basic-checkbox').dataTable({

    columnDefs: [{
    orderable: false,
    className: 'select-checkbox',
    targets: 0
    }],
    select: {
    style: 'os',
    selector: 'td:first-child'
    }
    });
  </script> 
    </body>
</html>
