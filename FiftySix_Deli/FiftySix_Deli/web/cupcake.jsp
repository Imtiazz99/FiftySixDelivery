<%-- 
    Document   : cupcake
    Created on : 27 Dec 2020, 11:14:32 pm
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FiftySix | Menu</title>
        <link rel="shortcut icon" href="image/logo-56.jpg">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lykmapipo/themify-icons@0.1.2/css/themify-icons.css">
        <link rel="stylesheet" href="css/menu.css">
        
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
                <li><a href="index.jsp">Home</a></li>
                <li><a href="#" class="active">Menu</a></li>
                <li><a href="about-us.jsp">About Us</a></li>
                <li><a href="login.jsp" >Log in</a></li>
            </ul>

        </header>
        <main>
            <% String email = (String)session.getAttribute("currentSessionCustomer"); 
            out.print("Hello! Current user is "+email); 
        %>
            <div class="menu">
            <p>Menu</p>
            <hr>
            </div>
            <br>
            <div class="category" >
            <ul>
                <li><a href="menu.jsp" >Whole Cake</a></li>
                <li class="active"><a href= "#">Cup Cake</a></li>
                <li><a href="dessert.jsp">Dessert</a></li>
                <li><a href="cookies.jsp" >Cookies</a></li>
            </ul>
                
            </div>
            <div class="menus">
            <div class="single-menu">
                <img src="image/cupcake.JPG" alt="">
                <div class="menu-content">
                    <h4>Cupcake <span>RM55</span></h4>
                    <p>Chocolate cake topped with chocolate ganache, strawberries and pomegranate .</p><br>
                    <button class="button btn1">Add to cart</button>
                </div>
            </div>
            <div class="single-menu">
                <img src="image/cupcake1.JPG" alt="">
                <div class="menu-content">
                    <h4>Red Velvet Cupcake <span>RM65</span></h4>
                    <p>A great combination of chocolate and lemon that will shock whoever eat it, a really tasty cake.</p><br>
                    <button class="button btn1">Add to cart</button>
                </div>
            </div>
            <div class="single-menu">
                <img src="image/cupcake2.JPG" alt="">
                <div class="menu-content">
                    <h4>Pavlova Cupcake <span>RM60</span></h4>
                    <p>Pandan and Gula Melaka origin from Melaka with a delicious taste.</p><br>
                    <button class="button btn1">Add to cart</button>
                </div>
            </div>
            <div class="single-menu">
                <img src="image/cupcake3.JPG" alt="">
                <div class="menu-content">
                    <h4>Chocolate Cupcake <span>RM35</span></h4>
                    <p>with a bit of our own touch! —homemade strawberry compote.</p><br>
                    <button class="button btn1">Add to cart</button>
                </div>
            </div>
            
        </div>       
        </main>
    </div>
    </body>
</html>
