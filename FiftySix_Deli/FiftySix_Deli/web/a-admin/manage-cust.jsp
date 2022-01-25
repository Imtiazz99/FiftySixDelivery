<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <link rel="stylesheet" href= "css/addons/datatables.min.css">
    <link rel="stylesheet" href= "css/bootstrap.min.css">
    <link rel="stylesheet" href= "css/dashboard.css">
    <link rel="stylesheet" href= "css/mdb.min.css">
    
</head>

<body>  
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
                <li class="active">
                    <a href="#" class="feat-btn">Manage User
                        <span class="fas fa-caret-down"></span>
                    </a>
                </li>
                <ul class="feat-show">
                    <li><a href="/FiftySix_Deli/a-admin/adminController?action=viewAdmins">Admin</a></li>
                    <li><a href="/FiftySix_Deli/a-admin/riderController?action=viewRiders">Rider</a></li>
                    <li><a href="#">Customer</a></li>
                </ul>
                <li><a href="/FiftySix_Deli/assignRiderController?action=viewOrders">Manage Order</a></li>
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
        <main>
            
            <div class="heading">
                <h4>List of Customers</h4>
            </div>
              
    
          <table id="dt-basic-checkbox" class="table table-striped table-bordered" cellspacing="0" width="100%">
          <thead>
                <tr>
                 <th>Customer Name</th>
                 <th>email</th>
                 <th>Phone No.</th>
                 <th>Reg. Date
                 <th>Action</th>
                </tr>
           </thead>
           <tbody>
           <!--kena sama nama dengan dalam bean-->
           <c:forEach items="${customer}" var="customer">            
                <tr>
                 <td><c:out value="${customer.custName}"/></td>
                 <td><c:out value="${customer.email}"/></td>
                 <td><c:out value="${customer.phoneNo}"/></td>
                 <td><c:out value="${customer.regDate}"/></td>
                 <td>
                    <center>
                        <a href="/FiftySix_Deli/customerController?action=deleteCustomer&cust_ID=<c:out value="${customer.custID}"/>"><i class="fas fa-times" onclick="return confirm('Are you sure you want to delete this customer?')" aria-hidden="true" style="color:red"></i></a>
                    </center>
                 </td>
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
  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
 <%
                              if(request.getAttribute("successr") == null) {
                                  out.println("");
                              }   
                              else {
                                     out.println("<script>swal('Customer Successfully Deleted!','','success')</script>");
                              }
                        
 %>
</body>
</html>
