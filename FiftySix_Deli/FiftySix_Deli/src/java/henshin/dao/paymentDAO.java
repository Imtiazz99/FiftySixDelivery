/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package henshin.dao;

import henshin.connection.ConnectionManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import henshin.model.paymentBean;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.Timestamp;
import java.util.Date;

/**
 *
 * @author Amirah
 */
public class paymentDAO {
    static Connection currentCon = null;
    static ResultSet rs = null; 
    static PreparedStatement ps = null;
    static PreparedStatement ps1 = null;
    static Statement stmt = null;

    
    private static java.sql.Timestamp getCurrentTimeStamp() {
        java.util.Date today = new java.util.Date();
        return new java.sql.Timestamp(today.getTime());
    }
    
    public void insertPaymentDetails1(paymentBean bean, int cust_id) throws NoSuchAlgorithmException{
         System.out.println("CustID=" + cust_id);
         
         try{
             currentCon = ConnectionManager.getConnection();
             
             ps = currentCon.prepareStatement("INSERT INTO ORDERS (CUST_ID) SELECT DISTINCT CUST_ID FROM CARTS WHERE CUST_ID ='"+cust_id+"'");
             ps.executeUpdate();
         }
         catch(Exception ex){ 
            System.out.println("An error occurred!" + ex); 
        }
         finally{
             if(ps != null){
                 try{
                     ps.close();
                 }catch(Exception e){}
                 ps = null;
             }
             if(currentCon != null){
                 try{
                     currentCon.close();
                 }catch(Exception e){}
                 currentCon = null;
             }
         }
    }
    
    public void insertPaymentDetails2(int cust_id, int order_id) throws NoSuchAlgorithmException{
         //int cust_id = bean.getCust_id();
         
         try{
             currentCon = ConnectionManager.getConnection();
             
             ps = currentCon.prepareStatement("INSERT INTO ORDER_DETAILS (ORDER_ID, MENU_ID, QUANTITY) SELECT ORDER_ID, MENU_ID, QUANTITY FROM CARTS JOIN ORDERS USING (CUST_ID) WHERE CUST_ID="+cust_id+" AND ORDER_ID="+order_id+"");
             ps.executeUpdate();
         }
         catch(Exception ex){ 
            System.out.println("An error occurred!" + ex); 
        }
         finally{
             if(ps != null){
                 try{
                     ps.close();
                 }catch(Exception e){}
                 ps = null;
             }
             if(currentCon != null){
                 try{
                     currentCon.close();
                 }catch(Exception e){}
                 currentCon = null;
             }
         }
    }

    public paymentBean getOrderById(int cust_id) {
        paymentBean payment = new paymentBean();
        
        try{
            currentCon = ConnectionManager.getConnection();
            ps = currentCon.prepareStatement("SELECT ORDER_ID FROM ORDERS WHERE CUST_ID='"+cust_id+"'");
            
            ResultSet rs = ps.executeQuery();
            
            if(rs.next()){
                payment.setOrder_id(rs.getInt("order_id"));   
                int order_id = payment.getOrder_id();
                System.out.println(order_id);
            }
            
        } catch (SQLException e){
            e.printStackTrace();
        }
        return payment;
    }
    
    public int getCurrentID(int cust_id){
        int x=0;
        try{
            currentCon = ConnectionManager.getConnection();
            String query = ("SELECT MAX(ORDER_ID) FROM ORDERS WHERE CUST_ID='"+cust_id+"'");
            stmt = currentCon.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            
            if(rs.next()){
                x = rs.getInt(1);
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        return x;
    }
    
    
    
    public List<paymentBean> getPaymentDetails(int cust_id, int order_id) throws IOException{

        List<paymentBean> pays = new ArrayList<paymentBean>();
        
        try{
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            String searchQuery = "SELECT * FROM ORDER_DETAILS \n" +
            "JOIN ORDERS ON ORDER_DETAILS.ORDER_ID = ORDERS.ORDER_ID \n" +
            "JOIN MENU ON ORDER_DETAILS.MENU_ID = MENU.MENU_ID \n" +
            "JOIN CUSTOMERS ON ORDERS.CUST_ID = CUSTOMERS.CUST_ID  \n" +
            "WHERE ORDERS.CUST_ID = '"+cust_id+"' AND ORDERS.ORDER_ID = '"+order_id+"'";
            ResultSet rs = stmt.executeQuery(searchQuery);
            
            while(rs.next()){
                paymentBean pay = new paymentBean();
                pay.setCustName(rs.getString("cust_name"));
                pay.setEmail(rs.getString("email"));
                pay.setMenuName(rs.getString("MENU_NAME"));
                pay.setMenuPrice(rs.getFloat("MENU_PRICE"));
                pay.setMenuDesc(rs.getString("MENU_DESCRIPTION"));
                pay.setMenuQuantity(rs.getInt("MENU_QUANTITY"));
                pay.setFilename(rs.getString("MENU_IMAGE"));
                pay.setMenuCat(rs.getInt("CATEGORY_ID"));
                pay.setQty(rs.getInt("quantity"));
                pay.setOrder_id(rs.getInt("order_id"));
                    
                pays.add(pay);
            }
        }
            catch(SQLException ex){ 
            System.out.println(ex); 
        }
        
        return pays;
    }
    
    public List<paymentBean> customerDetails(int cust_id) throws IOException{
        
        List<paymentBean> payments = new ArrayList<paymentBean>();
        
        try{
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            String searchQuery = "SELECT * FROM CUSTOMERS JOIN ADDRESS USING (CUST_ID) WHERE CUST_ID='"+cust_id+"'";
            ResultSet rs = stmt.executeQuery(searchQuery);
            
            while(rs.next()){
                paymentBean pay = new paymentBean();
                pay.setCustName(rs.getString("cust_name"));
                pay.setAddressID(rs.getInt("address_id"));
                pay.setPhoneNo(rs.getString("phone_no"));
                pay.setEmail(rs.getString("email"));
                pay.setAddress_line(rs.getString("address_line1"));
                pay.setCity(rs.getString("city"));
                pay.setState(rs.getString("state"));
                pay.setPostcode(rs.getString("postcode"));
                //pay.setOrder_id(rs.getInt("order_id"));
                    
                payments.add(pay);
            }
        }
            catch(SQLException ex){ 
            System.out.println(ex); 
        }
        
        return payments;
    }
    
      public List<paymentBean> paymentReceipt(int cust_id, int order_id) throws IOException{
        
        List<paymentBean> payments = new ArrayList<paymentBean>();
        
        try{
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            String searchQuery = "SELECT * FROM CUSTOMERS JOIN ORDERS ON CUSTOMERS.CUST_ID = ORDERS.CUST_ID JOIN ORDER_DETAILS ON ORDER_DETAILS.ORDER_ID = ORDERS.ORDER_ID JOIN MENU ON MENU.MENU_ID = ORDER_DETAILS.MENU_ID WHERE CUSTOMERS.CUST_ID = '"+cust_id+"' AND ORDERS.ORDER_ID = '"+order_id+"'";
            ResultSet rs = stmt.executeQuery(searchQuery);
            
            while(rs.next()){
                paymentBean pay = new paymentBean();
                pay.setMenuName(rs.getString("MENU_NAME"));
                pay.setMenuPrice(rs.getDouble("MENU_PRICE"));
                payments.add(pay);
            }
        }
            catch(SQLException ex){ 
            System.out.println(ex); 
        }
        
        return payments;
    }
 
    public void clearCart(int cust_id){
        
        try{
            currentCon = ConnectionManager.getConnection();
            ps = currentCon.prepareStatement("DELETE FROM CARTS WHERE CUST_ID = ?");
            ps.setInt(1, cust_id);
            ps.executeUpdate();
        }
        catch(SQLException ex){ 
            System.out.println(ex); 
        }
    }
    
    public void makePayment(paymentBean bean, int order_id) throws NoSuchAlgorithmException{
         int method_id = bean.getMethod_id();
         int address_id = bean.getAddressID();
         double total_payment = bean.getTotal_payment();
         double delivery_charge = bean.getDelivery_charge();
         System.out.println(order_id);
         System.out.println("siniii:" + address_id);
         
         try{
             currentCon = ConnectionManager.getConnection();
             
             ps = currentCon.prepareStatement("INSERT INTO PAYMENT (METHOD_ID, PAYMENT_TIME, TOTAL_PAYMENT, DELIVERY_CHARGE, ORDER_ID) VALUES (?,?,?,?,"+order_id+")");
             //corresponds with the SQL statement^
             ps.setInt(1, method_id);
             ps.setTimestamp(2,getCurrentTimeStamp());
             ps.setDouble(3, total_payment);
             ps.setDouble(4, delivery_charge);
             ps.executeUpdate();
             
             ps = currentCon.prepareStatement("UPDATE ORDERS SET ADDRESS_ID = ? WHERE ORDER_ID = '"+order_id+"'");
             //corresponds with the SQL statement^
             ps.setInt(1, address_id);
             ps.executeUpdate();
             
             
         }
         catch(Exception ex){ 
            System.out.println("An error occurred!" + ex); 
        }
         finally{
             if(ps != null){
                 try{
                     ps.close();
                 }catch(Exception e){}
                 ps = null;
             }
             if(currentCon != null){
                 try{
                     currentCon.close();
                 }catch(Exception e){}
                 currentCon = null;
             }
         }
         
         
         
         
    }
}
