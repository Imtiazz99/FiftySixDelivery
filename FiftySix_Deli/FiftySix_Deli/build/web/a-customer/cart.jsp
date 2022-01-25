<%-- 
    Document   : Cart
    Created on : 27 Dec 2020, 5:30:13 pm
    Author     : Amirah Haziqah
--%>

<%@page import="henshin.model.menuBean"%>
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
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FiftySix | Menu</title>
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
                <li><a href="/FiftySix_Deli/orderCustController?action=viewPending&cust_id=<%= session.getAttribute("cust_id")%>" >Orders</a></li>
                <li><a href="/FiftySix_Deli/customerController?action=viewProfile&email=<%= session.getAttribute("email")%>">My Profile</a></li>
                <li><a href="/FiftySix_Deli/cartController?action=viewCart&email=<%= session.getAttribute("email") %>&cust_id=<%= session.getAttribute("cust_id") %>"  class="active"><i class="fa fa-shopping-cart"></i></a></li>
               <li><a href="a-customer/LogoutServlet"><i class="fas fa-sign-out-alt"></i></a></li>
            </ul>

        </header>
        <main>
            <br>
              <h4>Your Shopping Cart</h4><br>
            <table id="dt-basic-checkbox" class="table table-striped table-bordered" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>Menu Image</th>
                        <th>Menu Name</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Action</th>
                    </tr>   
                </thead> 
                <tbody>
            <c:set var="i" value="1" scope="page"/>
            <c:set var="total" value="${0}" />
            <c:forEach items="${carts}" var="carts">
                <c:set var="id" value="${carts.cartID}" />
                <tr>
                    <td><c:out value="${i}"/></td>
                    <td><img src="data:image/jpg;base64,${carts.base64Image}" width="240" height="300"/></td>
                    <td><c:out value="${carts.menuName}"/></td>
                    <td><c:out value="${carts.menuPrice}"/></td>
                  <c:set var="total" value="${total + carts.menuPrice}" />
                    <td><c:out value="${carts.qty}"/></td>
                    <td>
                        <a href="/FiftySix_Deli/cartController?action=deleteCart&cart_ID=<c:out value="${carts.cartID}"/>&email=<%=session.getAttribute("email")%>"><i class="fas fa-times" aria-hidden="true" style="color:red"></i></a>
                    </td>
                </tr>
            <c:set var="i" value="${i+1}" scope="page"/>
            </c:forEach>
                    <tr>
                        <td colspan="3" style="text-align: right"><strong>Total Amount(RM)</strong></td>
                        <td colspan="3" style="text-align: left"><strong><c:out value="${total}"/></strong></td>
                    </tr>   
                </tbody>
            </table>
                <a href="/FiftySix_Deli/paymentController?action=viewDetails&email=<%= session.getAttribute("email")%>&total=<c:out value="${total}"/>&cust_id=<%= session.getAttribute("cust_id") %>"> <button class="button btn2">Order Details</button></a>
                <a href="/FiftySix_Deli/menuController?action=viewMenus"><button class="button btn2">Continue Shopping</button></a>
        </main>
    </div>
  
             
  <!--semua table-->
  <script type="text/javascript" src="js/table.js"></script>
  <script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
  <!-- Bootstrap tooltips -->
  <script type="text/javascript" src="js/popper.min.js"></script>
  <!-- Bootstrap core JavaScript -->
  <script type="text/javascript" src="js/bootstrap.min.js"></script>
  <!-- MDB core JavaScript -->
  <script type="text/javascript" src="js/mdb.min.js"></script>
  <script type="text/javascript" src="js/addons/datatables.min.js"></script>
  <script>
      $('.feat-btn').click(function(){
          $('.sidebar ul .feat-show').toggleClass("show");
      });
  </script>
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
