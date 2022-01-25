<%-- 
    Document   : index
    Created on : 7 Feb 2021, 01:42:32 am
    Author     : Aina Syazana
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    <title>FiftySix | Home</title>
    <!--icons-->
    <link rel="shortcut icon" href="image/logo-56.jpg">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lykmapipo/themify-icons@0.1.2/css/themify-icons.css">
    <link rel="stylesheet" href="../css/style.css">
    <style>
     .mySlides {display:none;}
    </style>
</head>

<body>
        <% String email = (String)session.getAttribute("currentSessionCustomer"); 
            out.print("Hello! Current user is "+email); 
        %>
        <!--input type="hidden" name="custID" value="41"-->
        
    <div class="main-content">
        <header>
            <div class="website-name">
                <h5>
                    <span>FiftySix Kitchen</span>
                </h5>
            </div>
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="menu.jsp">Menu</a></li>
                <li><a href="#"  class="active">Order</a></li>
                <li><a href="/FiftySix_Deli/customerController?action=viewProfile&email=<%= email%>"/>My Profile</a></li>
               <li><a href="a-customer/LogoutServlet"><i class="fas fa-sign-out-alt"></i></a></li>
            </ul>
        </header>
        <main>
            
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