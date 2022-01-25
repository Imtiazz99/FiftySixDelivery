package henshin.dao;
/**
 *
 * @author Aina Syazana
 */
import java.sql.Timestamp;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

//import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import henshin.model.riderBean;
import henshin.connection.ConnectionManager;
public class riderDAO {
    static Connection currentCon = null;
    static ResultSet rs = null; 
    static PreparedStatement ps = null;
    static Statement stmt = null;
    //field ada dalam table
    static int riderID;
    static String riderName;
    static String identificationNo;
    static String riderPhone;
    static Timestamp regDate;
    static String status;
    static String plateNo;
    static String email;
    static String password;
 
    
    public static riderBean getRider(riderBean bean){
        riderID = bean.getRiderID();
        
        //SQL command
        String searchQuery = "SELECT * FROM RIDER WHERE RIDER_ID ='" + riderID + "'";
        
        try{
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            rs = stmt.executeQuery(searchQuery);
            boolean more = rs.next();
            
            //rs tu refer to database
            if(more){
                int id = rs.getInt("RIDER_ID");
                bean.setRiderID(id);
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
    
 public static riderBean getRidero(riderBean bean){
        email = bean.getEmail();

        //SQL command
        String searchQuery = "SELECT * FROM RIDER WHERE EMAIL ='" + email + "'";

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
private static java.sql.Timestamp getCurrentTimeStamp() {

    java.util.Date today = new java.util.Date();
    return new java.sql.Timestamp(today.getTime());

}
    
    public void addRider(riderBean bean) throws NoSuchAlgorithmException{
         riderName = bean.getRiderName();
         identificationNo = bean.getIdentificationNo();
         riderPhone = bean.getRiderPhone();
         regDate = bean.getRegDate();
         status = "Active";
         plateNo = bean.getPlateNo();
         email = bean.getEmail();
         password = bean.getPassword();
 
         try{
             currentCon = ConnectionManager.getConnection();
             ps = currentCon.prepareStatement("INSERT INTO RIDER (RIDER_NAME, RIDER_IC, RIDER_PHONE, REG_DATE, STATUS, PASSWORD, PLATE_NO, EMAIL) VALUES (?,?,?,?,?,?,?,?)");
             //corresponds with the SQL statement^
             ps.setString(1, riderName);
             ps.setString(2, identificationNo);
             ps.setString(3, riderPhone);
             ps.setTimestamp(4, getCurrentTimeStamp());
             ps.setString(5, status);
             ps.setString(6, password);
             ps.setString(7, plateNo);
             ps.setString(8, email);
             
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
    public riderBean getRiderByEmail(String email) {
		riderBean rider = new riderBean();
		try {
			currentCon = ConnectionManager.getConnection();
			ps = currentCon.prepareStatement("SELECT * FROM RIDER WHERE email = '" + email +"'");
			
			//ps.setInt(1, email.toString());
			ResultSet rs = ps.executeQuery();
			
			if(rs.next()) {
				rider.setEmail(rs.getString("email"));
				rider.setPlateNo(rs.getString("plate_no"));
                                rider.setRiderName(rs.getString("rider_name"));
				rider.setRiderPhone(rs.getString("rider_phone"));
				rider.setStatus(rs.getString("status"));  
                                rider.setPassword(rs.getString("password"));  
                                rider.setRiderID(rs.getInt("rider_id")); 
			} 
		}catch(SQLException e) {
			e.printStackTrace();
			}
	    return rider;
	}
     
       public void updateRider(riderBean bean) throws NoSuchAlgorithmException {
		riderID = bean.getRiderID();
                riderName = bean.getRiderName();
		email = bean.getEmail();
                riderPhone = bean.getRiderPhone();
                status = bean.getStatus();
                plateNo = bean.getPlateNo();
                password = bean.getPassword();
          
		String searchQuery = "UPDATE RIDER SET rider_name ='" + riderName + "', plate_no ='" + plateNo + "', email ='" + email + "', rider_phone ='" + riderPhone + "', status ='" + status + "', password ='" + password +"' WHERE rider_ID ='" + riderID +"'";
		
		try {
			currentCon = ConnectionManager.getConnection();
			stmt = currentCon.createStatement();
			stmt.executeUpdate(searchQuery);
                        
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
    
    public List<riderBean> getAllRider(){
        //SQL command
        List<riderBean> riders = new ArrayList<riderBean>();
        String searchQuery = "SELECT * FROM RIDER";
        
        try{
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            ResultSet rs = stmt.executeQuery(searchQuery);
            
            while(rs.next()){
                riderBean rider = new riderBean();
                rider.setRiderID(rs.getInt("rider_id"));
                rider.setRiderName(rs.getString("rider_name"));
                rider.setIdentificationNo(rs.getString("rider_ic"));
                rider.setRiderPhone(rs.getString("rider_phone"));
                rider.setRegDate(rs.getTimestamp("reg_date"));
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
    
    public void deleteRider(int rider_ID){  
        try{
            currentCon = ConnectionManager.getConnection();
            ps = currentCon.prepareStatement("DELETE FROM RIDER WHERE rider_ID = ?");
            ps.setInt(1, rider_ID);
            ps.executeUpdate();
        }
        catch(SQLException ex){ 
            System.out.println(ex); 
        }
    }
}
