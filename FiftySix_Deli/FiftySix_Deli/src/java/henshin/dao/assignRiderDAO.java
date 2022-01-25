package henshin.dao;

/**
 *
 * @author Aina Syazana
 */
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.sql.Date;
//import java.security.MessageDigest;
import henshin.model.assignRiderBean;
import henshin.model.orderBean;
import henshin.connection.ConnectionManager;
import java.security.NoSuchAlgorithmException;


public class assignRiderDAO {
    static Connection currentCon = null;
    static ResultSet rs = null; 
    static PreparedStatement ps = null;
    static Statement stmt = null;
    //field ada dalam table
    static int riderID;
    static String riderName;
    static String identificationNo;
    static String riderPhone;
    static Date regDate;
    static String status;
    static String plateNo;
    static String email;
    static String password;
    static String cust_name;
    static String menuprice;
    static String deliverycharges;
    static String deliveryaddress;
    static String menuname;
    static Date order_time;
    static Date complete_time;
    static int menu_id;
    static int statusID;
    static String phone_no;
    static int rider_id;
    static int custID;
    static int adminID;
    static int orderid;
    
    public  assignRiderBean getRider(int rider_id) throws SQLException{
        
        
        //SQL command
        String searchQuery = "SELECT * FROM RIDER WHERE RIDER_ID ='" + riderID + "'";
        
         assignRiderBean rider = new assignRiderBean();
        //SQL command
        try{
            currentCon = ConnectionManager.getConnection();
            ps = currentCon.prepareStatement("SELECT * FROM ORDERS WHERE ORDER_ID =?");
           
            ps.setInt(1,rider_id);
            ResultSet rs =ps.executeQuery();
            if(rs.next()){
                rider.setRiderID(rs.getInt("rider_id"));
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
        return rider;
    }

    public List<assignRiderBean> getAllRider(){
        //SQL command
        List<assignRiderBean> riders = new ArrayList<assignRiderBean>();
        String searchQuery = "SELECT * FROM RIDER";
        
        try{
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            ResultSet rs = stmt.executeQuery(searchQuery);
            
            while(rs.next()){
                assignRiderBean rider = new assignRiderBean();
                rider.setRiderID(rs.getInt("rider_id"));
                rider.setRiderName(rs.getString("rider_name"));
                rider.setIdentificationNo(rs.getString("rider_ic"));
                rider.setRiderPhone(rs.getString("rider_phone"));
                rider.setRegDate(rs.getDate("reg_date"));
                rider.setStatus(rs.getString("status"));
                rider.setPlateNo(rs.getString("plate_no")); 
                riders.add(rider);
            }
        }
        catch(SQLException ex){ 
            System.out.println(ex); 
        }
        
        return riders;
    }
    
     public orderBean getOrderById(int order_id) throws SQLException{
        
        orderBean order = new orderBean();
        //SQL command
        try{
            currentCon = ConnectionManager.getConnection();
            ps = currentCon.prepareStatement("SELECT * FROM ORDERS WHERE ORDER_ID =?");
           
            ps.setInt(1,order_id);
            ResultSet rs =ps.executeQuery();
            if(rs.next()){
                order.setOrderid(rs.getInt("order_id"));
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
        return order;
    }
     public static orderBean getOrder(orderBean bean){
        orderid = bean.getOrderid();
        
        //SQL command
        String searchQuery = "SELECT * FROM ORDERS WHERE ORDER_ID ='" + orderid + "'";
        
        try{
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            rs = stmt.executeQuery(searchQuery);
            boolean more = rs.next();
            
            //rs tu refer to database
            if(more){
                int id = rs.getInt("ORDER_ID");
                bean.setOrderid(id);
                bean.setValid(true);
            }
            else if(!more){
                bean.setValid(false);
            }
        }
        catch(SQLException ex){ 
            System.out.println("Login failed!" + ex); 
        }
       finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                }
                rs = null;
            }

            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                }
                stmt = null;
            }

            if (currentCon != null) {
                try {
                    currentCon.close();
                } catch (SQLException e) {
                }

                currentCon = null;
            }
        }
        return bean;
    }

    public List<orderBean> getPendingOrder(){
    List<orderBean> orders = new ArrayList<orderBean>();
    String searchQuery = "SELECT * FROM ORDER_DETAILS JOIN MENU ON ORDER_DETAILS.MENU_ID = MENU.MENU_ID JOIN ORDERS ON ORDERS.ORDER_ID = ORDER_DETAILS.ORDER_ID LEFT JOIN ORDER_STATUS ON ORDER_STATUS.STATUS_ID = ORDERS.STATUS_ID INNER JOIN CUSTOMERS ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID JOIN ADDRESS ON ADDRESS.ADDRESS_ID = ORDERS.ADDRESS_ID WHERE ORDER_STATUS.STATUS_ID is null";
       
        try{
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            
            ResultSet rs = stmt.executeQuery(searchQuery);
            
            while(rs.next()){
                orderBean order = new orderBean();
                order.setQuantity(rs.getInt("menu_quantity"));
                order.setOrderid(rs.getInt("order_id"));
                order.setStatusID(rs.getInt("status_id"));
                order.setMenuname(rs.getString("menu_name"));
                order.setCust_name(rs.getString("cust_name"));
                order.setStreet(rs.getString("address_line1"));
                order.setCity(rs.getString("city"));
                order.setState(rs.getString("state"));
                order.setPostcode(rs.getString("postcode"));
                order.setMenuprice(rs.getString("menu_price"));
                order.setDeliveryaddress(rs.getString("delivery_address"));
                //order.setDeliverycharges(rs.getString("delivery_charge"));
                order.setPhone_no(rs.getString("phone_no"));
                //order.setComplete_time(rs.getDate("complete_time")); 
                orders.add(order);            
            }
        }
        catch(SQLException ex){ 
            System.out.println(ex); 
        }
        
         return orders;
    }
    
    public void updateOrders(assignRiderBean orders)throws NoSuchAlgorithmException{
        
        orderid = orders.getOrderID();
        rider_id = orders.getRiderID();

        
        String searchQuery = "UPDATE ORDERS SET RIDER_ID = '"+ rider_id + "',STATUS_ID = 1  WHERE  ORDER_ID = '"+ orderid + "'";
        
        try {	
	        currentCon = ConnectionManager.getConnection();
	        stmt = currentCon.createStatement();
	        stmt.executeQuery(searchQuery);
                System.out.println("updated order rider info");
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
        }
    public List<orderBean> getAssignOrder(){
    List<orderBean> assignorder = new ArrayList<orderBean>();
    String searchQuery = "SELECT * FROM ORDER_DETAILS JOIN MENU ON ORDER_DETAILS.MENU_ID = MENU.MENU_ID\n" +
"                         JOIN ORDERS ON ORDER_DETAILS.ORDER_ID = ORDERS.ORDER_ID \n" +
"                         INNER JOIN CUSTOMERS USING (CUST_ID)\n" +
"                         INNER JOIN ORDER_STATUS USING (STATUS_ID)\n" +
"                         INNER JOIN RIDER USING (RIDER_ID)\n" +
"                         JOIN ADDRESS ON ADDRESS.ADDRESS_ID = ORDERS.ADDRESS_ID\n" +
"                         WHERE STATUS_ID = 1 OR STATUS_ID = 2 OR STATUS_ID = 3";
        
        try{
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            ResultSet rs = stmt.executeQuery(searchQuery);
            
            while(rs.next()){
                orderBean order = new orderBean();
                order.setOrderid(rs.getInt("order_id"));
                order.setCustID(rs.getInt("cust_id"));
                order.setRider_id(rs.getInt("rider_id"));
                order.setRider_name(rs.getString("rider_name"));
                order.setMenuname(rs.getString("menu_name"));
                order.setCust_name(rs.getString("cust_name"));
                order.setMenuprice(rs.getString("menu_price"));
                order.setStreet(rs.getString("address_line1"));
                order.setCity(rs.getString("city"));
                order.setState(rs.getString("state"));
                order.setPostcode(rs.getString("postcode"));
                order.setOrder_status(rs.getString("status"));
                order.setDeliveryaddress(rs.getString("delivery_address"));
                //order.setDeliverycharges(rs.getString("delivery_charge"));
                order.setPhone_no(rs.getString("phone_no"));
                //order.setComplete_time(rs.getDate("complete_time")); 
                assignorder.add(order);            
            }
        }
        catch(SQLException ex){ 
            System.out.println(ex); 
        }
        
         return assignorder;
    }
}