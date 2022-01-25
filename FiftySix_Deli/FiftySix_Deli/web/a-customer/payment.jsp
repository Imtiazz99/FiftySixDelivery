<%-- 
    Document   : signup
    Created on : 6 Feb 2021, 07:31:32 am
    Author     : Amirah Haziqah
--%>
<%@page import="henshin.model.menuBean"%>
<%@page import="henshin.model.paymentBean"%>
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
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
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
    <link rel="stylesheet" href="css/profile.css">
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
                <li><a href="/FiftySix_Deli/menuController?action=viewMenu">Menu</a></li>
                <li><a href="/FiftySix_Deli/orderCustController?action=viewPending&cust_id=<%= session.getAttribute("cust_id")%>">Orders</a></li>
                <li><a href="/FiftySix_Deli/customerController?action=viewProfile&email=<%= session.getAttribute("email")%>">My Profile</a></li>
                <li><a class="active" href="/FiftySix_Deli/cartController?action=viewCart&email=<%= session.getAttribute("email") %>&cust_id=<%= session.getAttribute("cust_id") %>"><i class="fa fa-shopping-cart"></i></a></li>
                 <li><a href="a-customer/LogoutServlet"><i class="fas fa-sign-out-alt"></i></a></li>
            </ul>
        </header>
        
     <% 
        double total = Double.parseDouble(request.getParameter("total"));
        int cust_id = Integer.parseInt(request.getParameter("cust_id")); 
        double delivery = 7.00;
     %>
       
     <main>
        <div class="profile-container" >
            <h2>Billing Address</h2>
            <p>Please select your billing address</p><br>
            <hr>
                <div class="profile-form">
                   <form method="post" action="paymentController?action=createPayment&order_id=<%= session.getAttribute("order_id") %>&total=<%=total %>">
                   <input type="hidden" name="cust_id" value="<%=cust_id %>">
                   
                   
                  <c:forEach items="${pays}" var="pays">                    
                          <table style="padding: 15px;">
                        <tr>
                            <td>
                                <c:out value="${pays.custName}" />
                            </td>  
                            <td>
                            </td> 
                        </tr>
                        <tr>
                            <td>
                                 <label>+6<c:out value="${pays.phoneNo}" /></label>                       
                            </td>
                            <td>
                            </td> 
                        </tr>
                        <tr>
                            <td>
                                <c:out value="${pays.address_line}" />, 
                                <c:out value="${pays.postcode}" />, 
                                <c:out value="${pays.city}" />, 
                                <c:out value="${pays.state}" />
                            </td>
                            <td>
                                <input  type="radio" name="addressID" value="<c:out value="${pays.addressID}" />" style="width: 16px;" checked>
                            </td>
                        </tr>
                    </table>
                  </c:forEach>
                    <br>
                
                    <h2>Payment Details</h2><br>    
                            <table>
                                <tr>
                                    <td>
                                        <label>Delivery Charge: RM</label>
                                        <input readonly type="text" id="delivery" name="delivery" value="<%= delivery %>">
                                    </td>
                                    <td>
                                         <label>Amount to be paid: RM</label>
                                         <input readonly type="text" id="total" name="total" value="<%= total %>">
                                    </td>                     
                                </tr>
                                <tr>
                                    <td>
                                        <label>Choose your payment method:</label>
                                        <select id="select_level" name="method_id" onchange="categorySelectHandler(this)">
                                            <option value="2">Cash on Delivery</option>
                                            <option value="3">Online Banking</option>
                                        </select>
                                    </td>
                                </tr>
                            </table>
                            <input type="submit" value="Confirm">
                            
                    </form>
                                    
                            <div id="level1_category"  style="display:none;">
                                <div id="smart-button-container">
                                    <div style="text-align: center;">
                                        <div id="paypal-button-container"></div>
                                    </div>
                                </div>
                            </div>

                            <div id="level2_category"  style="display:none;">
                                <div id="smart-button-container">
                                    <div style="text-align: center;">
                                        <div id="paypal-button-container"></div>
                                    </div>
                                </div>
                            </div>
                </div>
            </div>
        </main>
                                    
<!--    <script>
        location.replace("a-customer/index.jsp");
        document.getElementById("demo").innerHTML = alert("You have not yet added any address. Please go to My Profile > My Address > Add Address");   
    </script>-->
    <script type="text/javascript">
    function showlevel1() {
        var l1 = document.getElementById('level1_category');
        l1.style.display = 'block';
        var l2 = document.getElementById('level2_category');
        l2.style.display = 'none';
    }

    function showlevel2() {
        var l2 = document.getElementById('level2_category');
        l2.style.display = 'block';
        var l1 = document.getElementById('level1_category');
        l1.style.display = 'none';

    }
    function categorySelectHandler(select) {

        if (select.value == '1') {

            var l1 = document.getElementById('level1_category');
            l1.style.display = 'none';
            var l2 = document.getElementById('level2_category');
            l2.style.display = 'none';

        } else if (select.value == '2') {
            showlevel2();
        } else if (select.value == '3') {
            showlevel1();
        }
        

    }
</script>
             
  <script src="https://www.paypal.com/sdk/js?client-id=AYbFw8j14-Sr-DGYm5kDr_mbYEXJLF4aj4nTt3xmBcR37qxxduF5n9NsPIP4-P9SIpzv3auadOyTZF7Z&currency=USD" data-sdk-integration-source="button-factory"></script>
  
  <script>
    function initPayPalButton() {
      var x = document.getElementById('total').value;    

      paypal.Buttons({
        style: {
          shape: 'rect',
          color: 'gold',
          layout: 'vertical',
          label: 'paypal',
          
        },

        createOrder: function(data, actions) {
          return actions.order.create({
            purchase_units: [{"amount":{"currency_code":"USD","value":x}}]
          });
        },

        onApprove: function(data, actions) {
          return actions.order.capture().then(function(details) {
            alert('Transaction completed by ' + details.payer.name.given_name + '!');
          });
        },

        onError: function(err) {
          console.log(err);
        }
      }).render('#paypal-button-container');
    }
    initPayPalButton();
  
  </script>               
                        
                        
</div>
</body>
</html>