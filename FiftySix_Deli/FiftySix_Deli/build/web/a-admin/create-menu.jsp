<%-- 
    Document   : create-menu
    Created on : 21 Jan 2021, 6:54:26 am
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="henshin.model.AdminLoginBean"%>
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
    <link rel="stylesheet" href="../css/addons/datatables.min.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/dashboard.css">
    <link rel="stylesheet" href="../css/mdb.min.css">
    
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
                <li class="active"><a href="/FiftySix_Deli/menuController?action=listMenu">Manage Menu</a></li>
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
                <li><a href="/FiftySix_Deli/assignRiderController?action=viewOrders">Manage Order</a></li>
                <li><a href="report.jsp">Report</a></li>
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
        <main><br><br><br>
            
        <div class="signup-box">
            <div class="borang-header">
                FiftySix Kitchen
                
                <c:if test="${menu == null}">
                <form name="createMenu" action="/FiftySix_Deli/menuController?action=createMenu" method="POST" enctype="multipart/form-data">
                </c:if>
                    <div class="borang-content">
                        Menu Name: 
                        <c:if test="${menu != null}">
                        <input type="text" name="menuName" required><br><br>
                        </c:if>
                        Menu Price: 
                        <input type="number" name="menuPrice" required><br><br>    
                        Menu Description:
                        <textarea name="menuDesc" required></textarea><br><br>
                            
                        Menu Quantity:
                        <input type="number" name="menuQuan" required><br><br>
                            
                        Menu Image:
                        <input type="file" name="menuImage" required><br><br>
                            
                        Menu Category:
                            <select name="menuCat">
                                <option value="" hidden>Choose menu category</option>
                                <option value="1">Whole cake</option>
                                <option value="2">Cupcake</option>
                                <option value="3">Cookies</option>
                                <option value="4">Dessert</option>
                            </select>
                        
                        <button type="submit" class=" button btn1">Create Menu</button>
 
                    </div>
                </form>
            </div>
        </div>    
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
