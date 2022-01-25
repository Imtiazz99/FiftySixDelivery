/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package henshin.controller;

import henshin.connection.ConnectionManager;
import henshin.dao.RiderLoginDao;
import henshin.model.RiderLoginBean;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Tiaz
 */

@WebServlet("/a-rider/RiderLoginServlet")
public class RiderLoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RiderLoginServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            
            String logemail = request.getParameter("rider_email");
            String logpass = request.getParameter("rider_password");
            
            RiderLoginDao db =  new RiderLoginDao(ConnectionManager.getConnection());
            RiderLoginBean rider = db.logRider(logemail, logpass);
            
            if(rider!=null){
                HttpSession session = request.getSession();
                session.setAttribute("logRider", rider);
                request.setAttribute("success", "<script>alert('Successfully Registered! Please log in here')</script>");
                response.sendRedirect("index.jsp");
                session.setAttribute("rider_email",logemail);
                session.setAttribute("rider_id",rider.getRiderID());
                
            }else  
            {
                    request.setAttribute("errMessage", "Rider does not exist! Please try again.");
                    RequestDispatcher requestDispatcher = request.getRequestDispatcher("riderlogin.jsp");
                    requestDispatcher.forward(request, response);
                    System.out.println("Rider Not Found");  
            }
            
            out.println("<h1>Servlet RiderLoginServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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

}
