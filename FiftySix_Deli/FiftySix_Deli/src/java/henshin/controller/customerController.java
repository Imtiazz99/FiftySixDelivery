package henshin.controller;

import java.io.*;
import java.security.NoSuchAlgorithmException;
import javax.servlet.*;
import javax.servlet.http.*;
import henshin.dao.customerDAO;
import henshin.model.customerBean;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.annotation.WebServlet;
/**
 *
 * @author Asus
 */
//@WebServlet("customerController")
public class customerController extends HttpServlet{
    
    private static String REGISTER = "/signup.jsp";
    private static String VIEW = "a-customer/profile.jsp";
    private static String VIEWALL = "a-admin/manage-cust.jsp";
    private static String DELETE = "a-admin/manage-cust.jsp";
    private static String UPDATE = "a-customer/profile.jsp";
    private customerDAO dao; //an object to call the class
    String forward = ""; 
    
    public customerController(){
        super();
        dao = new customerDAO();
    }
    
    //post create and update
    //get view and read
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String action = request.getParameter("action");
            
            if(action.equalsIgnoreCase("viewCustomers")){ //actions yang customer can do (banyak lagiiiiiiiii)
                forward = VIEWALL;
                request.setAttribute("customer", dao.getAllCustomer());
            } 
            else if(action.equalsIgnoreCase("deleteCustomer")){
                int ID = Integer.parseInt(request.getParameter("cust_ID"));
                forward = DELETE;
                dao.deleteCustomer(ID);
                request.setAttribute("customer", dao.getAllCustomer());
                request.setAttribute("successr", "<script>alert('Successfully Registered')</script>");
            }
            else if(action.equalsIgnoreCase("viewProfile")){
                //dah masuk
                forward = VIEW;
                String email = request.getParameter("email");
                //System.out.println(email);
                customerBean customer = dao.getCustomerByEmail(email);
                request.setAttribute("customer", customer);
            }
            else if(action.equalsIgnoreCase("viewAddress")){
                //dah masuk
                forward = "a-customer/address-list.jsp";
                //String email = request.getParameter("email");
                int ID = Integer.parseInt(request.getParameter("custID"));
                System.out.println(ID);
                //System.out.println(email);
                request.setAttribute("customer", dao.getAddressListByID(ID));
            }
            else if(action.equalsIgnoreCase("deleteAddress")){
                //dah masuk
                
                int ID = Integer.parseInt(request.getParameter("address_ID"));
                dao.deleteAddress(ID);
                
                forward = "a-customer/address-list.jsp";
                int custID = Integer.parseInt(request.getParameter("custID"));
                System.out.println(ID);
                //System.out.println(email);
                request.setAttribute("customer", dao.getAddressListByID(custID));
                request.setAttribute("successr", "<script>alert('Successfully Registered')</script>");
            }
            else if(action.equalsIgnoreCase("viewPassword")){
                //dah masuk
                forward = "a-customer/password.jsp";
            }
            else if(action.equalsIgnoreCase("editAddress")){
                forward ="a-customer/payment_1.jsp";
            }

            RequestDispatcher view = request.getRequestDispatcher(forward);
            view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String action = request.getParameter("action");
            customerBean cust = new customerBean();
            
            //tengok customer as a whole
            //value from form dia simpan dalam cust as an object
            cust = customerDAO.getCust(cust);
            
            //to check whether customer tu ada ke tak
            //if customer tak wujud, baru dia add
            if(action.equalsIgnoreCase("updateProfile")){
                cust.setCustID(Integer.parseInt(request.getParameter("custID")));
                cust.setCustName(request.getParameter("custName"));
                cust.setEmail(request.getParameter("email"));
                cust.setPhoneNo(request.getParameter("phoneNo"));
                cust.setDeliveryAddress(request.getParameter("deliveryAddress"));
		forward = UPDATE;
                try {
                    dao.updateCustomer(cust);
                    
                } catch (NoSuchAlgorithmException ex) {
                    Logger.getLogger(customerController.class.getName()).log(Level.SEVERE, null, ex);
                }
                request.setAttribute("successr", "<script>alert('Successfully Registered')</script>");
                RequestDispatcher view = request.getRequestDispatcher(VIEW);
		request.setAttribute("customer", dao.getCustomerByEmail(cust.getEmail()));
		view.forward(request, response);
            }
             if(action.equalsIgnoreCase("updatePassword")){
                cust.setEmail(request.getParameter("email"));
                String oPass = request.getParameter("oPass");
                String nPass = request.getParameter("nPass");
                String cPass = request.getParameter("cPass");
                
                if(nPass.equals(cPass)){
                     try {
                            dao.updatePassword(cust, oPass, nPass);
                            RequestDispatcher view = request.getRequestDispatcher("/a-customer/password.jsp");
                            response.setHeader("Refresh", "0; URL=/FiftySix_Deli/a-customer/password.jsp?&email=amirahaziqah99@gmail.com");
                            //view.forward(request, response);
                             request.setAttribute("passwordr", "<script>alert('Successfully Registered')</script>");

                } catch (NoSuchAlgorithmException ex) {
                    Logger.getLogger(customerController.class.getName()).log(Level.SEVERE, null, ex);
                } catch (SQLException ex) {
                    Logger.getLogger(customerController.class.getName()).log(Level.SEVERE, null, ex);
                }
                }
                
                else{
                     request.setAttribute("passwordrw", "<script>alert('Successfully Registered')</script>");
                     RequestDispatcher view = request.getRequestDispatcher("a-customer/password.jsp?error=true");
                     view.forward(request, response);
                }
            }
            if(action.equalsIgnoreCase("addAddress")){
               cust.setStreet(request.getParameter("street")); 
               cust.setCity(request.getParameter("city")); 
               cust.setState(request.getParameter("state")); 
               cust.setPostcode(request.getParameter("postcode")); 
               int ID = Integer.parseInt(request.getParameter("custID"));
                
                try {
                    dao.addAddress(cust, ID);
                    
                } catch (NoSuchAlgorithmException ex) {
                    Logger.getLogger(customerController.class.getName()).log(Level.SEVERE, null, ex);
                } catch (SQLException ex) {
                    Logger.getLogger(customerController.class.getName()).log(Level.SEVERE, null, ex);
                }
                request.setAttribute("addr", "<script>alert('Successfully Registered')</script>");
                response.setHeader("Refresh", "0; URL=/FiftySix_Deli/customerController?action=viewAddress&custID="+ID);
		request.setAttribute("customer", dao.getCustomerByEmail(cust.getEmail()));
	
            }
    }
}

