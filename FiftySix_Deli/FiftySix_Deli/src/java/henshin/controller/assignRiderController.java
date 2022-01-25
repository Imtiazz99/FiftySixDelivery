package henshin.controller;
import henshin.dao.assignRiderDAO;
import henshin.model.assignRiderBean;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import henshin.model.orderBean;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Aina Syazana
 */
public class assignRiderController extends HttpServlet{
    private static final String ASSIGN = "a-admin/assign-rider.jsp";
    private static final String ASSIGNORDER = "a-admin/assigned-rider.jsp";
    private static final String VIEWS = "a-admin/manage-order.jsp";
    private static final String VIEW = "a-admin/assign-rider.jsp";
    private final assignRiderDAO dao; //an object to call the class
    String forward = ""; 
    
     public assignRiderController(){
        super();
        dao = new assignRiderDAO();
    }
     
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String action = request.getParameter("action");
            
            
            //lagi banyak things to do, lagi banyaaaakkk action
            if(action.equalsIgnoreCase("viewRiders")){ //actions yang customer can do (banyak lagiiiiiiiii)
                forward = VIEW;
                request.setAttribute("riders", dao.getAllRider());
            }   
            else if(action.equalsIgnoreCase("viewOrders")) {
                forward = VIEWS;
                 request.setAttribute("orders", dao.getPendingOrder());
                 
            }
            else if(action.equalsIgnoreCase("updateOrder")) {
                assignRiderBean assign = new assignRiderBean();
                assign.setRiderID(Integer.parseInt (request.getParameter("rider_id")));
                assign.setOrderID(Integer.parseInt (request.getParameter("order_id")));
                
                
                try {
                    dao.updateOrders(assign);
                    request.setAttribute("orders", dao.getAssignOrder());
                } catch (NoSuchAlgorithmException ex) { 
                    Logger.getLogger(assignRiderController.class.getName()).log(Level.SEVERE, null, ex);
                }
                forward = ASSIGNORDER;
                
            } 
            else if(action.equalsIgnoreCase("ViewAssignedOrder")) {
                forward = ASSIGNORDER;
                 request.setAttribute("orders", dao.getAssignOrder());
            }
                RequestDispatcher view = request.getRequestDispatcher(forward);
                view.forward(request, response);
    }
     
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String action = request.getParameter("action");
            
    }
}


