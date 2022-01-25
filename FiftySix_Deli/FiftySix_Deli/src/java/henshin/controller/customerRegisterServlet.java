package henshin.controller;

import java.io.*;
import java.security.NoSuchAlgorithmException;
import javax.servlet.*;
import javax.servlet.http.*;
import henshin.dao.customerDAO;
import henshin.model.customerBean;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.annotation.WebServlet;
/**
 *
 * @author Asus
 */
//@WebServlet("/a-customer/customerRegisterServlet")
public class customerRegisterServlet extends HttpServlet{
    
    private static String REGISTER = "/signup.jsp";
    private static String VIEW = "a-customer/profile.jsp";
    private static String VIEWALL = "a-admin/manage-cust.jsp";
    private static String DELETE = "a-admin/manage-cust.jsp";
    private static String UPDATE = "a-customer/profile.jsp";
    private customerDAO dao; //an object to call the class
    String forward = ""; 
    
    public customerRegisterServlet(){
        super();
        dao = new customerDAO();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
            String action = request.getParameter("action");
            customerBean cust = new customerBean();
            
            cust.setCustName(request.getParameter("custName"));
            cust.setEmail(request.getParameter("email"));
            cust.setPhoneNo(request.getParameter("phoneNo"));
            cust.setPassword(request.getParameter("password"));

            cust = customerDAO.getCust(cust);
            cust = customerDAO.getCusto(cust);
    
            //to check whether customer tu ada ke tak
            //if customer tak wujud, baru dia adddddddddddd
        if (action.equalsIgnoreCase("addCust")) {
            if(!cust.isValid()){ 
                try {             
                    dao.addCust(cust);
                } catch (NoSuchAlgorithmException ex) {
                ex.printStackTrace();
                }
                request.setAttribute("success", "<script>alert('Successfully Registered! Please log in here')</script>");
                RequestDispatcher view = request.getRequestDispatcher("/a-customer/custlogin.jsp");
                view.forward(request, response);
            }
               else {
                request.setAttribute("error", "<script>alert('This account details already exists! Please log in here')</script>");
                RequestDispatcher view = request.getRequestDispatcher("/signup.jsp");
                view.forward(request, response);
                System.out.println("Account Already Exists");  
            }
    }
 
    }
}


