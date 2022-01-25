<%-- 
    Document   : index
    Created on : Feb 7, 2021, 10:38:20 PM
    Author     : Aina Syazana 
--%>
<%@page import="henshin.model.RiderLoginBean"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% 
    response.setHeader("Cache-Control","no-cache, no-store,must-revalidate");  
    response.setHeader("Pragma","no-cache"); 
    response.setHeader("Expires","0");
    
    RiderLoginBean rider = (RiderLoginBean) session.getAttribute("logRider");
    if(rider==null){
        response.sendRedirect("riderlogin.jsp");
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
                <p>Rider</p>
            </div>
        </div>
        <div class="sidebar-menu">
            <hr>
            <ul>
                <li  class="active"><a href="index.jsp">Home</a></li>
                <li><a href="/FiftySix_Deli/riderController?action=viewProfile&email=<%= session.getAttribute("rider_email")%>">My Profile</a></li>
                <li>
                    <a href="#" class="feat-btn">Manage Order
                        <span class="fas fa-caret-down"></span>
                    </a>
                </li>
                <ul class="feat-show">
                    <li><a href="/FiftySix_Deli/orderCustController?action=viewOrderCust&ID=<%= session.getAttribute("rider_id")%>">On-going</a></li>
                    <li><a href="/FiftySix_Deli/orderCustController?action=viewCompOrder&ID=<%= session.getAttribute("rider_id")%>">Completed</a></li>
                </ul>
                <li><a href="RiderLogoutServlet">Logout</a></li>
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
        
     
       <div class="row mb-3 mt-5 pt-3">
          <div class="col-xl-3 col-lg-6">
            <div class="card card-inverse card-success">
              <div class="card-block bg-success">
                <div class="rotate">
                  <i class="fa fa-user fa-5x"></i>
                </div>
                <h6 class="text-uppercase">Completed Orders</h6>
              
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
     
              </div>
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
 <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
  <%
                              if(request.getAttribute("success") == null) {
                                  out.println("");
                              }   
                              else {
                                    out.println("<script>swal('Successfully Logged In','Rider','success')</script>");
                              }
                        
 %>
</body>
</html>
