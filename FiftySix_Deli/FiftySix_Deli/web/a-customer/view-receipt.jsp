<%-- 
    Document   : signup
    Created on : 6 Feb 2021, 07:31:32 am
    Author     : Amirah Haziqah
--%>
<%@page import="henshin.model.paymentBean"%>
<%@page import="henshin.model.menuBean"%>
<%@page import="henshin.dao.menuDAO"%>
<%@page import="henshin.model.cartBean"%>
<%@page import="henshin.connection.ConnectionManager"%>
<%@page import="henshin.dao.cartDAO"%>
<%@page import="java.util.ListIterator"%>
<%@page import="java.util.List"%>
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

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FiftySix Kitchen | Payment</title>
    <!--icons-->
    <link rel="shortcut icon" href="image/logo-56.jpg">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lykmapipo/themify-icons@0.1.2/css/themify-icons.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css">
    <link rel="stylesheet" href="css/style_signup.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/receipt.css">
    
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
                <li><a href="a-customer/index.jsp">Home</a></li>
                <li><a href="/FiftySix_Deli/menuController?action=viewMenus">Menu</a></li>
                <li><a href="/FiftySix_Deli/orderCustController?action=viewPending&cust_id=<%= session.getAttribute("cust_id")%>">Orders</a></li>
                <li><a href="/FiftySix_Deli/customerController?action=viewProfile&email=<%= session.getAttribute("email")%>">My Profile</a></li>
                <li><a class="active" href="/FiftySix_Deli/cartController?action=viewCart&email=<%= session.getAttribute("email") %>&cust_id=<%= session.getAttribute("cust_id") %>"><i class="fa fa-shopping-cart"></i></a></li>
                <li><a href="a-customer/LogoutServlet"><i class="fas fa-sign-out-alt"></i></a></li>
            </ul>
        </header>
        <br><br><br><br><br>
     <% 
         double total = Double.parseDouble(request.getParameter("total")); 
         int cust_id = Integer.parseInt(request.getParameter("cust_id")); 
     %>
       
     <div class="main">

    <canvas id="confetti"></canvas>

           <div class="receipt">
               <p class="receipt__title">
                    FiftySix Kitchen
                </p> 
                <p class="receipt_end2">This is an electronic generated payment receipt</p>
                
            <dl class="receipt__list">
                
                      <c:forEach items="${pays}" var="pays">
                            <div class="receipt__list-row">
                              <dt class="receipt__item"><c:out value="${pays.menuName}"/></dt>
                              <dd class="receipt__cost">RM <c:out value="${pays.menuPrice}"/></dd>
                            </div>
                    
                </c:forEach>
              
              <div class="receipt__list-row receipt__list-row--total">
                <dt class="receipt__item">Total</dt>
                <dd class="receipt__cost">RM <%=total %></dd>
              </div>
              
                <br><br>
                <p class="receipt_end1">
                    <strong>Thank you for choosing us!</strong> <br>
                    Click here to be redirected to the order tracking page!
                </p> 
 
                    <div>
                        <a href="/FiftySix_Deli/orderCustController?action=viewPending&cust_id=<%= session.getAttribute("cust_id")%>"><button class="button btn2">OK</button></a>
                    </div>
                    <br><br>
            </dl>
          </div>

    <!--<div class="signup-box">
        <div class="borang-header">
            FiftySix Kitchen
            
                    <div class="borang-content">
                        <h2>Thank you for shopping with us!</h2>
                        <h2>Click here to be redirected to the order tracking page!</h2>
 
                        <div>
                            <a href="/FiftySix_Deli/orderCustController?action=viewPending&cust_id=<%--<%= session.getAttribute("cust_id")%>--%>"><button class="button btn1">OK</button></a>
                        </div>
                                     
                    </div>-->
    
    <script>
        let W = window.innerWidth;
let H = document.getElementById('confetti').clientHeight;
const canvas = document.getElementById('confetti');
const context = canvas.getContext("2d");
const maxConfettis = 25;
const particles = [];

const possibleColors = [
  "#ff7336",
  "#f9e038",
  "#02cca4",
  "#383082",
  "#fed3f5",
  "#b1245a",
  "#f2733f"
];

function randomFromTo(from, to) {
  return Math.floor(Math.random() * (to - from + 1) + from);
}

function confettiParticle() {
  this.x = Math.random() * W; // x
  this.y = Math.random() * H - H; // y
  this.r = randomFromTo(11, 33); // radius
  this.d = Math.random() * maxConfettis + 11;
  this.color =
    possibleColors[Math.floor(Math.random() * possibleColors.length)];
  this.tilt = Math.floor(Math.random() * 33) - 11;
  this.tiltAngleIncremental = Math.random() * 0.07 + 0.05;
  this.tiltAngle = 0;

  this.draw = function() {
    context.beginPath();
    context.lineWidth = this.r / 2;
    context.strokeStyle = this.color;
    context.moveTo(this.x + this.tilt + this.r / 3, this.y);
    context.lineTo(this.x + this.tilt, this.y + this.tilt + this.r / 5);
    return context.stroke();
  };
}

function Draw() {
  const results = [];

  // Magical recursive functional love
  requestAnimationFrame(Draw);

  context.clearRect(0, 0, W, window.innerHeight);

  for (var i = 0; i < maxConfettis; i++) {
    results.push(particles[i].draw());
  }

  let particle = {};
  let remainingFlakes = 0;
  for (var i = 0; i < maxConfettis; i++) {
    particle = particles[i];

    particle.tiltAngle += particle.tiltAngleIncremental;
    particle.y += (Math.cos(particle.d) + 3 + particle.r / 2) / 2;
    particle.tilt = Math.sin(particle.tiltAngle - i / 3) * 15;

    if (particle.y <= H) remainingFlakes++;

    // If a confetti has fluttered out of view,
    // bring it back to above the viewport and let if re-fall.
    if (particle.x > W + 30 || particle.x < -30 || particle.y > H) {
      particle.x = Math.random() * W;
      particle.y = -30;
      particle.tilt = Math.floor(Math.random() * 10) - 20;
    }
  }

  return results;
}

window.addEventListener(
  "resize",
  function() {
    W = window.innerWidth;
    H = window.innerHeight;
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
  },
  false
);

// Push new confetti objects to `particles[]`
for (var i = 0; i < maxConfettis; i++) {
  particles.push(new confettiParticle());
}

// Initialize
canvas.width = W;
canvas.height = H;
Draw();

    </script>
</body>
</html>