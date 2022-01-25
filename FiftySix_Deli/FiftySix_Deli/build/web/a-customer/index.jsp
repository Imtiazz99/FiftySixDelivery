<%-- 
    Document   : index
    Created on : 31 May 2021, 01:42:32 am
    Author     : Amirah Haziqah
--%>
<%@page import="henshin.model.LoginBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    response.setHeader("Cache-Control","no-cache, no-store,must-revalidate");  
    response.setHeader("Pragma","no-cache"); 
    response.setHeader("Expires","0");
    
    LoginBean rider = (LoginBean) session.getAttribute("logUser");
    if(rider==null){
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FiftySix | Home</title>
    <!--icons-->
    <link rel="shortcut icon" href="../image/logo-56.jpg">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lykmapipo/themify-icons@0.1.2/css/themify-icons.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css">
    <link rel="stylesheet" href="../css/style.css">
    <style>
     .mySlides {display:none;}
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
            <ul>
                <li><a href="#" class="active">Home</a></li>
                <li><a href="/FiftySix_Deli/menuController?action=viewMenus">Menu</a></li>
                <li><a href="/FiftySix_Deli/orderCustController?action=viewPending&cust_id=<%= session.getAttribute("cust_id")%>">Orders</a></li>
                <li><a href="/FiftySix_Deli/customerController?action=viewProfile&email=<%= session.getAttribute("email")%>">My Profile</a></li>
                <li><a href="/FiftySix_Deli/cartController?action=viewCart&email=<%= session.getAttribute("email") %>&cust_id=<%= session.getAttribute("cust_id") %>"><i class="fa fa-shopping-cart"></i></a></li>
                <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i></a></li>
            </ul>
        </header>
        <main>
            <marquee width="80%" direction="left" height="70px">
                WELCOME TO FIFTYSIX KITCHEN!
            </marquee>
                <div style="width:450px; margin:auto;">
                    <img class="mySlides" src="../image/home1.PNG" style="width:100%">
                    <img class="mySlides" src="../image/home2.PNG" style="width:100%">
                    <img class="mySlides" src="../image/home3.PNG" style="width:100%">
                    <img class="mySlides" src="../image/home4.PNG" style="width:100%">
                    <img class="mySlides" src="../image/home5.PNG" style="width:100%">
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