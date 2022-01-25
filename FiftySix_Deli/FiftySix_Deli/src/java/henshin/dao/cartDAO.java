/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package henshin.dao;

import henshin.connection.ConnectionManager;
import henshin.model.cartBean;
import henshin.model.menuBean;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.NoSuchAlgorithmException;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

/**
 *
 * @author Asus
 */
public class cartDAO {
    static Connection currentCon = null;
    static ResultSet rs = null; 
    static PreparedStatement ps = null;
    static Statement stmt = null;
    //field ada dalam table
    static int menuID, custID, cartID, qty;
    static String email;
    
    
    public cartBean getOneCart(int menuID, int custID){
        //SQL command
        cartBean carts = new cartBean();
        String searchQuery = "SELECT * FROM MENU JOIN CARTS USING (CART_ID) JOIN CUSTOMERS USING (CUST_ID)";
        
        try{
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            ResultSet rs = stmt.executeQuery(searchQuery);
            
            while(rs.next()){
                cartBean cart = new cartBean();
                cart.setMenuID(rs.getInt("menu_id"));
                cart.setCustID(rs.getInt("cust_id"));
                cart.setCartID(rs.getInt("cart_id"));
                cart.setQty(rs.getInt("quantity"));   
                cart.setMenuName(rs.getString("MENU_NAME"));
                cart.setMenuPrice(rs.getFloat("MENU_PRICE"));
                cart.setMenuDesc(rs.getString("MENU_DESCRIPTION"));
                cart.setMenuQuantity(rs.getInt("MENU_QUANTITY"));
                cart.setFilename(rs.getString("MENU_IMAGE"));
                cart.setMenuCat(rs.getInt("CATEGORY_ID"));
                cart.setCustName(rs.getString("cust_name"));
                cart.setEmail(rs.getString("email"));
                cart.setRegDate(rs.getDate("reg_date"));
                cart.setPhoneNo(rs.getString("phone_no"));
                cart.setDeliveryAddress(rs.getString("delivery_address"));            
                //carts.add(cart);
            }
        }
        catch(SQLException ex){ 
            System.out.println(ex); 
        }
        
        return carts;
    }
    
    
    public List<cartBean> getAllCart(String email) throws IOException{
        //SQL command
        List<cartBean> carts = new ArrayList<cartBean>();
        String searchQuery = "SELECT * FROM CARTS JOIN MENU USING (MENU_ID) WHERE CUST_EMAIL = '" + email +"'";
        
        try{
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            ResultSet rs = stmt.executeQuery(searchQuery);
            
            while(rs.next()){
                cartBean cart = new cartBean();
                cart.setMenuName(rs.getString("menu_name"));
                cart.setFilename(rs.getString("menu_image"));
                cart.setMenuPrice(rs.getInt("menu_price"));
                cart.setCartID(rs.getInt("cart_id"));
                cart.setQty(rs.getInt("quantity"));    
                
                Blob blob = rs.getBlob("IMAGE");
                
                InputStream inputStream = blob.getBinaryStream();
                ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                byte[] buffer = new byte[4096];
                int bytesRead = -1;
                 
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);                  
                }
                 
                byte[] imageBytes = outputStream.toByteArray();
                String base64Image = Base64.getEncoder().encodeToString(imageBytes);

                inputStream.close();
                outputStream.close();
                
                cart.setBase64Image(base64Image);
                carts.add(cart);
            }
        }
        catch(SQLException ex){ 
            System.out.println(ex); 
        }
        
        return carts;
    }
    
    public void addCart(cartBean bean, int ID) throws NoSuchAlgorithmException{
         email = bean.getEmail();
         menuID = bean.getMenuID();
         qty = bean.getQty();
         
         System.out.print(ID);
 
         try{
             currentCon = ConnectionManager.getConnection();
             ps = currentCon.prepareStatement("INSERT INTO CARTS (CUST_ID, CUST_EMAIL, MENU_ID, QUANTITY) VALUES (?,?,?,?)");
             //corresponds with the SQL statement^
             
             ps.setInt(1, ID);
             ps.setString(2, email);
             ps.setInt(3, menuID);
             ps.setInt(4, qty);
             
             ps.executeUpdate();
         }
         catch(SQLException ex){ 
            System.out.println("An error occurred!" + ex); 
        }
         finally{
             if(ps != null){
                 try{
                     ps.close();
                 }catch(SQLException e){}
                 ps = null;
             }
             if(currentCon != null){
                 try{
                     currentCon.close();
                 }catch(SQLException e){}
                 currentCon = null;
             }
         }
    }
    
     public List<menuBean> getAllMenu() throws IOException {
         List<menuBean> menu = new ArrayList<menuBean>();
         String m = "SELECT * FROM MENU";
         try{
             currentCon = ConnectionManager.getConnection();
             stmt = currentCon.createStatement();
             ResultSet rs = stmt.executeQuery(m);
             
             while(rs.next()){
                menuBean bean = new menuBean();

                bean.setMenuID(rs.getInt("MENU_ID")); 
                bean.setMenuName(rs.getString("MENU_NAME"));
                bean.setMenuPrice(rs.getFloat("MENU_PRICE"));
                bean.setMenuDesc(rs.getString("MENU_DESCRIPTION"));
                bean.setMenuQuan(rs.getInt("MENU_QUANTITY"));
                bean.setFileName(rs.getString("MENU_IMAGE"));
                bean.setMenuCat(rs.getInt("CATEGORY_ID"));               

                Blob blob = rs.getBlob("IMAGE");
                
                InputStream inputStream = blob.getBinaryStream();
                ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                byte[] buffer = new byte[4096];
                int bytesRead = -1;
                 
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);                  
                }
                 
                byte[] imageBytes = outputStream.toByteArray();
                String base64Image = Base64.getEncoder().encodeToString(imageBytes);

                inputStream.close();
                outputStream.close();
                
                
                menu.add(bean);
             }
         } catch (SQLException e){
             e.printStackTrace();
         }
         return menu;
    }
     
    public void deleteCart(int cart_ID){
        
        try{
            currentCon = ConnectionManager.getConnection();
            ps = currentCon.prepareStatement("DELETE FROM CARTS WHERE cart_ID = ?");
            ps.setInt(1, cart_ID);
            ps.executeUpdate();
        }
        catch(SQLException ex){ 
            System.out.println(ex); 
        }
    }
}
