<%-- 
    Document   : index
    Created on : Feb 7, 2021, 10:38:20 PM
    Author     : Aina Syazana 
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lykmapipo/themify-icons@0.1.2/css/themify-icons.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
    <link rel="stylesheet" href="css/addons/datatables.min.css">
    <link rel="stylesheet" href="css/profile.css">    
    <link rel="stylesheet" href="css/dashboard.css">
    <link rel="stylesheet" href="css/mdb.min.css">
    
   
</head>

<body>  
    <% String emel = "test@gmail.com";
    %>
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
                <li><a href="a-rider/index.jsp">Home</a></li>
                <li class="active"><a href="/FiftySix_Deli/riderController?action=viewProfile&email=<%= session.getAttribute("rider_email")%>">My Profile</a></li>

                <li>
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
            <div class="profile-container">
                <h4>Profile</h4>
                <div class="profile-form">
                    <form name="riderprofile" method="post" action="riderController?action=updateProfile&user=<%= emel %>" onsubmit="return validate()">
                    <table>
                        <tr>
                            <td>
                                <label>Full name</label>
                                <input type="text" name="riderName" id="riderName" maxlength="40" value="<c:out value="${riders.riderName}"/>">
                            </td>
                            <td>
                                <label>Vehicle registration number</label>
                                <input type="text" name="plateNo" id="plateNo"  onkeyup="numbersLettersOnly(this)" maxlength="7" value="<c:out value="${riders.plateNo}"/>">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                 <label>E-mail address</label>
                                 <input type="text" name="email" id="email" maxlength="40" value="<c:out value="${riders.email}"/>">
                            </td>
                            <td>
                                 <label>Status</label>
                                 <select id="status" name="status" >
                                    <option><c:out value="${riders.status}"/></option>
                                    <option value="Active">Active</option>
                                    <option value="Inactive">Inactive</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td> 
                                <label>Contact number</label>
                                <input type="text" name="riderPhone" id="riderPhone" maxlength="10" value="<c:out value="${riders.riderPhone}"/>">
                                <input type="hidden" value="<c:out value="${riders.riderID}"/>" name="riderID">
                            </td>
                            
                            <td> 
                                <label>Password</label>
                                <input type="password" name="password" id="password" maxlength="20" value="<c:out value="${riders.password}"/>">

                            </td>
                        </tr>
                    </table>
                        <input type="submit" value="Update" name="update" onclick="return confirm('Are you sure you want to update this?')">
                    </form>
                </div>
            </div>
            
        </div>
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
  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

 
    <script type="text/javascript"> 
    function validate(){
            var riderPass=document.riderprofile.password.value;
            var riderPhone=document.riderprofile.riderPhone.value;
            var letters=/^[a-zA-Z ]*$/;
            var emailletters=/^([a-z 0-9\.-]+)@([a-z0-9-]+).([a-z]{2,8})(.[a-z]{2,8})?$/;     
            var number=/^[0-9]*$/;
            var illegalChar=/[\W_]/;
            
            if(document.getElementById('riderName').value == ""){
                swal('Name cannot be blank');
                return false;
            }
            
            if(!document.getElementById('riderName').value.match(letters)){
                swal("Name must contain only alphabets","E.g John Doe")
                return false;
            }     
            
            if(document.getElementById('plateNo').value == ""){
                swal('Vehicle Registration Number cannot be blank');
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
            
            if(document.getElementById('riderPhone').value == ""){
                swal('Contact Number cannot be blank');
                return false;
            }
            
            if(!document.getElementById('riderPhone').value.match(number)){
                swal("Contact number must contain only numbers","E.g 0123456789");
              return false;
            }
            
             if(riderPhone.length<10){
              swal("Invalid Contact Number Format","Contact number should be 10 number E.g 0123456789");
              return false;
          }  
          
           if(document.getElementById('password').value == ""){
                swal('Password cannot be blank');
                return false;
            }
          
            else if((riderPass.length<7 || (riderPass.length>15))){
                swal("Password should be between 7 and 15 characters");
                document.riderprofile.password.focus();
                return false;
            } 
            
            else if(illegalChar.test(riderPass)){
                swal("Password cannot be special character (#, /, %, $, +) ");
                document.riderprofile.password.focus();
                return false; 
            }
            
              return true;
            }
         
    
     
        function numbersOnly(input){
            var regex = /[^0-9]/g;
            input.value = input.value.replace(regex,"");    
        }
        
          function numbersLettersOnly(input){
            var regex = /[^a-z A-Z 0-9]/g;
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
</body>
</html>
