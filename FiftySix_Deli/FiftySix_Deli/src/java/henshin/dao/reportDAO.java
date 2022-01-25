package henshin.dao;
/**
 *
 * @author syam
 */
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.sql.Date;
import henshin.model.reportBean;
import henshin.connection.ConnectionManager;
public class reportDAO {
    static Connection currentCon = null;
    static ResultSet rs = null; 
    static PreparedStatement ps = null;
    static Statement stmt = null;
    //field ada dalam table
    static int paymentID;
    static Date paymentTime;
    static float paymentTotal;
    static float paymentDelivery;
  
    public List<reportBean> getAllReport(){
        //SQL command
        List<reportBean> report = new ArrayList<>();
        String searchQuery = "SELECT * FROM PAYMENT";
        
        try{
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            ResultSet rs = stmt.executeQuery(searchQuery);
            
            while(rs.next()){
                reportBean reports = new reportBean();
                reports.setPaymentid(rs.getInt("payment_id"));
                reports.setPaymenttime(rs.getDate("payment_time"));
                reports.setPaymenttotal(rs.getFloat("payment_total"));
                reports.setPaymentdelivery(rs.getFloat("payment_delivery"));
                report.add(reports);
            }
        }
        catch(SQLException ex){ 
            System.out.println(ex); 
        }
        
        return report;
    }
}
