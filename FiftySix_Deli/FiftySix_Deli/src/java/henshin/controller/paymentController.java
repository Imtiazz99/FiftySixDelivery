package henshin.controller;

/**
 *
 * @author Amirah
 */
import henshin.dao.paymentDAO;
import henshin.model.paymentBean;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class paymentController extends HttpServlet{
    private static final long serialVersionUID = 1L;
    private static String VIEW = "a-customer/payment.jsp";
    private static String VIEWDETAILS = "a-customer/payment-details.jsp";
    private static String VIEWRECEIPT = "a-customer/view-receipt.jsp";
    
    private paymentDAO dao; //an object to call the class
    String forward = ""; 
    
     public paymentController(){
        super();
        dao = new paymentDAO();
    }
     
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
          paymentBean bean = new paymentBean();
          String action = request.getParameter("action");
          
          int cust_id = Integer.parseInt(request.getParameter("cust_id"));
          int order_id = dao.getCurrentID(cust_id); 
          if(action.equalsIgnoreCase("viewDetails")){
              try {
                  //Untuk masuk order id
                  dao.insertPaymentDetails1(bean, cust_id);
                  //Untuk masuk dalam order details
                  dao.insertPaymentDetails2(cust_id, order_id);
              } 
              catch (NoSuchAlgorithmException ex) {
                  Logger.getLogger(paymentController.class.getName()).log(Level.SEVERE, null, ex);
              }
              
              forward = VIEWDETAILS;
              request.setAttribute("pays", dao.getPaymentDetails(cust_id, order_id));
             
          }
          else if(action.equalsIgnoreCase("viewPaymentDetails")){
              order_id = dao.getCurrentID(cust_id);
              forward = VIEW;
              request.setAttribute("pays", dao.customerDetails(cust_id));
              
          }
          RequestDispatcher view = request.getRequestDispatcher(forward);
          view.forward(request, response);  
            
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {         
            String action = request.getParameter("action");     
            int cust_id = Integer.parseInt(request.getParameter("cust_id"));
            paymentBean payment = new paymentBean();
            int order_id = dao.getCurrentID(cust_id);
            HttpSession session = request.getSession();
            session.setAttribute("order_id", order_id);
;
            System.out.print(order_id);
             if(action.equalsIgnoreCase("createPayment")) {
                payment.setAddressID(Integer.parseInt(request.getParameter("addressID")));
                payment.setMethod_id(Integer.parseInt(request.getParameter("method_id")));
                payment.setTotal_payment(Double.parseDouble(request.getParameter("total")));
                payment.setDelivery_charge(Double.parseDouble(request.getParameter("delivery")));
                //payment.setOrder_id(Integer.parseInt(request.getParameter("order_id")));
               
                                try {
                                        dao.makePayment(payment, order_id);
                                        
                                        //dao.updatePayment(payment, order_id);
                                        
                                        int oid = Integer.parseInt(request.getParameter("order_id"));
                                        int cid = Integer.parseInt(request.getParameter("cust_id"));
                                        request.setAttribute("pays", dao.paymentReceipt(cid, oid));
                                        forward = VIEWRECEIPT;
                                        dao.clearCart(cust_id);
                                } catch (Throwable ex) {
                                        ex.printStackTrace();
                }
            }
            RequestDispatcher view = request.getRequestDispatcher(forward);
            view.forward(request, response);
            
    }
}
