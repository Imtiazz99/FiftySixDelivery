/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package henshin.dao;

 
/**
 *
 * @author User
 */

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import henshin.connection.ConnectionManager;
//import static henshin.dao.riderDAO.currentCon;
import henshin.model.menuBean;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.NoSuchAlgorithmException;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import javax.servlet.http.Part;
import java.util.List;
//import net.codejava.fileupload.model.UploadFile;

public class menuDAO {
    
        static Connection currentCon = null;
    static ResultSet rs = null;
    static PreparedStatement ps = null;
    static Statement stmt = null;
    static String menuName, menuDesc;
    static int menuID, menuQuantity, menuCat;
    static float menuPrice;
    static Part filePart;
    //static String fileSaveDir;
    static byte[] data;
    static InputStream file;
    
    public static menuBean getMenu(menuBean bean){
        menuID = bean.getMenuID();
        
        //SQL
        String searchQuery = "SELECT * FROM MENU WHERE MENU_ID ='" + menuID + "'";
        
        try{
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            rs = stmt.executeQuery(searchQuery);
            boolean more = rs.next();
            
            System.out.println(searchQuery);
            
            //if subject exists set the isValid variable to true
            if (more){
                int menuID = rs.getInt("MENU_ID");
                bean.setValid(true);
            }
            else if(!more){
                bean.setValid(false);
            }
        }
        catch (Exception ex){
            System.out.println("Failed: An exception has occured!" + ex);
        }
        
        finally {
            if (rs != null) {
                try{
                    rs.close();
                } catch (Exception e){
                }
                rs = null;
            }
            
            if (stmt != null) {
                try{
                    stmt.close();
                } catch (Exception e){
                }
                stmt = null;
            }
            
            if (currentCon != null) {
                try{
                    currentCon.close();
                } catch (Exception e){
                }
                currentCon = null;
            }  
        }
        return bean;
    }
    
//    public void createMenu(menuBean bean) throws IOException{
//        //menuID = bean.getMenuId();
//        menuName = bean.getMenuName();
//        menuPrice = bean.getMenuPrice();
//        menuDesc = bean.getMenuDesc();
//        menuQuantity = bean.getMenuQuan();
//        filePart = bean.getFilePart();
//        menuCat = bean.getMenuCat();
//        
//        try{
//            currentCon = ConnectionManager.getConnection();
//            //ps =currentCon.prepareStatement("INSERT INTO MENU(MENU_NAME,MENU_PRICE,MENU_DESCRIPTION,MENU_QUANTITY,MENU_IMAGE,CATEGORY_ID,IMAGE)VALUES(?,?,?,?,?,?,?)");
//            ps =currentCon.prepareStatement("INSERT INTO MENU(MENU_NAME,MENU_PRICE,MENU_DESCRIPTION,MENU_QUANTITY,CATEGORY_ID)VALUES(?,?,?,?,?)");
//            ps.setString(1,menuName);
//            ps.setFloat(2,menuPrice); 
//            ps.setString(3, menuDesc);
//            ps.setInt(4, menuQuantity);
//            ps.setInt(5, menuCat);
//            ps.executeUpdate();
//            
//        } catch (Exception ex){
//            System.out.println("An error occured!" + ex);
//        }
//        
//        finally {
//            if (ps != null){
//                try{
//                    ps.close();
//                } catch (Exception e){
//                }
//                ps = null;
//            }
//            
//            if (currentCon != null){
//                try{
//                    currentCon.close();
//                } catch (Exception e){
//                }
//                currentCon = null;
//            }
//        }
//    } 

    public List<menuBean> getAllMenu() {
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
                //bean.setFileName(rs.getString("MENU_IMAGE"));
                menu.add(bean);
             }
         } catch (SQLException e){
             e.printStackTrace();
         }
         return menu;
    }
    
     public List<menuBean> getAllMenus() throws IOException {
         List<menuBean> menu = new ArrayList<menuBean>();
         
         try{
             currentCon = ConnectionManager.getConnection();
             stmt = currentCon.createStatement();
             String m = "SELECT * FROM MENU";
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
                
                bean.setBase64Image(base64Image);
                menu.add(bean);
             }
         } catch (SQLException e){
             e.printStackTrace();
         }
         return menu;
    }
    
    public void deleteMenu(int menuID){
        
        try{
            currentCon = ConnectionManager.getConnection();
            ps = currentCon.prepareStatement("DELETE FROM MENU WHERE MENU_ID = ?");
            ps.setInt(1, menuID);
            ps.executeUpdate();
        }
        catch(SQLException ex){ 
            System.out.println(ex); 
        }
    }

    public menuBean getMenuById(int menuID) {
        menuBean menu = new menuBean();
        try{
            currentCon = ConnectionManager.getConnection();
            ps = currentCon.prepareStatement("SELECT * FROM MENU WHERE MENU_ID ='" + menuID + "'");
            
            //ps.setInt(1, menuID);
            ResultSet rs = ps.executeQuery();
            
            if(rs.next()){
                menu.setMenuName(rs.getString("MENU_NAME"));
                menu.setMenuPrice(rs.getFloat("MENU_PRICE"));
                menu.setMenuQuan(rs.getInt("MENU_QUANTITY"));
                menu.setMenuDesc(rs.getString("MENU_DESCRIPTION"));
                menu.setMenuCat(rs.getInt("CATEGORY_ID"));
            }
        } catch (SQLException e){
            e.printStackTrace();
        }
        return menu;
    }
    
    public menuBean getMenuByName(String menuName) {
        menuBean menu = new menuBean();
        try{
            currentCon = ConnectionManager.getConnection();
            ps = currentCon.prepareStatement("SELECT * FROM MENU WHERE MENU_NAME= '" + menuName +"'");
            
            //ps.setInt(1, menuName.toString());
            ResultSet rs = ps.executeQuery();
            
            if(rs.next()){
                menu.setMenuName(rs.getString("MENU_NAME"));
                menu.setMenuPrice(rs.getFloat("MENU_PRICE"));
                menu.setMenuQuan(rs.getInt("MENU_QUANTITY"));
                menu.setMenuDesc(rs.getString("MENU_DESCRIPTION"));
                menu.setMenuCat(rs.getInt("CATEGORY_ID"));
            }
        } catch (SQLException e){
            e.printStackTrace();
        }
        return menu;
    }
    
    public void updateMenu(menuBean menu) throws NoSuchAlgorithmException {
        
        menuID = menu.getMenuID();
        menuName=menu.getMenuName();
        menuPrice = menu.getMenuPrice();
        menuDesc = menu.getMenuDesc();
        menuQuantity = menu.getMenuQuan();
        menuCat = menu.getMenuCat();
        
        String searchQuery = "UPDATE MENU SET MENU_NAME='" + menuName + "', MENU_PRICE='" + menuPrice + "', MENU_DESCRIPTION='" + menuDesc + "', MENU_QUANTITY='" + menuQuantity + "', CATEGORY_ID='" + menuCat + "' WHERE MENU_ID= '" + menuID + "'";
        //String searchQuery = "UPDATE MENU SET MENU_NAME=?, MENU_PRICE=?, MENU_DESCRIPTION=?, MENU_QUANTITY=?, CATEGORY_ID=? WHERE MENU_ID=?";
        
        try{
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            stmt.executeUpdate(searchQuery);
            
        } catch (SQLException e){
            e.printStackTrace();
        }
    }

    public void createMenu(menuBean bean) throws IOException{
        //menuID = bean.getMenuId();
        menuName = bean.getMenuName();
        menuPrice = bean.getMenuPrice();
        menuDesc = bean.getMenuDesc();
        menuQuantity = bean.getMenuQuan();
        //filePart = bean.getFilePart();
        file = bean.getFile();
        menuCat = bean.getMenuCat();
        
        
        try{
            currentCon = ConnectionManager.getConnection();
            //ps =currentCon.prepareStatement("INSERT INTO MENU(MENU_NAME,MENU_PRICE,MENU_DESCRIPTION,MENU_QUANTITY,MENU_IMAGE,CATEGORY_ID,IMAGE)VALUES(?,?,?,?,?,?,?)");
            ps =currentCon.prepareStatement("INSERT INTO MENU(MENU_NAME,MENU_PRICE,MENU_DESCRIPTION,MENU_QUANTITY,CATEGORY_ID,IMAGE)VALUES(?,?,?,?,?,?)");
            ps.setString(1,menuName);
            ps.setFloat(2,menuPrice); 
            ps.setString(3, menuDesc);
            ps.setInt(4, menuQuantity);
            ps.setInt(5, menuCat);
            //if (file != null){
                ps.setBlob(6,file);
            //}
            ps.executeUpdate();
            
        } catch (Exception ex){
            System.out.println("An error occured!" + ex);
        }
        
        finally {
            if (ps != null){
                try{
                    ps.close();
                } catch (Exception e){
                }
                ps = null;
            }
            
            if (currentCon != null){
                try{
                    currentCon.close();
                } catch (Exception e){
                }
                currentCon = null;
            }
        }
    } 
}
