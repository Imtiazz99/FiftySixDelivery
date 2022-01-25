/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package henshin.controller;

import java.io.*;
import javax.servlet.annotation.WebServlet;
import java.security.NoSuchAlgorithmException;
import javax.servlet.*;
import javax.servlet.http.*;
import henshin.dao.adminDAO;
import henshin.model.adminBean;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author Asus
 */
@WebServlet("/a-admin/adminController")
public class adminController extends HttpServlet{
    
    private static String REGISTER = "/a-admin/add-admin.jsp";
    private static String VIEW = "/viewProfile.jsp";
    private static String VIEWALL = "manage-admin.jsp";
    private static String DELETE = "manage-admin.jsp";
    private adminDAO dao; //an object to call the class
    String forward = ""; 
    
    public adminController(){
        super();
        dao = new adminDAO();
    }
    
    //post create and update
    //get view and read
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String action = request.getParameter("action");
            
            if(action.equalsIgnoreCase("viewAdmins")){ //actions yang customer can do (banyak lagiiiiiiiii)
                forward = VIEWALL;
                request.setAttribute("admins", dao.getAllAdmin());
            }   
            else if(action.equalsIgnoreCase("deleteAdmin")){
                int ID = Integer.parseInt(request.getParameter("admin_ID"));
                forward = DELETE;
                dao.deleteAdmin(ID);
                request.setAttribute("admins", dao.getAllAdmin());
                request.setAttribute("successr", "<script>alert('Successfully Registered')</script>");

            }

            RequestDispatcher view = request.getRequestDispatcher(forward);
            view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            adminBean admin = new adminBean();
            //Get all the fields from the form using getParameter
            //getParameter (kena sama dalam form)
            admin.setAdminName(request.getParameter("adminName"));
            admin.setEmail(request.getParameter("email"));
            admin.setPhoneNo(request.getParameter("phoneNo"));
            admin.setPassword(request.getParameter("password"));
            
            //tengok admin as a whole
            //value from form dia simpan dalam Admin as an object
            admin = adminDAO.getAdmin(admin);
            
            //to check whether admin tu ada ke tak
            //if admin tak wujud, baru dia adddddddddddd
           admin = adminDAO.getAdmino(admin);

            //to check whether admin tu ada ke tak
            //if admin tak wujud, baru dia adddddddddddd
            if(!admin.isValid()){ 
                try {             
                    dao.addAdmin(admin);
                } catch (NoSuchAlgorithmException ex) {
                   ex.printStackTrace();
                }
                request.setAttribute("successa", "<script>alert('Successfully Registered! Please log in here')</script>");
                RequestDispatcher view = request.getRequestDispatcher("add-admin.jsp");
                view.forward(request, response);
            }
            else{ //kalau tak, dia update profile
                request.setAttribute("errora", "<script>alert('This account details already exists! Please log in here')</script>");
                RequestDispatcher view = request.getRequestDispatcher("add-admin.jsp");
                view.forward(request, response);
                System.out.println("Account Already Exists");  
                }
    }
    }

