<%-- 
    Document   : assigned-rider
    Created on : 13 Feb 2021, 3:04:02 pm
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@page import="henshin.model.AdminLoginBean"%>
<% 
    response.setHeader("Cache-Control","no-cache, no-store,must-revalidate");  
    response.setHeader("Pragma","no-cache"); 
    response.setHeader("Expires","0");
    
    AdminLoginBean rider = (AdminLoginBean) session.getAttribute("logAdmin");
    if(rider==null){
        response.sendRedirect("a-admin/adminlogin.jsp");
    }
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lykmapipo/themify-icons@0.1.2/css/themify-icons.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
    <link rel="stylesheet" href="css/addons/datatables.min.css">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/dashboard.css">
    <link rel="stylesheet" href="css/mdb.min.css">
</head>

<body>  
    <%
	String order_id = (String) session.getAttribute("seeionOrderRider");
    %>
    <div class="sidebar">
        <div class="sidebar-user">
            <img src="image/fox.png">
            <div class="user-image">
                   <p>Admin :<%=session.getAttribute("admin_email")%></p>
            </div>
        </div>
        <div class="sidebar-menu">
            <hr>
            <ul>
                <li><a href="a-admin/index.jsp">Home</a></li>
                <li><a href="/FiftySix_Deli/menuController?action=listMenu">Manage Menu</a></li>
                <li>
                    <a href="#" class="feat-btn">Manage User
                        <span class="fas fa-caret-down"></span>
                    </a>
                </li>
                <ul class="feat-show">
                    <li><a href="/FiftySix_Deli/a-admin/adminController?action=viewAdmins">Admin</a></li>
                    <li><a href="/FiftySix_Deli/a-admin/riderController?action=viewRiders">Rider</a></li>
                    <li><a href="/FiftySix_Deli/customerController?action=viewCustomers">Customer</a></li>
                </ul>
                <li class="active"><a href="/FiftySix_Deli/assignRiderController?action=viewOrders">Manage Order</a></li>
                <li><a href="a-admin/report.jsp">Report</a></li>
                <li><a href="a-admin/AdminLogoutServlet">Logout</a></li>
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
        <main><br><br><br>
            <h4>List of Assigned Order</h4>
    
          <table id="dt-basic-checkbox" class="table table-striped table-bordered" cellspacing="0" width="100%">
          <thead>
                <tr>
                 <th>Rider Name</th>
                 <th>Customer Name</th>
                 <th>Phone No.Customer</th>
                 <th>Menu</th>
                 <th>Address</th>
                  <th>Price (RM)</th>
                  <th>Status Order</th>
                </tr>
           </thead>
           <tbody>
               
               
               <c:forEach items= "${orders}" var= "orders" >  
                    <tr>
                 <td><c:out value="${orders.rider_name}"/></td>
                 <td><c:out value="${orders.cust_name}"/></td>
                 <td><c:out value="${orders.phone_no}"/></td>
                 <td><c:out value="${orders.menuname}"/></td>
                 <td><c:out value="${orders.street}"/> <c:out value="${orders.city}"/> <c:out value="${orders.state}"/> <c:out value="${orders.postcode}"/></td>
                 <td><c:out value="${orders.menuprice}"/></td>
                 <td><c:out value="${orders.order_status}"/></td>
                
         
          </c:forEach>
          
            </tr>
            </tbody>
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
  <script>
      $('.feat-btn').click(function(){
          $('.sidebar ul .feat-show').toggleClass("show");
      });
  </script>
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

