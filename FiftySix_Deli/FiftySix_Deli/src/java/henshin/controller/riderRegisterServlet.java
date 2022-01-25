package henshin.controller;
import java.io.*;
import java.security.NoSuchAlgorithmException;
import javax.servlet.*;
import javax.servlet.http.*;
import henshin.dao.riderDAO;
import henshin.model.riderBean;
import java.util.logging.Level;
import java.util.logging.Logger;    
import java.text.ParseException;
import java.text.SimpleDateFormat;
import javax.servlet.annotation.WebServlet;
/**
 *
 * @author Aina Syazana
 */
@WebServlet("/a-admin/riderRegisterServlet")
public class riderRegisterServlet extends HttpServlet{
    private static String REGISTER = "/a-admin/add-rider.jsp";
    private static String VIEWALL = "a-admin/manage-rider.jsp";
    private static String DELETE = "a-admin/manage-rider.jsp";
    private static String VIEW = "a-rider/profile.jsp";
    private static String UPDATE = "a-rider/profile.jsp";
    private riderDAO dao; //an object to call the class
    String forward = ""; 
    
     public riderRegisterServlet(){
        super();
        dao = new riderDAO();
    }
     
     @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            
    }
     
     @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String action = request.getParameter("action");
            riderBean rider = new riderBean();
            
            rider.setRiderName(request.getParameter("riderName"));
            rider.setIdentificationNo(request.getParameter("riderIC"));
            rider.setRiderPhone(request.getParameter("riderPhone"));
            rider.setEmail(request.getParameter("riderEmail"));
            rider.setPlateNo(request.getParameter("plateNo"));            
            rider.setPassword(request.getParameter("riderPass"));            
            //tengok customer as a whole
            //value from form dia simpan dalam cust as an object
            rider = riderDAO.getRider(rider);
            //to check whether customer tu ada ke tak
            //if customer tak wujud, baru dia adddddddddddd

            rider = riderDAO.getRider(rider);

            //to check whether customer tu ada ke tak
            //if customer tak wujud, baru dia adddddddddddd
         
            if(!rider.isValid()){
                try {             
                    dao.addRider(rider);
                } catch (NoSuchAlgorithmException ex) {
                ex.printStackTrace();
                }
                request.setAttribute("successr", "<script>alert('Successfully Registered')</script>");
                RequestDispatcher view = request.getRequestDispatcher("add-rider.jsp");
                view.forward(request, response);
            }
            else{
                request.setAttribute("errorr", "<script>alert('This account details already exists!  ')</script>");
                RequestDispatcher view = request.getRequestDispatcher("add-rider.jsp");
                view.forward(request, response);
                System.out.println("Account Already Exists"); 
            }
               
    }
} 

