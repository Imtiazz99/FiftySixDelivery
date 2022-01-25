<%-- 
    Document   : index
    Created on : Feb 7, 2021, 10:38:20 PM
    Author     : Aina Syazana 
--%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


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
    <title>FiftySix | My Profile</title>
    <link rel="shortcut icon" href="image/logo-56.jpg">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lykmapipo/themify-icons@0.1.2/css/themify-icons.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" >
    <link rel="stylesheet" href="css/addons/datatables.min.css">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/dashboard.css">
    <link rel="stylesheet" href="css/profile.css">
    <link rel="stylesheet" href="css/cust-nav.css">
    <link rel="stylesheet" href="css/mdb.min.css">
    
   
</head>

<body>
    <div class="sidebar-cust">
        <div class="sidebar-menu">
            <ul style="margin-top: 60px;">
                <li><a href="/FiftySix_Deli/customerController?action=viewProfile&email=<%= session.getAttribute("email")%>">My Profile</a></li>
                <li><a class="active" href="#">My Addresses</a></li>
                <li><a href="a-customer/password.jsp?&email=<%= session.getAttribute("email")%>">Change Password</a></li>
            </ul>
        </div>
    </div>
        <header>
            <div class="website-name">
              <h5>
                <span>FiftySix Kitchen</span>
              </h5>
            </div>
        <ul>
                <li><a href="a-customer/index.jsp">Home</a></li>
                <li><a href="/FiftySix_Deli/menuController?action=viewMenus" >Menu</a></li>
                <li><a href="/FiftySix_Deli/orderCustController?action=viewPending&cust_id=<%= session.getAttribute("cust_id")%>">Orders</a></li>
                <li><a href="/FiftySix_Deli/customerController?action=viewProfile&email=<%= session.getAttribute("email")%>" class="active">My Profile</a></li>
                <li><a href="/FiftySix_Deli/cartController?action=viewCart&email=<%= session.getAttribute("email") %>&cust_id=<%= session.getAttribute("cust_id") %>"><i class="fa fa-shopping-cart"></i></a></li>
                <li><a href="a-customer/LogoutServlet"><i class="fas fa-sign-out-alt"></i></a></li>
        </ul>
        </header> 

        <main>
            <div class="profile-container" style="margin-left: 350px;">
            <h4>List of Addresses</h4>
            <table  id="dt-basic-checkbox" class="table table-striped table-bordered" cellspacing="0" width="100%">
          <thead>
                <tr>
                 <th>No</th>
                 <th>Street Name</th>
                 <th>City</th>
                 <th>State</th>
                 <th>Postcode</th>
                 <th>Action</th>
                </tr>
           </thead>
           <tbody>
           <!--kena sama nama dengan dalam bean-->
           <c:set var="i" value="1" scope="page"/>
           <c:forEach items="${customer}" var="customer">            
                <tr>
                 <td><c:out value="${i}"/></td>
                 <td><c:out value="${customer.street}"/></td>
                 <td><c:out value="${customer.city}"/></td>
                 <td><c:out value="${customer.state}"/></td>
                 <td><c:out value="${customer.postcode}"/></td>
                 <td>
                    <center>
                        <a href="/FiftySix_Deli/customerController?action=deleteAddress&address_ID=<c:out value="${customer.addressID}"/>&custID=<%= session.getAttribute("cust_id") %>"><i class="fas fa-times" onclick="return confirm('Are you sure you want to delete this address?')" aria-hidden="true" style="color:red"></i></a>
                    </center>
                 </td>
                </tr>
                <c:set var="i" value="${i+1}" scope="page"/>
           </c:forEach>  
           </tbody>
         </table>

         <a href="a-customer/address.jsp?custID=<%= session.getAttribute("cust_id")%>"><button class="button btn1">Add Address</button></a>
        </div>
        </main>

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
    targets: [3]
    }],
    select: {
    style: 'os',
    selector: 'td:first-child'
    }
    });
  </script> 
  </script> 
  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
 <%
                              if(request.getAttribute("successr") == null) {
                                  out.println("");
                              }   
                              else {
                                     out.println("<script>swal('Address Successfully Deleted!','','success')</script>");
                              }
                        
 %>
 
 <%
                              if(request.getAttribute("addr") == null) {
                                  out.println("");
                              }   
                              else {
                                     out.println("<script>swal('Address Successfully Added!','','success')</script>");
                              }
                        
 %>
</body>
</html>
