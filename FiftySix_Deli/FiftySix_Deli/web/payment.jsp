<%-- 
    Document   : signup
    Created on : 6 Feb 2021, 07:31:32 am
    Author     : Amirah Haziqah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FiftySix Kitchen | Payment</title>
    <!--icons-->
    <link rel="shortcut icon" href="image/logo-56.jpg">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lykmapipo/themify-icons@0.1.2/css/themify-icons.css">
    <link rel="stylesheet" href="css/style_signup.css">
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
                <li><a href="menu.jsp">Menu</a></li>
                <li><a href="about-us.jsp">About Us</a></li>
                <li><a href="login.jsp" class="active">Log in</a></li>
            </ul>
        </header>
       
            <div class="signup-box">
                <div class="borang-header">
                    FiftySix Kitchen
                   <form name="payment" action="paymentController" method="POST">
                    <div class="borang-content">
                        <h2>Billing Address</h2>
                        E-mail address: <input type="text" name="email"><br><br>
                        Address: <br><textarea id="address" name="address" rows="3" cols="30"></textarea><br><br>
                        City: <input type="text" name="city"><br><br>
                        Postcode:  <input type="text" name="postcode"><br><br>
                        
                        <h2>Payment</h2>
                        <input type="radio" id="credit" name="payment-method" value="credit">
                            <label for="credit">Credit Card</label><br>
                        <input type="radio" id="debit" name="payment-method" value="debit">
                            <label for="debit">Debit Card</label><br>
                        <input type="radio" id="paypal" name="payment-method" value="paypal">
                        <label for="paypal">Paypal</label><br><br>
                        Name on card:  <input type="text" name="postcode"><br><br>
                        Credit card number:  <input type="text" name="postcode"><br><br>
                        Expiry Date:  <input type="text" name="postcode"><br><br>
                        CVV:  <input type="text" name="postcode"><br><br>
                        
                        <button class="button btn1">Confirm and Proceed</button>
                    </div>
                   </form>
                </div>
            </div>
        
    </div>
</body>
</html>