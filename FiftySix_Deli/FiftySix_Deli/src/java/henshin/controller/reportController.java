package henshin.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
        
import henshin.dao.reportDAO;
import henshin.model.reportBean;
/**
 *
 * @author user
 */

@WebServlet("/reportController")
public class reportController extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    
    private static final String VIEW_REPORT = "report.jsp";
    
    private final reportDAO daoReport;
    String forward="";
    
    public reportController() {
        super();
        daoReport = new reportDAO();
    }	

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        String action = request.getParameter("action");
            if (action.equalsIgnoreCase("listReport")) {
		forward = VIEW_REPORT;
                request.setAttribute("report", daoReport.getAllReport());
            } 
            RequestDispatcher view = request.getRequestDispatcher(forward);
            view.forward(request, response);
    }
}