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
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
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
                <li><a  class="active" href="#">My Profile</a></li>
                <li><a href="/FiftySix_Deli/customerController?action=viewAddress&custID=<%= session.getAttribute("cust_id")%>">My Addresses</a></li>
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
                <li><a href="/FiftySix_Deli/menuController?action=viewMenus">Menu</a></li>
                <li><a href="/FiftySix_Deli/orderCustController?action=viewPending&cust_id=<%= session.getAttribute("cust_id")%>">Orders</a></li>
                <li><a href="/FiftySix_Deli/customerController?action=viewProfile&email=<%= session.getAttribute("email")%>" class="active">My Profile</a></li>
                <li><a href="/FiftySix_Deli/cartController?action=viewCart&email=<%= session.getAttribute("email") %>&cust_id=<%= session.getAttribute("cust_id") %>"><i class="fa fa-shopping-cart"></i></a></li>
               <li><a href="a-customer/LogoutServlet"><i class="fas fa-sign-out-alt"></i></a></li>
        </ul>
        </header> 

        <main>
            <div class="profile-container" style="margin-left: 350px;">
                <h4>Profile</h4>
                <div class="profile-form">
                    <form name="profile" method="post" action="customerController?action=updateProfile&custID=<%=session.getAttribute("cust_id")%>">
                    
                    <table>
                        <tr>
                            <td>
                                <label>Full name (E.g John Doe)</label>
                                <input type="text" name="custName" id="custName" maxlength="40" value="<c:out value="${customer.custName}"/>">
                            </td>
                            <td>
                                 <label>E-mail address (E.g Johndoe@gmail.com)</label>
                                 <input type="text" name="email" id="email" maxlength="40" value="<c:out value="${customer.email}"/>">
                            </td>                     
                        </tr>
                        <tr>
                            <td>
                                <label>Contact number (E.g 0123456789)</label>
                                <input type="text" name="phoneNo" id="phoneNo" maxlength="10"  value="<c:out value="${customer.phoneNo}"/>">
                            </td>
                        </tr>
                    </table>
                        <input type="submit" value="Update" name="update" onClick="return validate()">
                    </form>
                </div>
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
    targets: 0
    }],
    select: {
    style: 'os',
    selector: 'td:first-child'
    }
    });
  </script> 
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" ></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" ></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    
    <script type="text/javascript"> 
    function validate(){
            var phoneNo=document.profile.phoneNo.value;
            var letters=/^[a-zA-Z ]*$/;
            var emailletters=/^([a-z 0-9\.-]+)@([a-z0-9-]+).([a-z]{2,8})(.[a-z]{2,8})?$/;     
            var number=/^[0-9]*$/;
            
             if(document.getElementById('custName').value == ""){
                swal('Name cannot be blank');
                return false;
            }
            
            if(!document.getElementById('custName').value.match(letters)){
                swal("Name must contain only alphabets","E.g John Doe")
                return false;
            }     
            
              if(document.getElementById('email').value == ""){
                swal('Email cannot be blank');
                return false;
            } 
            
            if(!document.getElementById('email').value.match(emailletters)){
                swal("Email address format are invalid","E.g Johndoe@gmail.com")
                return false;
            }
            
             if(document.getElementById('phoneNo').value == ""){
                swal('Phone number cannot be blank');
                return false;
            } 
            
            if(!document.getElementById('phoneNo').value.match(number)){
                swal("Phone number must contain only numbers","E.g 0123456789");
              return false;
            }
            
             if(phoneNo.length<10){
              swal("Invalid Phone Number Format","Phone number should be 10 number E.g 0123456789");
              return false;
          }  
            
              return true;
            }
         
    
     
        function numbersOnly(input){
            var regex = /[^0-9]/g;
            input.value = input.value.replace(regex,"");    
        }
        
   </script>
    
 <%
                              if(request.getAttribute("successr") == null) {
                                  out.println("");
                              }   
                              else {
                                     out.println("<script>swal('Profile Successfully Updated!','','success')</script>");
                              }
                        
 %>
<%
                              if(request.getAttribute("addr") == null) {
                                  out.println("");
                              }   
                              else {
                                     out.println("<script>swal('Profile Successfully Updated!','','success')</script>");
                              }
                        
 %>
</body>
</html>
