<%-- 
    Document   : riderlogin
    Created on : Feb 8, 2021, 7:14:26 PM
    Author     : Tiaz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <!--icons-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lykmapipo/themify-icons@0.1.2/css/themify-icons.css">
    <link rel="stylesheet" href="../css/style.css">
<style>
     .mySlides {display:none;}
     
    .navbar {
    overflow: hidden;
  }

  .navbar a {
    float: left;
    font-size: 16px;
    color: white;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
  }

  .dropdown {
    float: left;
    overflow: hidden;
  }

  .dropdown .dropbtn {
    font-size: 16px;  
    border: none;
    outline: none;
    color: white;
    padding: 14px 16px;
    background-color: inherit;
    font-family: inherit;
    margin: 0;
  }

  .navbar a:hover, .dropdown:hover .dropbtn {
    color: #E0C180;
  }

  .dropdown-content {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 100px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
  }

  .dropdown-content a {
    float: none;
    color: black;
    padding: 12px 16px;
    font-size: 14px;
    text-decoration: none;
    display: block;
    text-align: left;
  }
  .dropdown:hover .dropdown-content {
    display: block;
  }
    </style>
</head>

<body>

    <div class="main-content">
        <header>
            <div class="website-name">
                <h5>
                    <span>FiftySix Kitchen</span>
                </h5>
            </div>
            <div class="navbar">
<!--                <a href="#home">Menu</a>-->
                <div class="dropdown">
                  <button class="dropbtn">Login 
                    <i class="fa fa-caret-down" style="padding-left:20px;"></i>
                  </button>
                  <div class="dropdown-content">
                    <a href="../a-customer/login.jsp">Customer</a>
                    <a href="#">Rider</a>
                    <a href="../a-admin/adminlogin.jsp">Admin</a>
                  </div>
                </div> 
              </div>
        </header>
       
            <div class="login-box">
                <img src="../image/login.jpg">
                
                <div class="borang-header">
                    FiftySix Kitchen
                   
                   
                    <div class="sub">
                        Rider login
                    </div>
                    <form action="RiderLoginServlet" method="post">
                    <div class="borang-content">
                        Email:
                        <div>
                            <input type="email" id="rider_email" name="rider_email" required>
                        </div><br>
                        Password:
                        <div>
                            <input type="password" id="rider_password"  name="rider_password" required><br>
                        </div><br>
                        
 
                        <button class="button btn1" onClick="return validate()">Login</button>
                     
                    </div>
                </form>
                </div>
            </div>
        
    </div>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script type="text/javascript"> 
       
    function validate(){
        
        var emailletters=/^([a-z 0-9\.-]+)@([a-z0-9-]+).([a-z]{2,8})(.[a-z]{2,8})?$/;
        
        if(document.getElementById('rider_email').value == ""){
                swal('Please Enter Your Email Address');
                return false;
            }
        
        else if(!document.getElementById('rider_email').value.match(emailletters)){
                swal('Email address format are invalid')
                return false;
            }  
        
        if(document.getElementById('rider_password').value == ""){
                swal('Please Enter Your Password');
                return false;
            }

    }
    
</script>

   <%
                              if(request.getAttribute("errMessage") == null) {
                                  out.println("");
                              }   
                              else {
                                    out.println("<script>swal('Please Try Again','Incorrect email address or password','warning')</script>");
                              }
                        
 %>

</body>
</html>