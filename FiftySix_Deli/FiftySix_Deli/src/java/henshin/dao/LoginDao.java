package henshin.dao; 

import henshin.model.LoginBean;
import java.sql.*;

public class LoginDao {
    Connection con ;

    public LoginDao(Connection con) {
        this.con = con;
    }

   //user login
    public LoginBean logUser(String email, String pass){
        LoginBean usr=null;
        try{
            String query ="select * from CUSTOMERS where EMAIL=? and CUST_PASSWORD=?";
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, pass);

            ResultSet rs = pst.executeQuery();

            if(rs.next()){
                usr = new LoginBean();
                usr.setCustID(rs.getInt("CUST_ID"));
                usr.setEmail(rs.getString("email"));
                usr.setPassword(rs.getString("password"));

            }

        }catch(Exception e){
            e.printStackTrace();
        }
        return usr;
    }
}