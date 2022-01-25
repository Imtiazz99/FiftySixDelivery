/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package henshin.controller;

import java.io.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.*;
import javax.servlet.http.*;
import henshin.dao.menuDAO;
import henshin.model.menuBean;
import java.security.NoSuchAlgorithmException;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import javax.servlet.MultipartConfigElement;
import javax.servlet.http.Part;
import javax.servlet.annotation.MultipartConfig;
import org.apache.tomcat.util.buf.StringUtils;
//import org.springframework.web.multipart.support.MultipartFilter;
@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB
                 maxFileSize=1024*1024*10,      // 10MB
                 maxRequestSize=1024*1024*50)   // 50MB
/**
 *
 * @author User
 */
//@WebServlet(name = "menuController", urlPatterns = {"/menuController"})
public class menuController extends HttpServlet {
    
private static final long serialVersionUID = 1L;

    //admmin
    private static String CREATE = "/a-admin/create-menu.jsp";
    private static String VIEW = "a-admin/manage-menu.jsp";
    private static String VIEWMENU = "a-admin/view-menu.jsp";
    private static String DELETE = "a-admin/manage-menu.jsp";
    private static String EDIT = "a-admin/updateMenu.jsp";
    
    //cust
    private static String VIEWMENUS = "a-customer/menu.jsp";
    private static String VIEWCUPCAKE = "a-customer/cupcake.jsp";
    private static String VIEWDESSERT = "a-customer/dessert.jsp";
    private static String VIEWCOOKIES = "a-customer/cookies.jsp";
    
    private menuDAO dao;
    String forward = "";
    
    public menuController(){
        super();
        dao = new menuDAO();
    }
    
    HttpSession session = null;
    //PrintWritter out;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { 
        
        String action = request.getParameter("action");
        
        if (action.equalsIgnoreCase("listMenu")){
            forward = VIEW;
            request.setAttribute("menu", dao.getAllMenus());
        }
        else if(action.equalsIgnoreCase("deleteMenu")){ 
            int menuID = Integer.parseInt(request.getParameter("menuID"));
            forward = DELETE;
            dao.deleteMenu(menuID);          
            request.setAttribute("menu", dao.getAllMenus());
            request.setAttribute("successr", "<script>alert('Successfully ')</script>");
        }
        else if(action.equalsIgnoreCase("viewMenus")){
            forward = VIEWMENUS;
            request.setAttribute("menu", dao.getAllMenus());
        } 
        else if(action.equalsIgnoreCase("viewCupcake")){
            forward = VIEWCUPCAKE;
            request.setAttribute("menu", dao.getAllMenus());
        } 
        else if(action.equalsIgnoreCase("viewDessert")){
            forward = VIEWDESSERT;
            request.setAttribute("menu", dao.getAllMenus());
        } 
        else if(action.equalsIgnoreCase("viewCookies")){
            forward = VIEWCOOKIES;
            request.setAttribute("menu", dao.getAllMenus());
        }
        else if (action.equalsIgnoreCase("viewMenu")){
            forward = VIEWMENU;
            int menuID = Integer.parseInt(request.getParameter("menuID"));
            menuBean menu = dao.getMenuById(menuID);
            request.setAttribute("menu", menu);
        }
        else if (action.equalsIgnoreCase("updateMenu")){
            int menuID = Integer.parseInt(request.getParameter("menuID"));
            
            menuBean menu = new menuBean();
            menu = dao.getMenuById(menuID);
        
            forward = EDIT;
            request.setAttribute("menu",menu);
        }
        else{
            forward = CREATE;
        }
        RequestDispatcher view = request.getRequestDispatcher(forward);
            view.forward(request, response);
    }
    
    private menuBean repo;
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        menuBean menu = new menuBean();
        
        menu.setMenuName(request.getParameter("menuName"));
        menu.setMenuPrice(Float.parseFloat(request.getParameter("menuPrice")));
        menu.setMenuDesc(request.getParameter("menuDesc"));
        menu.setMenuQuan(Integer.parseInt(request.getParameter("menuQuantity")));
        //menu.setFilePart(request.getPart("menuImage"));

        try{menu.setMenuCat(Integer.parseInt(request.getParameter("menuCat"))); 
        }catch(NumberFormatException e){
            Logger.getLogger(customerController.class.getName()).log(Level.SEVERE, null, e);
        }
        
        /*InputStream inputStream = null; //input stream of the upload file
        
        // obtain the upload file part in this multipart request
        Part filePart = request.getPart("menuImage");
        if (filePart != null){
            //print out some information for debugging
            System.out.println(filePart.getName());
            System.out.println(filePart.getSize());
            System.out.println(filePart.getContentType());
            
            //obtains input stream of the upload file
            inputStream = filePart.getInputStream();   
        }*/
        
        menu = menuDAO.getMenu(menu);
        
        if(action.equalsIgnoreCase("createMenu")){
            /*menu.setMenuName(request.getParameter("menuName"));
            menu.setMenuPrice(Float.parseFloat(request.getParameter("menuPrice")));
            menu.setMenuDesc(request.getParameter("menuDesc"));
            menu.setMenuQuan(Integer.parseInt(request.getParameter("menuQuantity")));
            
            try{
                menu.setMenuCat(Integer.parseInt(request.getParameter("menuCat")));
            }
            catch(NumberFormatException e){
                Logger.getLogger(customerController.class.getName()).log(Level.SEVERE, null, e);
            }*/
            String menuName = request.getParameter("menuName");
            float menuPrice = Float.parseFloat(request.getParameter("menuPrice"));
            String menuDesc = request.getParameter("menuDesc");
            int menuQuan = Integer.parseInt(request.getParameter("menuQuan"));
            int menuCat = Integer.parseInt(request.getParameter("menuCat"));

            InputStream inputStream = null; //input stream of the upload file
        
            // obtain the upload file part in this multipart request
            Part filePart = request.getPart("menuImage");
            if (filePart != null){
                //print out some information for debugging
                System.out.println(filePart.getName());
                System.out.println(filePart.getSize());
                System.out.println(filePart.getContentType());

                //obtains input stream of the upload file
                inputStream = filePart.getInputStream(); 
                
            }
//            ///menu.setFile((InputStream) request.getPart("menuImage"));
            
            menu = new menuBean(menuName,menuPrice,menuDesc,menuQuan,menuCat,inputStream);
            
            forward = CREATE;
            try{
               dao.createMenu(menu); 
            }
            catch (IOException e){
                Logger.getLogger(customerController.class.getName()).log(Level.SEVERE, null, e);
            }
            

            request.setAttribute("successr", "<script>alert('Successfully added!')</script>");
            request.setAttribute("menu", dao.getAllMenu());
            RequestDispatcher view = request.getRequestDispatcher(VIEW);
            view.forward(request, response);
        }
        
        if(action.equalsIgnoreCase("updateMenu")){
            menu.setMenuID(Integer.parseInt(request.getParameter("menuID")));
            menu.setMenuName(request.getParameter("menuName"));
            menu.setMenuDesc(request.getParameter("menuDesc"));
            menu.setMenuQuan(Integer.parseInt(request.getParameter("menuQuantity")));
            
            try{
                menu.setMenuCat(Integer.parseInt(request.getParameter("menuCat")));
            }
            catch(NumberFormatException e){
                Logger.getLogger(customerController.class.getName()).log(Level.SEVERE, null, e);
            }
            
                    
            forward = EDIT;
            try{
                dao.updateMenu(menu);
                
            }catch (NoSuchAlgorithmException e){
                Logger.getLogger(customerController.class.getName()).log(Level.SEVERE, null, e);
            }
            request.setAttribute("successr", "<script>alert('Successfully updated!')</script>");
            request.setAttribute("menu", dao.getAllMenu());
            RequestDispatcher view = request.getRequestDispatcher(VIEW);
            view.forward(request, response);
        }
        
        /*else {
            System.out.println("Menu already exits!");
            dao.updateMenu(menu);
            int menuID = Integer.parseInt(request.getParameter("menuID"));
            //RequestDispatcher view = request.getRequestDispatcher(VIEW);
            request.setAttribute("menu", dao.getMenuById(menuID));
            response.sendRedirect("/FiftySix_Deli/menuController?action=listMenu");
        }*/
    }   
    

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private String extractFileName(Part filePart) {
        String contentDisp = filePart.getHeader("content-disposition");
        String [] items = contentDisp.split(";");
        for (String s: items){
            if (s.trim().startsWith("filename")){
                //return s.substring(s.indexOf("=") + 2, s.length()-1);
                String clientFileName = s.substring(s.indexOf("=") + 2, s.length()-1);
                clientFileName = clientFileName.replace("\\", "/");
                int i = clientFileName.lastIndexOf('/');
                return clientFileName.substring(i+1);
            }
        }
        return "";
    }
}
