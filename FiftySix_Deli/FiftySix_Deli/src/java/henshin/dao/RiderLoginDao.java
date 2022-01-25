package henshin.dao;

import henshin.model.RiderLoginBean;
import java.sql.*;

public class RiderLoginDao {
    Connection con ;

    public RiderLoginDao(Connection con) {
        this.con = con;
    }
    
   //Admin login
    public RiderLoginBean logRider(String email, String pass){
        RiderLoginBean usr=null;
        try{
            String query ="select * from RIDER where EMAIL=? and PASSWORD=?";
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, pass);
            
            ResultSet rs = pst.executeQuery();
            
            if(rs.next()){
                usr = new RiderLoginBean();
                usr.setRiderID(rs.getInt("RIDER_ID"));
                usr.setEmail(rs.getString("email"));
                usr.setPassword(rs.getString("password"));
                
            }
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return usr;
    }
}