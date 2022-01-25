/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package henshin.controller;

/**
 *
 * @author TK
 */
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import henshin.dao.orderCustDAO;
import henshin.model.orderBean;

public class orderCustController extends HttpServlet{
    private static String VIEWCOMPORDER = "a-rider/orderComplete.jsp";
    private static String VIEW_ORDERCUSTOMER = "a-rider/viewOrder.jsp";
    private static String UPDATE_PREPARE = "a-rider/viewOrder.jsp";
    private static String UPDATE_DELIVTIME = "a-rider/viewOrder.jsp";
    private static String UPDATE_COMPTIME = "a-rider/viewOrder.jsp";
    private static String LIST_ORDERCUST = "a-customer/viewOrder.jsp";
    private static String LIST_ORDERCUSTDETAILS = "a-customer/viewOrderDetails.jsp";
    private static String VIEW_ORDERONGOING = "a-customer/viewOrderOngoing.jsp";
    //private static String UPDATE_ORDERCUSTOMER = "a-rider/viewOrder.jsp";
    

    private final orderCustDAO daoOrderCust;
    String forward="";
    
    public orderCustController(){
        super();
        daoOrderCust = new orderCustDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
        String action = request.getParameter("action");
        
        
        if(action.equalsIgnoreCase("viewOrderCust")){   
            int ID = Integer.parseInt(request.getParameter("ID"));
            forward = VIEW_ORDERCUSTOMER;
            request.setAttribute("orders",daoOrderCust.getAllOrderByCust(ID));
            
        }else if(action.equalsIgnoreCase("viewCompOrder")){
            int ID = Integer.parseInt(request.getParameter("ID"));
            forward = VIEWCOMPORDER;
            request.setAttribute("orders", daoOrderCust.getAllOrderByCust(ID));
        }
        
        else if(action.equalsIgnoreCase("updatePreparing")){
            orderBean order = new orderBean();
            int orderID = Integer.parseInt(request.getParameter("order_id"));
            int riderID = Integer.parseInt(request.getParameter("rider_id"));
            
            daoOrderCust.updatePreparing(order, orderID);
            request.setAttribute("orders", daoOrderCust.getAllOrderByCust(riderID));
            forward = UPDATE_PREPARE;
        }  
        else if(action.equalsIgnoreCase("updateDeliveryTime")){
            orderBean order = new orderBean();
            int orderID = Integer.parseInt(request.getParameter("order_id"));
            int riderID = Integer.parseInt(request.getParameter("rider_id"));
            
            daoOrderCust.updateDeliveryTime(order, orderID);
            request.setAttribute("orders", daoOrderCust.getAllOrderByCust(riderID));
            forward = UPDATE_DELIVTIME;
        }
        
        else if(action.equalsIgnoreCase("updateCompleteTime")){
            orderBean order = new orderBean();
            int orderID = Integer.parseInt(request.getParameter("order_id"));
            int riderID = Integer.parseInt(request.getParameter("rider_id"));
            
            daoOrderCust.updateCompleteTime(order, orderID);
            request.setAttribute("orders", daoOrderCust.getAllOrderByCust(riderID));
            forward = UPDATE_COMPTIME;
        }
        else if(action.equalsIgnoreCase("orderCustomer")){
            //int orderId = request.getIntHeader("orderId");
            forward = LIST_ORDERCUST;
            int custID = Integer.parseInt(request.getParameter("cust_id"));
            request.setAttribute("orders", daoOrderCust.getAllOrderCust(custID));
        }
        //view order details kat customer. guna orderCustDAO
        else if(action.equalsIgnoreCase("orderCustomerDetails")){
            //int orderId = request.getIntHeader("orderId");
            forward = LIST_ORDERCUSTDETAILS;
            int orderID = Integer.parseInt(request.getParameter("order_id"));
            request.setAttribute("orders", daoOrderCust.getAllOrderCustDetails(orderID));
        }
        //view ongoing order kat customer. guna orderCustDAO
        else if(action.equalsIgnoreCase("viewOngoing")){
            forward = VIEW_ORDERONGOING;
            int custID = Integer.parseInt(request.getParameter("cust_id"));
            request.setAttribute("orders",daoOrderCust.getAllOrderCust(custID));
        }
        else if(action.equalsIgnoreCase("viewPending")){
            forward = "a-customer/viewOrderPending.jsp";
            
            int custID = Integer.parseInt(request.getParameter("cust_id"));
            request.setAttribute("orders",daoOrderCust.getAllOrderCust(custID));
        }
        
        RequestDispatcher view = request.getRequestDispatcher(forward);
        view.forward(request, response);
    }//close doGet
    
    protected void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{

    }
}
