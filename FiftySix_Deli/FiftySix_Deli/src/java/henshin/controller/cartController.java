
package henshin.controller;

import henshin.dao.cartDAO;
import henshin.model.cartBean;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

/**
 *
 * @author Asus
 */
//@WebServlet("cartController")
public class cartController extends HttpServlet{
    private static String VIEW = "a-customer/menu.jsp";
    private static String VIEWCART = "a-customer/cart.jsp";
    private static String VIEWMENU = "a-customer/menu.jsp";
    
    private cartDAO dao; //an object to call the class
    String forward = ""; 
    
     public cartController(){
        super();
        dao = new cartDAO();
    }
     
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         
        HttpSession session = request.getSession();
        List li;
        if(session.getAttribute("logUser")!=null){
            String param = request.getParameter("id");
            if(session.getAttribute("addToCart")==null){
                li = new ArrayList();
                li.add(param);
                session.setAttribute("addToCart", li);
            }
            else{
                li = (List)session.getAttribute("addToCart");
                if(!li.contains(param)){
                    li.add(param);
                }
                session.setAttribute("addToCart", li);
            }
            response.getWriter().print(li.size()); //nak tunjuk ada berapa banyak barang dalam cart
        }
        else{
              JOptionPane.showMessageDialog(null, "You need to login first!");
              response.getWriter().print(0);
              session.invalidate();
        }
    
    }
        /*cartBean cart = new cartBean();
            //Get all the fields from the form using getParameter
            //getParameter (kena sama dalam form)
            cart.setCartID(Integer.parseInt(request.getParameter("cartID")));
            cart.setMenuID(Integer.parseInt(request.getParameter("cartID")));
            cart.setCustID(Integer.parseInt(request.getParameter("cartID")));
            cart.setQty(Integer.parseInt(request.getParameter("cartID")));
            
            //tengok cart as a whole
            //value from form dia simpan dalam cart as an object
            cart = cartDAO.getCart(cart);
            
            //to check whether customer tu ada ke tak
            //if customer tak wujud, baru dia adddddddddddd
            if(!cart.isValid()){ 
                try {             
                    dao.addToCart(cart);
                } catch (NoSuchAlgorithmException ex) {
                    Logger.getLogger(customerController.class.getName()).log(Level.SEVERE, null, ex);
                }
                RequestDispatcher view = request.getRequestDispatcher("/cart.jsp");
                view.forward(request, response);
            }
            /*else{ //kalau tak, dia update profile
                dao.updateCustByID(cust);
                RequestDispatcher view = request.getRequestDispatcher(VIEW); //request to show the profile view
                view.forward(request, response);
            }*/
    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String action = request.getParameter("action");
            cartBean cart = new cartBean();
            
            cart.setEmail(request.getParameter("email"));
           
 
            if(action.equalsIgnoreCase("addToCart")){ //actions yang customer can do (banyak lagiiiiiiiii)
                cart.setMenuID(Integer.parseInt(request.getParameter("menu_ID")));
                cart.setQty(Integer.parseInt(request.getParameter("qty")));
                int ID = Integer.parseInt(request.getParameter("cust_id"));
                try {             
                    dao.addCart(cart, ID);
                } catch (NoSuchAlgorithmException ex) {
                    Logger.getLogger(cartController.class.getName()).log(Level.SEVERE, null, ex);
                }
                RequestDispatcher view = request.getRequestDispatcher(VIEWMENU);
                request.setAttribute("menu", dao.getAllMenu());
                view.forward(request, response);    
            }
            else if(action.equalsIgnoreCase("viewCart")){
                String email = request.getParameter("email");
                RequestDispatcher view = request.getRequestDispatcher(VIEWCART);
                request.setAttribute("carts", dao.getAllCart(email));
                view.forward(request, response);
            }
            else if(action.equalsIgnoreCase("deleteCart")){
                int ID = Integer.parseInt(request.getParameter("cart_ID"));
                String email = request.getParameter("email");
                dao.deleteCart(ID);
                RequestDispatcher view = request.getRequestDispatcher(VIEWCART);
                request.setAttribute("carts", dao.getAllCart(email));
                view.forward(request, response);
            }
    }
}
            

