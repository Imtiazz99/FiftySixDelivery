<%@page import="henshin.model.AdminLoginBean"%>
<%@page import="java.sql.*"%>
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
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
    <link rel="stylesheet" href="../css/addons/datatables.min.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/dashboard.css">
    <link rel="stylesheet" href="../css/mdb.min.css">
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" />
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" />
    
   <style type="text/css">
    body,
    html {
      height: 100%;
    }
    /* workaround modal-open padding issue */
    
    body.modal-open {
      padding-right: 0 !important;
    }
    
    #sidebar {
      padding-left: 0;
    }
    /*
 * Off Canvas at medium breakpoint
 * --------------------------------------------------
 */
    
    @media screen and (max-width: 48em) {
      .row-offcanvas {
        position: relative;
        -webkit-transition: all 0.25s ease-out;
        -moz-transition: all 0.25s ease-out;
        transition: all 0.25s ease-out;
      }
      .row-offcanvas-left .sidebar-offcanvas {
        left: -33%;
      }
      .row-offcanvas-left.active {
        left: 33%;
        margin-left: -6px;
      }
      .sidebar-offcanvas {
        position: absolute;
        top: 0;
        width: 33%;
        height: 100%;
      }
    }
    /*
 * Off Canvas wider at sm breakpoint
 * --------------------------------------------------
 */
    
    @media screen and (max-width: 34em) {
      .row-offcanvas-left .sidebar-offcanvas {
        left: -45%;
      }
      .row-offcanvas-left.active {
        left: 45%;
        margin-left: -6px;
      }
      .sidebar-offcanvas {
        width: 45%;
      }
    }
    
    .card {
      overflow: hidden;
    }
    
    .card-block .rotate {
      z-index: 8;
      float: right;
      height: 100%;
    }
    
    .card-block .rotate i {
      color: rgba(20, 20, 20, 0.15);
      position: absolute;
      left: 0;
      left: auto;
      right: -10px;
      bottom: 0;
      display: block;
      -webkit-transform: rotate(-44deg);
      -moz-transform: rotate(-44deg);
      -o-transform: rotate(-44deg);
      -ms-transform: rotate(-44deg);
      transform: rotate(-44deg);
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
                <li class="active"><a href="index.jsp">Home</a></li>
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
                <li><a href="report.jsp">Report</a></li>
                <li><a href="AdminLogoutServlet">Logout</a></li>
            </ul>
        </div>
    </div>
     <main>
    <div class="main-content">
        <header>
            <div class="website-name" style="margin-top: 18px;">
              <h5>
                <span>FiftySix Kitchen</span>
              </h5>
            </div>
        </header>  
        
            <%
                String connectionURL = "jdbc:oracle:thin:@localhost:1521:xe";
                Connection connection = null;
                Statement statement = null;
                ResultSet rs = null;
                Class.forName("oracle.jdbc.driver.OracleDriver");
                connection = DriverManager.getConnection(connectionURL, "henshin", "system");
                statement = connection.createStatement();
                String QueryString = "SELECT (select COUNT(ADMINS.admin_id) from ADMINS)  AS ADMINS, (select COUNT(RIDER.rider_id) from RIDER) AS RIDERS, (select COUNT(order_id)from orders where status_id = 2 OR status_id = 3 OR status_id = 1)  AS ONGOING, (select COUNT(order_id) FROM orders where status_id is null) AS PENDING FROM DUAL";
                rs = statement.executeQuery(QueryString);

           %>
        
           <%
                while (rs.next()) {
            %>
       <div class="row mb-3 mt-5 pt-3">
          <div class="col-xl-3 col-lg-6">
            <div class="card card-inverse card-success">
              <div class="card-block bg-success">
                <div class="rotate">
                  <i class="fa fa-user fa-5x"></i>
                </div>
                <h6 class="text-uppercase">Admins</h6>
                <h1 class="display-1"><%=rs.getString(1)%></h1>
              </div>
            </div>
          </div>
          <div class="col-xl-3 col-lg-6">
            <div class="card card-inverse card-danger">
              <div class="card-block bg-danger">
                <div class="rotate">
                  <i class="fa fa-list fa-4x"></i>
                </div>
                <h6 class="text-uppercase">Riders</h6>
                <h1 class="display-1"><%=rs.getString(2)%></h1>
              </div>
            </div>
          </div>
          <div class="col-xl-3 col-lg-6">
            <div class="card card-inverse card-info">
              <div class="card-block bg-info">
                <div class="rotate">
                  <i class="fa fa-twitter fa-5x"></i>
                </div>
                <h6 class="text-uppercase">Ongoing Orders</h6>
                <h1 class="display-1"><%=rs.getString(3)%></h1>
              </div>
            </div>
          </div>
          <div class="col-xl-3 col-lg-6">
            <div class="card card-inverse card-warning">
              <div class="card-block bg-warning">
                <div class="rotate">
                  <i class="fa fa-share fa-5x"></i>
                </div>
                <h6 class="text-uppercase">Pending Orders</h6>
                <h1 class="display-1"><%=rs.getString(4)%></h1>
              </div>
            </div>
          </div>
        </div>
        <% } %>
        <%
                rs.close();
                statement.close();
                connection.close();
            %>
            
               <%
                ResultSet rs1 = null;
                Class.forName("oracle.jdbc.driver.OracleDriver");
                connection = DriverManager.getConnection(connectionURL, "henshin", "system");
                statement = connection.createStatement();
                String QueryString1 = "SELECT M.MENU_NAME, M.MENU_PRICE, SUM(O.QUANTITY) AS QTY FROM ORDER_DETAILS O INNER JOIN MENU M ON M.MENU_ID = O.MENU_ID GROUP BY M.MENU_ID, M.MENU_NAME, M.MENU_PRICE";
                rs1 = statement.executeQuery(QueryString1);
                int i = 1;

           %>
        <p style="font-size: 24px; padding-top: 40px;">Top Picked Menu</p>
        <div class="row mb-5 pb-5">
        <div class="col-lg-8 col-md-8">
            <div class="table-responsive">
              <table class="table table-striped">
                <thead class="thead-inverse">
                  <tr>
                    <th>#</th>
                    <th>Menu</th>
                    <th>Price (RM)</th>
                    <th>Order count</th>
                  </tr>
                </thead>
                <tbody>
                    <%
                while (rs1.next()) {
            %>
                  <tr>
                    <td><%=i%></td>
                    <td><%=rs1.getString(1)%></td>
                    <td><%=rs1.getString(2)%></td>
                    <td><%=rs1.getString(3)%></td>
                  </tr>
                  <% i++; } %>
            <%
                rs1.close();
                statement.close();
                connection.close();
            %>
                </tbody>
              </table>
            </div>
          </div>
           
        </div>
    </main>
 
        </div>
  <!--semua table-->
  <script type="text/javascript" src="../js/jquery-3.4.1.min.js"></script>
  <!-- Bootstrap tooltips -->
  <script type="text/javascript" src="../js/popper.min.js"></script>
  <!-- Bootstrap core JavaScript -->
  <script type="text/javascript" src="../js/bootstrap.min.js"></script>
  <!-- MDB core JavaScript -->
  <script type="text/javascript" src="../js/mdb.min.js"></script>
  <script type="text/javascript" src="../js/addons/datatables.min.js"></script>
  <!-- sidebar tunjuk anak2-->
  <script>
      $('.feat-btn').click(function(){
          $('.sidebar ul .feat-show').toggleClass("show");
      });
  </script>
  <!--table-->
  <script>
  function checkAll(bx) {
  var cbs = document.getElementsByTagName('input');
  for(var i=0; i < cbs.length; i++) {
    if(cbs[i].type === 'checkbox') {
      cbs[i].checked = bx.checked;
    }
  }
}

$(document).ready(function() {
    $('#example').DataTable(

         {

      "aLengthMenu": [[5, 10, 25, -1], [5, 10, 25, "All"]],
        "iDisplayLength": 5
       }
        );
} );

$('#dt-basic-checkbox').dataTable({

    columnDefs: [{
    orderable: false,
    className: 'select-checkbox',
    targets: 0
    }],
    select: {
    style: 'os',
    selector: 'td:first-child'
    }
    });
  </script> 
</body>
</html>
