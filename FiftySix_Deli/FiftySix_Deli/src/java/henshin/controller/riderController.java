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
@WebServlet("/a-admin/riderController")
public class riderController extends HttpServlet{
    private static String REGISTER = "/a-admin/add-rider.jsp";
    private static String VIEWALL = "manage-rider.jsp";
    private static String DELETE = "manage-rider.jsp";
    private static String VIEW = "a-rider/profile.jsp";
    private static String UPDATE = "a-rider/profile.jsp";
    private riderDAO dao; //an object to call the class
    String forward = ""; 
    
     public riderController(){
        super();
        dao = new riderDAO();
    }
     
     @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String action = request.getParameter("action");
            
            
            //lagi banyak things to do, lagi banyaaaakkk action
            if(action.equalsIgnoreCase("viewRiders")){ //actions yang customer can do (banyak lagiiiiiiiii)
                forward = VIEWALL;
                request.setAttribute("riders", dao.getAllRider());
            } 
            else if(action.equalsIgnoreCase("deleteRider")){
                int ID = Integer.parseInt(request.getParameter("rider_ID"));
                forward = DELETE;
                dao.deleteRider(ID);
                request.setAttribute("riders", dao.getAllRider());
                request.setAttribute("successr", "<script>alert('Successfully Registered')</script>");
            }
            else if(action.equalsIgnoreCase("viewProfile")){
                //dah masuk
                forward = VIEW;
                String email = request.getParameter("email");
                //System.out.println(email);
                riderBean rider = dao.getRiderByEmail(email);
                request.setAttribute("riders", rider);
            }
            else{
                forward = REGISTER;      
            }
            RequestDispatcher view = request.getRequestDispatcher(forward);
            view.forward(request, response);
    }
     
     @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String action = request.getParameter("action");
            riderBean rider = new riderBean();
            
            rider.setEmail(request.getParameter("email"));
            rider.setRiderName(request.getParameter("riderName"));
            rider.setIdentificationNo(request.getParameter("riderIC"));
            rider.setPlateNo(request.getParameter("plateNo"));
            rider.setRiderPhone(request.getParameter("riderPhone"));
            rider.setStatus(request.getParameter("status"));
            rider.setPassword(request.getParameter("password"));
            //tengok customer as a whole
            //value from form dia simpan dalam cust as an object
            rider = riderDAO.getRider(rider);
            //to check whether customer tu ada ke tak
            //if customer tak wujud, baru dia adddddddddddd
            if(action.equalsIgnoreCase("updateProfile")){
                rider.setRiderID(Integer.parseInt(request.getParameter("riderID")));
                forward = UPDATE;
                try {
                    dao.updateRider(rider);
                    
                } catch (NoSuchAlgorithmException ex) {
                    Logger.getLogger(customerController.class.getName()).log(Level.SEVERE, null, ex);
                }
                request.setAttribute("successr", "<script>alert('Successfully Registered')</script>");
                RequestDispatcher view = request.getRequestDispatcher(VIEW);
                request.setAttribute("riders", dao.getRiderByEmail(rider.getEmail()));
                view.forward(request, response); 
            }


            
            /*else{ //kalau tak, dia update profile
            dao.updateCustByID(cust);
            RequestDispatcher view = request.getRequestDispatcher(VIEW); //request to show the profile view
            view.forward(request, response);
            }*/
               
    }
}
