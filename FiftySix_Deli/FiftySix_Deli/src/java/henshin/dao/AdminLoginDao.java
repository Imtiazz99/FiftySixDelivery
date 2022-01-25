package henshin.dao;

import henshin.model.AdminLoginBean;
import java.sql.*;

public class AdminLoginDao {
    Connection con ;

    public AdminLoginDao(Connection con) {
        this.con = con;
    }
    
   //Admin login
    public AdminLoginBean logAdmin(String email, String pass){
        AdminLoginBean usr=null;
        try{
            String query ="select * from ADMINS where EMAIL=? and ADMIN_PASSWORD=?";
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, pass);
            
            ResultSet rs = pst.executeQuery();
            
            if(rs.next()){
                usr = new AdminLoginBean();
                usr.setEmail(rs.getString("email"));
                usr.setPassword(rs.getString("password"));
                
            }
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return usr;
    }
}

