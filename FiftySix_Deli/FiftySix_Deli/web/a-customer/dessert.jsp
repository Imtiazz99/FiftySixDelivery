<%-- 
    Document   : menu
    Created on : 27 Dec 2020, 5:30:13 pm
    Author     : 
--%>

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
        <link rel="stylesheet" href="css/menu.css">

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
                <li><a href="/FiftySix_Deli/menuController?action=viewMenus" class="active">Menu</a></li>
                <li><a href="/FiftySix_Deli/orderCustController?action=viewPending&cust_id=<%= session.getAttribute("cust_id")%>">Orders</a></li>
                <li><a href="/FiftySix_Deli/customerController?action=viewProfile&email=<%= session.getAttribute("email")%>">My Profile</a></li>
                <li><a href="/FiftySix_Deli/cartController?action=viewCart&email=<%= session.getAttribute("email") %>&cust_id=<%= session.getAttribute("cust_id") %>"><i class="fa fa-shopping-cart"></i></a></li>
                <li><a href="a-customer/LogoutServlet"><i class="fas fa-sign-out-alt"></i></a></li>
            </ul>

        </header>
        <main>
    
    <div class="menu">
        <p>Menu</p>
            </div><br>
                <div class="category">
                <ul>
                    <li><a href="/FiftySix_Deli/menuController?action=viewMenus">Whole Cake</a></li>
                    <li><a href="/FiftySix_Deli/menuController?action=viewCupcake">Cup Cake</a></li>
                    <li class="active"><a href="/FiftySix_Deli/menuController?action=viewDessert">Dessert</a></li>
                    <li><a href="/FiftySix_Deli/menuController?action=viewCookies">Cookies</a></li>
                </ul>
            </div>
            <br><br><br>
        <div class="wrapper">
            
            <c:forEach items="${menu}" var="menu">
                <c:if test="${menu.menuCat==4}">
                    <div class="single-menu">
                         <img src="data:image/jpg;base64,${menu.base64Image}"/>
                        <div class="menu-content">
                            <h4><c:out value="${menu.menuName}" /> <span>RM <c:out value="${menu.menuPrice}" /></span> </h4>
                            <p><c:out value="${menu.menuDesc}" /></p>
                            <a href="/FiftySix_Deli/cartController?action=addToCart&menu_ID=<c:out value="${menu.menuID}"/>&email=<%= session.getAttribute("email") %>&qty=1&cust_id=<%= session.getAttribute("cust_id") %>"><button onclick="addToCart('<c:out value="${menu.menuID}" />')">Add To Cart</button></a>
                        </div>
                    </div>
                   </c:if>
                </c:forEach>
            <!--
            <table border="2px" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>Menu Image</th>
                        <th>Menu Name</th>
                        <th>Price</th>
                        <th>Description</th>
                        <th>Action</th>
                    </tr>
                </thead> 
                <tbody>-->
                    <%--<c:forEach items="${menu}" var="menu">
                        <c:if test="${menu.menuCat==1}">
                        <tr> 
                            <td><img src="data:image/jpg;base64,${menu.base64Image}" width="240" height="300"/></td>
                            <td><c:out value="${menu.menuName}" /></td>
                            <td><c:out value="${menu.menuPrice}" /></td>
                            <td><c:out value="${menu.menuDesc}" /></td>
                            <td><a href="/FiftySix_Deli/cartController?action=addToCart&menu_ID=<c:out value="${menu.menuID}"/>&email=<%= session.getAttribute("email") %>&qty=1&cust_id=<%= session.getAttribute("cust_id") %>"><button onclick="addToCart('<c:out value="${menu.menuID}" />')">Add To Cart</button></a></td>
                            <!--<td><a style="color: goldenrod" class="btn btn-primary" href="/FiftySix_Deli/cartController?action=addToCart&menu_ID=<c:out value="${menu.menuID}"/>">Add To Cart</a></td>   --> 
                        </tr>
                        </c:if>
                    </c:forEach>--%>
               <!-- </tbody>
            </table>
            -->    
        </div> 
<!--Wrapper ends-->
            
            
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
