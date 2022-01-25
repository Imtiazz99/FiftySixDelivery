/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package henshin.dao;

/**
 *
 * @author TK
 */
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import henshin.connection.ConnectionManager;
import henshin.model.orderBean;
import java.sql.Date;


public class orderCustDAO {
    static Connection currentCon = null;
    static ResultSet rs = null; 
    static PreparedStatement ps=null;
    static Statement stmt=null;
    
    static int orderid,custID,statusID;
    static int phoneno,quantity;
    static String cust_name;
    static String deliveryaddress;
    static String menuname;
    static Date order_time;
    static Date complete_time;
    static Date delivery_time;
    static String order_status;
    
    
   public List<orderBean> getAllOrderByCust(int ID){
        List<orderBean> order = new ArrayList<orderBean>();
        try{
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            String q = "SELECT * FROM ORDERS \n" +
                        "JOIN CUSTOMERS USING (CUST_ID) \n" +
                        "JOIN ORDER_STATUS USING (STATUS_ID)  \n" +
                        "JOIN ORDER_DETAILS USING (ORDER_ID) \n" +
                        "JOIN MENU USING (MENU_ID) \n" +
                        "JOIN RIDER USING (RIDER_ID)\n" +
                        "JOIN PAYMENT USING (ORDER_ID)\n" +
                        "JOIN ADDRESS USING (ADDRESS_ID)\n" +
                        "WHERE RIDER_ID = '" + ID + "'";
            ResultSet rs = stmt.executeQuery(q);
            
            while(rs.next()){
                orderBean orders = new orderBean();
                orders.setOrderid(rs.getInt("order_id"));
                orders.setCust_name(rs.getString("cust_name"));
                orders.setOrder_time(rs.getDate("order_time"));
                orders.setDelivery_time(rs.getDate("delivery_time"));
                orders.setComplete_time(rs.getDate("complete_time"));
                orders.setMenuname(rs.getString("menu_name"));
                orders.setDeliveryaddress(rs.getString("delivery_address"));
                orders.setQuantity(rs.getInt("quantity"));
                orders.setPhone_no(rs.getString("phone_no"));
                orders.setStreet(rs.getString("address_line1"));
                orders.setCity(rs.getString("city"));
                orders.setState(rs.getString("state"));
                orders.setPostcode(rs.getString("postcode"));
                orders.setTotPayment(rs.getFloat("total_payment"));
                orders.setStatusID(rs.getInt("status_id"));
                order.add(orders);
            }
        } catch (SQLException e){
            e.printStackTrace();
        } 
        return order;
    }//close List
 public void updateOrderTime(orderBean orders) throws SQLException{
        orderid = orders.getOrderid();
        order_time = (Date) orders.getOrder_time();
        //delivTime = orders.getDelivTime();
        //compTime = orders.getCompTime();
        //ps.setTimestamp(2,getCurrentTimeStamp());
        
        String searchQuery = "UPDATE ORDERS SET ORDER_TIME = CURRENT_TIMESTAMP WHERE ORDER_ID='"+orderid+"'";

        try {	
	        currentCon = ConnectionManager.getConnection();
	        stmt = currentCon.createStatement();
	        stmt.executeUpdate(searchQuery);
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
    }//close update Order

 
  public void updatePreparing(orderBean orders, int ID){
        
        String searchQuery = "UPDATE ORDERS SET STATUS_ID= '2' WHERE ORDER_ID='"+ ID +"'";

        try {	
	        currentCon = ConnectionManager.getConnection();
	        stmt = currentCon.createStatement();
	        stmt.executeUpdate(searchQuery);
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
    }//update to preparing status for order status
    
    public void updateDeliveryTime(orderBean orders, int ID){
        
        //orderTime = orders.getOrderTime();
        delivery_time = (Date) orders.getDelivery_time();
        //compTime = orders.getCompTime();
        
        String searchQuery = "UPDATE ORDERS SET DELIVERY_TIME = CURRENT_TIMESTAMP, STATUS_ID= '3' WHERE ORDER_ID='"+ ID +"'";

        try {	
	        currentCon = ConnectionManager.getConnection();
	        stmt = currentCon.createStatement();
	        stmt.executeUpdate(searchQuery);
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
    }//close update Order
    
    public void updateCompleteTime(orderBean orders, int ID){
        //orderTime = orders.getOrderTime();
        //delivTime = orders.getDelivTime();
        complete_time = (Date) orders.getComplete_time();
        
        String searchQuery = "UPDATE ORDERS SET COMPLETE_TIME = CURRENT_TIMESTAMP, STATUS_ID= '4' WHERE ORDER_ID='"+ ID +"'";

        try {	
	        currentCon = ConnectionManager.getConnection();
	        stmt = currentCon.createStatement();
	        stmt.executeUpdate(searchQuery);
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
    }//close update Order
    
   public List<orderBean> getOrderById(int id){
        List<orderBean> order = new ArrayList<orderBean>(); 
        try{
            currentCon = ConnectionManager.getConnection();
            ps=currentCon.prepareStatement("SELECT * FROM ORDERS JOIN ORDER_STATUS ON ORDERS.STATUS_ID = ORDER_STATUS.STATUS_ID WHERE ORDER_ID=?");
            
            ps.setInt(1,id);//Int id
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                        orderBean orders = new orderBean();
	        	orders.setOrderid(rs.getInt("ORDER_ID"));
	        	orders.setOrder_time(rs.getDate("ORDER_TIME"));
	        	orders.setDelivery_time(rs.getDate("DELIVERY_TIME"));
                        orders.setComplete_time(rs.getDate("COMPLETE_TIME"));
                        orders.setOrder_status(rs.getString("STATUS"));
                        order.add(orders);
	        }
        }catch (SQLException e){
            e.printStackTrace();
        }  
        return order;
        
    }
   
   public List<orderBean> getAllOrderCust(int custID){
        List<orderBean> order = new ArrayList<orderBean>();        
        try{
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            
            String q = "SELECT * FROM ORDERS JOIN CUSTOMERS ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID JOIN order_details ON order_details.order_id = orders.order_id JOIN MENU ON menu.menu_id=order_details.menu_id JOIN payment on payment.order_id = orders.order_id LEFT JOIN ORDER_STATUS USING (STATUS_ID) WHERE ORDERS.CUST_ID = '" + custID + "'";
            ResultSet rs = stmt.executeQuery(q);
            
            while (rs.next()){
                orderBean orders = new orderBean();
                orders.setOrderid(rs.getInt("ORDER_ID"));
                orders.setMenuname(rs.getString("MENU_NAME"));
                orders.setQuantity(rs.getInt("QUANTITY"));
                orders.setTotPayment(rs.getFloat("TOTAL_PAYMENT"));
                orders.setStatusID(rs.getInt("STATUS_ID"));
                orders.setStatus(rs.getString("STATUS"));
                order.add(orders);
            }
        } catch (SQLException e){
            e.printStackTrace();
        } return order;
    }//close class getAllOrderCust
    
    //view order details kat customer
public List<orderBean> getAllOrderCustDetails(int orderID){
        List<orderBean> order = new ArrayList<orderBean>();        
        try{
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            
            String q = "SELECT * FROM CUSTOMERS JOIN ORDERS ON ORDERS.CUST_ID = CUSTOMERS.CUST_ID \n" +
"                        JOIN ORDER_DETAILS ON ORDER_DETAILS.ORDER_ID = ORDERS.ORDER_ID \n" +
"                      JOIN PAYMENT ON PAYMENT.ORDER_ID = ORDERS.ORDER_ID \n" +
"                       JOIN MENU ON MENU.MENU_ID=ORDER_DETAILS.MENU_ID \n" +
"                        JOIN ORDER_STATUS USING (STATUS_ID)\n" +
"                       JOIN PAYMENT_METHOD ON PAYMENT_METHOD.METHOD_ID = PAYMENT.METHOD_ID\n" +
"                      JOIN ADDRESS USING (ADDRESS_ID)\n" +
"                       WHERE ORDER_ID = '"+ orderID +"'";
            ResultSet rs = stmt.executeQuery(q);
            
            while (rs.next()){
                orderBean orders = new orderBean();
                orders.setOrderid(rs.getInt("ORDER_ID"));
                orders.setDeliveryaddress(rs.getString("DELIVERY_ADDRESS"));
                orders.setOrder_time(rs.getDate("ORDER_TIME"));
                orders.setDelivery_time(rs.getDate("DELIVERY_TIME"));
                orders.setComplete_time(rs.getDate("COMPLETE_TIME"));
                orders.setMethodname(rs.getString("METHOD_NAME"));
                orders.setStatusID(rs.getInt("STATUS_ID"));
                orders.setOrder_status(rs.getString("STATUS"));
                orders.setStreet(rs.getString("ADDRESS_LINE1"));
                orders.setCity(rs.getString("CITY"));
                orders.setState(rs.getString("STATE"));
                orders.setPostcode(rs.getString("STATUS_ID"));
                orders.setPayment_time(rs.getDate("PAYMENT_TIME"));
                order.add(orders);
            }
        } catch (SQLException e){
            e.printStackTrace();
        } return order;
    }
 
    public Object updateCompleteTime() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
