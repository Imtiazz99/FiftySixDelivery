<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="henshin.model.AdminLoginBean"%>
<%@page import="henshin.model.reportBean"%>
<%@page import="henshin.dao.reportDAO"%>

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
    
</head>

<body>  
    <div class="sidebar">
        <div class="sidebar-user">
            <img src="../image/fox.png">
            <div class="user-image">
                  <p>Admin :<%=session.getAttribute("admin_email")%> </p>
            </div>
        </div>
        <div class="sidebar-menu">
            <hr>
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="manage-menu.jsp">Manage Menu</a></li>
                <li><a href="#">Manage User</a>
                <li><a href="#">Rider</a></li>
                <li><a href="manage-order.jsp">Manage Order</a></li>
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
                <h4>Report Sections</h4>
            </div>
              
    
          <table id="dt-basic-checkbox" class="table table-striped table-bordered" cellspacing="0" width="100%">
          <thead>
                <tr>
                 <th>Payment ID</th>
                 <th>Payment Date</th>
                 <th>Total Payment</th>
                 <th>Delivery Payment</th>
                </tr>
           </thead>
           <tbody>
           <!--kena sama nama dengan dalam bean-->
           <c:forEach items="${payments}" var="payment">            
                <tr>
                 <td><c:out value="${payment.paymentID}"/></td>
                 <td><c:out value="${payment.paymentTime}"/></td>
                 <td><c:out value="${payment.paymentTotal}"/></td>
                 <td><c:out value="${payment.paymentDelivery}"/></td>
                </tr>
           </c:forEach>
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
