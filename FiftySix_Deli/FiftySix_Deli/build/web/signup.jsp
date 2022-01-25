<%-- 
    Document   : signup
    Created on : 27 Dec 2020, 12:06:32 am
    Author     : Aina Syazana
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <!--icons-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lykmapipo/themify-icons@0.1.2/css/themify-icons.css">
    <link rel="stylesheet" href="css/style_signup.css">
    <style>
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
                    <a href="a-customer/login.jsp">Customer</a>
                    <a href="a-rider/riderlogin.jsp">Rider</a>
                    <a href="a-admin/adminlogin.jsp">Admin</a>
                  </div>
                </div> 
              </div>

        </header>
       
            <div class="signup-box">
                
                <div class="borang-header">
                    FiftySix Kitchen
                   <form name="signup" id="signup" action="customerRegisterServlet?action=addCust" method="POST">
                    <div class="borang-content">
                        Full name:
                        <div class="formgap">
                            <input type="text" id="name" name="custName" placeholder="E.g John Doe" maxlength="40" onkeyup="lettersOnly(this)"><br>
                        </div>
                        E-mail address:
                        <div class="formgap">
                            <input type="email" id="email" placeholder="E.g Johndoe@gmail.com" maxlength="40" name="email"><br>
                        </div>
                        
                        Phone number:
                        <div class="formgap"> 
                           <input type="text" id="phone" placeholder="E.g 0123456789" maxlength="10" name="phoneNo" onkeyup="numbersOnly(this)"><br>
                        </div>
                        
                        Password:
                        <div class="formgap">
                            <input type="password" name="password" maxlength="20" required><br>
                        </div>
                        
                        Confirm Password:
                        <div class="formgap">
                            <input type="password" name="confirmPassword" maxlength="20" required><br>
                        </div><br>
                        
                        
      
                        <p>Already have an account? <a href="a-customer/login.jsp">Log in</a></p>
                        
                        <button name ="button"class="button btn1" onClick="return validate();">Sign up</button>
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
            var confirmPassword=document.signup.confirmPassword.value;
            var password=document.signup.password.value;
            var phoneNo=document.signup.phoneNo.value;
            var illegalChar=/[\W_]/;
            var letters=/^[a-zA-Z ]*$/;
            var emailletters=/^([A-Z a-z 0-9\.-]+)@([a-z0-9-]+).([a-z]{2,8})(.[a-z]{2,8})?$/;
            
            if(document.getElementById('name').value == ""){
                swal('Please Enter Your Full Name');
                return false;
            }
            
            else if(!document.getElementById('name').value.match(letters)){
                swal("Name must contain only alphabets","E.g John Doe")
                return false;
            }
            
            if(document.getElementById('email').value == ""){
                swal('Please Enter Your Email Address');
                return false;
            }
            
            else if(!document.getElementById('email').value.match(emailletters)){
                swal("Email address format are invalid","E.g Johndoe@gmail.com")
                return false;
            }
            
          if(document.getElementById('phone').value == ""){
                swal('Please Enter Your Phone Number'); 
                return false;
            }
          else if (phoneNo.length<10){
              swal("Invalid Phone Number Format", "Phone number should be 10 number");
              return false;
          }  
            
            if((password.length<7 || (password.length>15))){
                swal("Password should be between 7 and 15 characters");
                document.signup.password.focus();
                return false;
            } 
            else if(password != confirmPassword){
                swal("Password Does Not Match");
                return false;
            }
            else if(illegalChar.test(password)){
                swal("Password cannot be special character (#, /, %, $, +) ");
                document.signup.password.focus();
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
                              if(request.getAttribute("error") == null) {
                                  out.println("");
                              }   
                              else {
                                    out.println("<script>swal('Email Already Exists','Please Login','info')</script>");
                              }
                        
 %>
</body>
</html>