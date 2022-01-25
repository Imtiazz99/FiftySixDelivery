
<%@page import="henshin.model.AdminLoginBean"%>
<% 
    response.setHeader("Cache-Control","no-cache, no-store,must-revalidate");  
    response.setHeader("Pragma","no-cache"); 
    response.setHeader("Expires","0");
    
    AdminLoginBean rider = (AdminLoginBean) session.getAttribute("logAdmin");
    if(rider==null){
        response.sendRedirect("adminlogin.jsp");
    }
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lykmapipo/themify-icons@0.1.2/css/themify-icons.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
    <link rel="stylesheet" href="../css/addons/datatables.min.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/dashboard.css">
    <link rel="stylesheet" href="../css/mdb.min.css">
    
   
</head>

<body>  
    <div class="sidebar">
        <div class="sidebar-user">
            <img src="../image/fox.png">
            <div class="user-image">
                   <p>Admin :<%=session.getAttribute("admin_email")%> </p>
            </div>
        </div>
        <div class="sidebar-menu">
            <hr>
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="/FiftySix_Deli/menuController?action=listMenu">Manage Menu</a></li>
                <li class="active">
                    <a href="#" class="feat-btn">Manage User
                        <span class="fas fa-caret-down"></span>
                    </a>
                </li>
                <ul class="feat-show">
                    <li><a href="adminController?action=viewAdmins">Admin</a></li>
                    <li><a href="riderController?action=viewRiders">Rider</a></li>
                    <li><a href="../customerController?action=viewCustomers">Customer</a></li>
                </ul>
                <li><a href="/FiftySix_Deli/assignRiderController?action=viewOrders">Manage Order</a></li>
                <li><a href="report.jsp">Report</a></li>
                <li><a href="AdminLogoutServlet">Logout</a></li>
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
 
            <center><br><br>
            <div class="register-container">
            <div class="heading">
                <h4>Admin Registration</h4>
            </div>
            </div>
                 <div class="register-containers">
                       <div class="signup-box">
                <table>
                    <form name="addadmin" action="adminController" method="POST">
                    <tr>
                        <td style="padding:10px;">Admin Name</td> 
                        <td style="padding:10px;">Email</td>
                    </tr>
                    <tr>
                        <td style="padding:10px;"><input type="text" placeholder="E.g John Doe" id="adminName" name="adminName" maxlength="40"></td>
                        <td style="padding:10px;"><input type="email" placeholder="E.g Johndoe@gmail.com" id="email" name="email" maxlength="40"></td>
                    </tr>
                    <tr>
                        <td style="padding:10px;">Phone No</td>
                        <td style="padding:10px;">Password</td>
                    </tr>
                    <tr>
                        <td style="padding:10px;"><input type="text" name="phoneNo" id="phoneNo" placeholder="E.g 0123456789" maxlength="10" onkeyup="numbersOnly(this)"></td>
                        <td style="padding:10px;"><input type="password" name="password" id="password" maxlength="20"></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td style="padding:10px;">
                           <button class="button btn2" onClick="return validate()">Insert Data</button>
                           <button class="button btn3" type="reset">Clear Data</button>
                        </td>
                    </tr>
                    
                    </form>
                </table>
            </div>
            </div>
                </div>
        </main>
        </div>
    
    <script type="text/javascript" src="../js/table.js"></script>
  <script type="text/javascript" src="../js/jquery-3.4.1.min.js"></script>
  <!-- Bootstrap tooltips -->
  <script type="text/javascript" src="../js/popper.min.js"></script>
  <!-- Bootstrap core JavaScript -->
  <script type="text/javascript" src="../js/bootstrap.min.js"></script>
  <!-- MDB core JavaScript -->
  <script type="text/javascript" src="../js/mdb.min.js"></script>
  <script type="text/javascript" src="../js/addons/datatables.min.js"></script>
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
    </script> 
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript"> 
    function validate(){
            var password=document.addadmin.password.value;
            var phoneNo=document.addadmin.phoneNo.value;
            var illegalChar=/[\W_]/;
            var letters=/^[a-zA-Z ]*$/;
            var emailletters=/^([A-Z a-z 0-9\.-]+)@([a-z0-9-]+).([a-z]{2,8})(.[a-z]{2,8})?$/;        
            
            if(document.getElementById('adminName').value == ""){
                swal('Please Enter Admin Name');
                return false;
            }
            
            else if(!document.getElementById('adminName').value.match(letters)){
                swal("Name must contain only alphabets","E.g John Doe")
                return false;
            }     
            
            if(document.getElementById('email').value == ""){
                swal('Please Enter Admin Email Address');
                return false;
            }
            
            else if(!document.getElementById('email').value.match(emailletters)){
                swal("Email address format are invalid","E.g Johndoe@gmail.com")
                return false;
            }
            if(document.getElementById('phoneNo').value == ""){
                swal('Please Enter Admin Phone Number'); 
                return false;
            }     
            
          else if (phoneNo.length<10){
              swal("Invalid Phone Number Format", "Phone number should be 10 number");
              return false;
          }  
          
            if(document.getElementById('password').value == ""){
                swal('Please Enter Admin Password');
                return false;
            }
            
           else if((password.length<7 || (password.length>15))){
                swal("Password should be between 7 and 15 characters");
                document.addadmin.password.focus();
                return false;
            } 
            
            else if(illegalChar.test(password)){
                swal("Password cannot be special character (#, /, %, $, +) ");
                document.addadmin.password.focus();
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
                              if(request.getAttribute("errora") == null) {
                                  out.println("");
                              }   
                              else {
                                    out.println("<script>swal('Admin Email Already Exists','','info')</script>");
                              }
                        
 %>
 <%
                              if(request.getAttribute("successa") == null) {
                                  out.println("");
                              }   
                              else {
                                     out.println("<script>swal('Admin Successfully Registered!','','success')</script>");
                              }
                        
 %>
</body>
</html>
