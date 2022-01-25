package henshin.dao;

/**
 *
 * @author Asus
 */
//import java.util.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
//import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import henshin.model.adminBean;
import henshin.connection.ConnectionManager;

public class adminDAO {
    static Connection currentCon = null;
    static ResultSet rs = null; 
    static PreparedStatement ps = null;
    static Statement stmt = null;
    //field ada dalam table
    static int adminID;
    static String adminName;
    static String email;
    static String password;
    static String phoneNo;
    
    //methods yang guna dalam controller, the implementations letak kat sini
    //sebab diaaaaaa check an object 
    public static adminBean getAdmin(adminBean bean){
        adminID = bean.getAdminID();
        
        //SQL command
        String searchQuery = "SELECT * FROM ADMINS WHERE ADMIN_ID ='" + adminID + "'";
        
        try{
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            rs = stmt.executeQuery(searchQuery);
            boolean more = rs.next();
            
            //rs tu refer to database
            if(more){
                int id = rs.getInt("ADMIN_ID");
                bean.setAdminID(id);
                bean.setValid(true);
            }
            else if(!more){
                bean.setValid(false);
            }
        }
        catch(Exception ex){ 
            System.out.println("Login failed!" + ex); 
        }
       finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                }
                rs = null;
            }

            if (stmt != null) {
                try {
                    stmt.close();
                } catch (Exception e) {
                }
                stmt = null;
            }

            if (currentCon != null) {
                try {
                    currentCon.close();
                } catch (Exception e) {
                }

                currentCon = null;
            }
        }

        return bean;
    }
      public static adminBean getAdmino(adminBean bean){
        email = bean.getEmail();

        //SQL command
        String searchQuery = "SELECT * FROM ADMINS WHERE EMAIL ='" + email + "'";

        try{
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            rs = stmt.executeQuery(searchQuery);
            boolean more = rs.next();

            //rs tu refer to database
            if(more){
                String id = rs.getString("EMAIL");
                bean.setEmail(id);
                bean.setValid(true);
            }
            else if(!more){
                bean.setValid(false);
            }
        }
        catch(Exception ex){ 
            System.out.println("Login failed!" + ex); 
        }
       finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                }
                rs = null;
            }

            if (stmt != null) {
                try {
                    stmt.close();
                } catch (Exception e) {
                }
                stmt = null;
            }

            if (currentCon != null) {
                try {
                    currentCon.close();
                } catch (Exception e) {
                }

                currentCon = null;
            }
        }

        return bean;
    }
    public void addAdmin(adminBean bean) throws NoSuchAlgorithmException{
         adminName = bean.getAdminName();
         email = bean.getEmail();
         password = bean.getPassword();
         phoneNo = bean.getPhoneNo();
         
         try{
             currentCon = ConnectionManager.getConnection();
             
             ps = currentCon.prepareStatement("INSERT INTO ADMINS ( ADMIN_PHONE , ADMIN_NAME ,ADMIN_PASSWORD , EMAIL) VALUES (?,?,?,?)");
             //corresponds with the SQL statement^
             ps.setString(1, phoneNo);
             ps.setString(2, adminName);
             ps.setString(3, password);
             ps.setString(4, email);
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
    
    public List<adminBean> getAllAdmin(){
        //SQL command
        List<adminBean> admins = new ArrayList<adminBean>();
        String searchQuery = "SELECT * FROM ADMINS";
        
        try{
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            ResultSet rs = stmt.executeQuery(searchQuery);
            
            while(rs.next()){
                adminBean admin = new adminBean();
                admin.setAdminID(rs.getInt("admin_ID"));
                admin.setAdminName(rs.getString("admin_name"));
                admin.setEmail(rs.getString("email"));
                admin.setPhoneNo(rs.getString("admin_phone"));
                admins.add(admin);
            }
        }
        catch(SQLException ex){ 
            System.out.println(ex); 
        }
        return admins;
    }
    
    public void deleteAdmin(int admin_ID){
        
        try{
            currentCon = ConnectionManager.getConnection();
            ps = currentCon.prepareStatement("DELETE FROM ADMINS WHERE admin_ID = ?");
            ps.setInt(1, admin_ID);
            ps.executeUpdate();
        }
        catch(SQLException ex){ 
            System.out.println(ex); 
        }
    }
    
}
