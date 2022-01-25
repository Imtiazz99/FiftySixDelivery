<%@page import="java.sql.*"%>
<%@page import="henshin.model.AdminLoginBean"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <link rel="stylesheet" href= "../css/addons/datatables.min.css">
    <link rel="stylesheet" href= "../css/bootstrap.min.css">
    <link rel="stylesheet" href= "../css/dashboard.css">
    <link rel="stylesheet" href= "../css/mdb.min.css">
    <style>
        table {
    counter-reset: tableCount;   
    font-family: arial, sans-serif; 
    border-collapse: separate; 
    width: 50%;
}
.counterCell:before {              
    content: counter(tableCount); 
    counter-increment: tableCount; 
}
          
td {
    border: 1px solid #dddddd; 
    text-align: center; 
    padding: 8px; 
    background-color: #d6e9ff;
}

th { 
    border: 1px solid #dddddd; 
    text-align: center; 
    padding: 8px; 
    background-color: #718eb0;
    color: #fff;
} 

h1 {
  color: #b0935f;
  font-size: 4em;
  margin-bottom: 5%;
  text-align: center;
  padding-top: 1px;
}
    </style>
    
</head>

<body>  
    <div class="sidebar">
        <div class="sidebar-user">
            <img src="../image/fox.png">
            <div class="user-image">
                 <p>Admin :<%=session.getAttribute("admin_email")%></p>
            </div>
        </div>
        <div class="sidebar-menu">
            <hr>
             <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="/FiftySix_Deli/menuController?action=listMenu">Manage Menu</a></li>
                <li>
                    <a href="#" class="feat-btn">Manage User
                        <span class="fas fa-caret-down"></span>
                    </a>
                </li>
                <ul class="feat-show">
                    <li><a href="adminController?action=viewAdmins">Admin</a></li>
                    <li><a href="riderController?action=viewRiders">Rider</a></li>
                    <li><a href="/FiftySix_Deli/customerController?action=viewCustomers">Customer</a></li>
                </ul>
                <li><a href="/FiftySix_Deli/assignRiderController?action=viewOrders">Manage Order</a></li>
                <li class="active"><a href="report.jsp">Report</a></li>
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
            
            <div class="heading">
                <h1>Report Sections</h1>
            </div>
              
          <%
            try {
                String connectionURL = "jdbc:oracle:thin:@localhost:1521:xe";
                Connection connection = null;
                Statement statement = null;
                ResultSet rs = null;
                Class.forName("oracle.jdbc.driver.OracleDriver");
                connection = DriverManager.getConnection(connectionURL, "henshin", "system");
                statement = connection.createStatement();
                String QueryString = "select TO_CHAR(ORDER_TIME,'DD-MM-YYYY'), SUM(TOTAL_PAYMENT), SUM(DELIVERY_CHARGE), SUM(QUANTITY), MIN(TOTAL_PAYMENT), MAX(TOTAL_PAYMENT), ROUND(AVG(TOTAL_PAYMENT),0) from orders join payment using (order_id) join order_details using (order_id) join menu using (menu_id) join menu_category using (category_id) GROUP BY TO_CHAR(ORDER_TIME,'DD-MM-YYYY')";
                rs = statement.executeQuery(QueryString);
           %>
            
        <b>Filter the table for Date, Time and Payment :  
            <input id="gfg" type="text" placeholder="Filter here..."> 
        </b> 
        <br> 
        <br>
        <table>
            <tr>
                    <th>NUMBER</th>
                    <th>ORDER DATE</th>
                    <th>TOTAL DAILY PAYMENT</th>
                    <th>TOTAL DELIVERY CHARGE</th>
                    <th>TOTAL QUANTITY ORDER</th>
                    <th>MINIMUM DAILY PAYMENT</th>
                    <th>MAXIMUM DAILY PAYMENT</th>
                    <th>PAYMENT AVERAGE ROUND-OFF</th>
            </tr>   
            <%
                while (rs.next()) {
            %>
            <tbody id="geeks"> 
                <tr>
                    <td class="counterCell"></td>
                    <td><%=rs.getString(1)%></td>
                    <td><%=rs.getInt(2)%></td>
                    <td><%=rs.getInt(3)%></td>
                    <td><%=rs.getInt(4)%></td>
                    <td><%=rs.getInt(5)%></td>
                    <td><%=rs.getInt(6)%></td>
                    <td><%=rs.getInt(7)%></td>
                </tr>
            </tbody> 
            <% } %>
            <%
                rs.close();
                statement.close();
                connection.close();
                } catch (Exception ex) {
            %>
            </font>
                <font size="+3" color="red"></b>
            <%
                out.println("Unable to connect to database.");
                }
            %>
        </table>
        </main>
        </div>
    <script type="text/javascript" src="js/table.js"></script>
  <script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
  <!-- Bootstrap tooltips -->
  <script type="text/javascript" src="js/popper.min.js"></script>
  <!-- Bootstrap core JavaScript -->
  <script type="text/javascript" src="js/bootstrap.min.js"></script>
  <!-- MDB core JavaScript -->
  <script type="text/javascript" src="js/mdb.min.js"></script>
  <script type="text/javascript" src="js/addons/datatables.min.js"></script>
  <!-- filter -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> 
<script> 
        $(document).ready(function() { 
                $("#gfg").on("keyup", function() { 
                    var value = $(this).val().toLowerCase(); 
                    $("#geeks tr").filter(function() { 
                        $(this).toggle($(this).text() 
                        .toLowerCase().indexOf(value) > -1); 
                    }); 
                }); 
            }); 
</script> 
</body>
</html>
