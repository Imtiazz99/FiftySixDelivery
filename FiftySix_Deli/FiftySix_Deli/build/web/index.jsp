<%-- 
    Document   : index
    Created on : 7 Feb 2021, 01:42:32 am
    Author     : Amirah Haziqah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FiftySix | Home</title>
    <!--icons-->
    <link rel="shortcut icon" href="image/logo-56.jpg">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lykmapipo/themify-icons@0.1.2/css/themify-icons.css">
    <link rel="stylesheet" href="css/style.css">
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
                <a href="#home">Menu</a>
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
        <main>
            <marquee width="80%" direction="left" height="70px">
                WELCOME TO FIFTYSIX KITCHEN!
            </marquee>
                <div style="width:450px; margin:auto;">
                    <img class="mySlides" src="image/home1.PNG" style="width:100%">
                    <img class="mySlides" src="image/home2.PNG" style="width:100%">
                    <img class="mySlides" src="image/home3.PNG" style="width:100%">
                    <img class="mySlides" src="image/home4.PNG" style="width:100%">
                    <img class="mySlides" src="image/home5.PNG" style="width:100%">
                 </div>
        </main>
    </div>
    <script>
      var myIndex = 0;
      carousel(); 
      function carousel() {
        var i;
        var x = document.getElementsByClassName("mySlides");
        for (i = 0; i < x.length; i++) {
          x[i].style.display = "none";
        }
        myIndex++;
        if (myIndex > x.length) {myIndex = 1}
        x[myIndex-1].style.display = "block";
        setTimeout(carousel, 2000); // Change image every 2 seconds
      }
    </script>
</body>
</html>