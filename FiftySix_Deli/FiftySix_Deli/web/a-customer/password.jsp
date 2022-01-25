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
        response.sendRedirect("login.jsp");
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
    <link rel="stylesheet" href="../css/addons/datatables.min.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/dashboard.css">
    <link rel="stylesheet" href="../css/profile.css">
    <link rel="stylesheet" href="../css/cust-nav.css">
    <link rel="stylesheet" href="../css/mdb.min.css">
    
   
</head>

<body>
    <div class="sidebar-cust">
        <div class="sidebar-menu">
            <ul style="margin-top: 60px;">
                <li><a href="/FiftySix_Deli/customerController?action=viewProfile&email=<%= session.getAttribute("email")%>">My Profile</a></li>
                <li><a href="/FiftySix_Deli/customerController?action=viewAddress&custID=<%= session.getAttribute("cust_id")%>">My Addresses</a></li>
                <li><a class="active" href="#">Change Password</a></li>
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
                <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i></a></li>
        </ul>
        </header> 

        <main>
                <div class="profile-container" style="margin-left: 350px;">
                <h4>Change new Password</h4>
                <div class="profile-form">
                    <form method="post" action="../customerController?action=updatePassword&email=<%=session.getAttribute("cust_id")%>">
                    
                    <table>
                        <tr>
                            <td>
                                <label>Enter old password</label>
                                <input type="password" name="oPass" required>
                            </td>
                            <td>
                                 
                            </td>                     
                        </tr>
                        <tr>
                            <td>
                                 <label>Enter new password</label>
                                 <input type="password" name="nPass" required>
                            </td> 
                            <td>
                                <label>Re-enter new password</label>
                                <input type="password" name="cPass" required>
                            </td>
                        </tr>
                    </table>
                        <input type="submit" value="Update" name="update">
                    </form>
                </div>
                </div>
        </main>

  <!--semua table-->
  <script type="text/javascript" src="../js/jquery-3.4.1.min.js"></script>
  <!-- Bootstrap tooltips -->
  <script type="text/javascript" src="../js/popper.min.js"></script>
  <!-- Bootstrap core JavaScript -->
  <script type="text/javascript" src="../js/bootstrap.min.js"></script>
  <!-- MDB core JavaScript -->
  <script type="text/javascript" src="../js/mdb.min.js"></script>
  <script type="text/javascript" src="../js/addons/datatables.min.js"></script>
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
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
   <%
                              if(request.getAttribute("passwordr") == null) {
                                  out.println("");
                              }   
                              else {
                                     out.println("<script>swal('Password Successfully Updated!','','success')</script>");
                              }
                        
 %>
   <%
                              if(request.getAttribute("passwordrw") == null) {
                                  out.println("");
                              }   
                              else {
                                     out.println("<script>swal('Password Failed To Update!','','error')</script>");
                              }
                        
 %>
</body>
</html>
