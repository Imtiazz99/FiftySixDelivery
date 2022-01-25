
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
import henshin.model.customerBean;
import henshin.connection.ConnectionManager;
import static henshin.dao.adminDAO.currentCon;
import static henshin.dao.customerDAO.currentCon;
import henshin.model.addressBean;
import java.sql.Date;

public class customerDAO {
    static Connection currentCon = null;
    static ResultSet rs = null; 
    static PreparedStatement ps = null;
    static Statement stmt = null;
    //field ada dalam table
    static int custID;
    static String custName;
    static String email;
    static String password;
    static Timestamp regDate;
    static String phoneNo;
    static String deliveryAddress;
    static String street;
    static String city;
    static String state;
    static String postcode;
    
    
    //methods yang guna dalam controller, the implementations letak kat sini
    //sebab diaaaaaa check an object 
    public static customerBean getCust(customerBean bean){
        custID = bean.getCustID();
        
        //SQL command
        String searchQuery = "SELECT * FROM CUSTOMERS WHERE CUST_ID ='" + custID + "'";
        
        try{
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            rs = stmt.executeQuery(searchQuery);
            boolean more = rs.next();
            
            //rs tu refer to database
            if(more){
                int id = rs.getInt("CUST_ID");
                bean.setCustID(id);
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
       public static customerBean getCusto(customerBean bean){
        email = bean.getEmail();

        //SQL command
        String searchQuery = "SELECT * FROM CUSTOMERS WHERE EMAIL ='" + email + "'";

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
    
    public List<customerBean> getAllCustomer(){
        //SQL command
        List<customerBean> customer = new ArrayList<customerBean>();
        String searchQuery = "SELECT * FROM CUSTOMERS";
        
        try{
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            ResultSet rs = stmt.executeQuery(searchQuery);
            
            while(rs.next()){
                customerBean cust = new customerBean();
                cust.setCustID(rs.getInt("cust_id"));
                cust.setCustName(rs.getString("cust_name"));
                cust.setEmail(rs.getString("email"));
                cust.setRegDate(rs.getTimestamp("reg_date"));
                cust.setPhoneNo(rs.getString("phone_no"));
                cust.setDeliveryAddress(rs.getString("delivery_address"));
                customer.add(cust);
            }
        }
        catch(SQLException ex){ 
            System.out.println(ex); 
        }
        
        return customer;
    }
    
    private static java.sql.Timestamp getCurrentTimeStamp() {

    java.util.Date today = new java.util.Date();
    return new java.sql.Timestamp(today.getTime());

}

    public void addCust(customerBean bean) throws NoSuchAlgorithmException{
         custName = bean.getCustName();
         email = bean.getEmail();
         password = bean.getPassword();
         regDate = bean.getRegDate();
         phoneNo = bean.getPhoneNo();
         deliveryAddress = bean.getDeliveryAddress();

         try{
             currentCon = ConnectionManager.getConnection();
             ps = currentCon.prepareStatement("INSERT INTO CUSTOMERS (CUST_NAME, EMAIL, CUST_PASSWORD,REG_DATE,PHONE_NO) VALUES (?,?,?,?,?)");
             //corresponds with the SQL statement^
             ps.setString(1, custName);
             ps.setString(2, email);
             ps.setString(3, password);
             ps.setTimestamp(4, getCurrentTimeStamp());
             ps.setString(5, phoneNo);

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
    
     public void deleteCustomer(int cust_ID){
        
        try{
            currentCon = ConnectionManager.getConnection();
            ps = currentCon.prepareStatement("DELETE FROM CUSTOMERS WHERE cust_ID = ?");
            ps.setInt(1, cust_ID);
            ps.executeUpdate();
        }
        catch(SQLException ex){ 
            System.out.println(ex); 
        }
    }
     
      public void deleteAddress(int addressID){
        
        try{
            currentCon = ConnectionManager.getConnection();
            ps = currentCon.prepareStatement("DELETE FROM ADDRESS WHERE address_id = ?");
            ps.setInt(1, addressID);
            ps.executeUpdate();
        }
        catch(SQLException ex){ 
            System.out.println(ex); 
        }
    }
   
     public List<addressBean> getAddressListByID(int custID) {
                List<addressBean> customers = new ArrayList<addressBean>();
                String searchQuery = "SELECT * FROM CUSTOMERS JOIN ADDRESS USING (CUST_ID) WHERE CUST_ID = '" + custID +"'";
		//"SELECT DISTINCT * FROM CUSTOMERS JOIN ADDRESS USING (CUST_ID) WHERE CUST_ID = '" + custID +"'";
		try {
			currentCon = ConnectionManager.getConnection();
                        stmt = currentCon.createStatement();
                        ResultSet rs = stmt.executeQuery(searchQuery);
			
			while(rs.next()) {
                                addressBean customer = new addressBean();
				//customer.setEmail(rs.getString("email"));
				customer.setStreet(rs.getString("address_line1"));
                                customer.setCity(rs.getString("city"));
				customer.setState(rs.getString("state"));
				customer.setPostcode(rs.getString("postcode")); 
                                customer.setAddressID(rs.getInt("address_id")); 
                                //customer.setCustID(rs.getInt("cust_id")); 
                                //customer.setAddressID(rs.getInt("address_id")); 
                                customers.add(customer);
			} 
		}catch(SQLException e) {
			e.printStackTrace();
			}
	    return customers;
	}        
             
     public customerBean getCustomerByEmail(String email) {
		customerBean customer = new customerBean();
		try {
			currentCon = ConnectionManager.getConnection();
			ps = currentCon.prepareStatement("SELECT * FROM CUSTOMERS WHERE email = '" + email +"'");
			
			//ps.setInt(1, email.toString());
			ResultSet rs = ps.executeQuery();
			
			if(rs.next()) {
				customer.setEmail(rs.getString("email"));
				customer.setPassword(rs.getString("cust_password"));
                                customer.setCustName(rs.getString("cust_name"));
				customer.setPhoneNo(rs.getString("phone_no"));
				customer.setDeliveryAddress(rs.getString("delivery_address"));  
                                customer.setCustID(rs.getInt("cust_id")); 
			} 
		}catch(SQLException e) {
			e.printStackTrace();
			}
	    return customer;
	}
    
     public void updateCustomer(customerBean bean) throws NoSuchAlgorithmException {
		custID = bean.getCustID();
                custName = bean.getCustName();
		email = bean.getEmail();
                phoneNo = bean.getPhoneNo();
                deliveryAddress = bean.getDeliveryAddress();
		password = bean.getPassword();
                
               
		String searchQuery = "UPDATE CUSTOMERS SET cust_name ='" + custName + "', email ='" + email + "', phone_no ='" + phoneNo + "', delivery_address ='" + deliveryAddress + "' WHERE cust_ID ='" + custID +"'";
		
		try {
			currentCon = ConnectionManager.getConnection();
			stmt = currentCon.createStatement();
			stmt.executeUpdate(searchQuery);
			//System.out.println("Your profile has been updated succesfully!");
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
     
       public void addAddress(customerBean bean, int custID) throws NoSuchAlgorithmException, SQLException {      
                street = bean.getStreet();
		city = bean.getCity();
                state = bean.getState();
                postcode = bean.getPostcode();
             
             try{
             currentCon = ConnectionManager.getConnection();
             ps = currentCon.prepareStatement("INSERT INTO ADDRESS (ADDRESS_LINE1, CITY, STATE, POSTCODE, CUST_ID) VALUES (?,?,?,?,?)");
             //corresponds with the SQL statement^
             ps.setString(1, street);
             ps.setString(2, city);
             ps.setString(3, state);
             ps.setString(4, postcode);
             ps.setInt(5, custID);
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
 
     
     public void updatePassword(customerBean bean, String oPass, String nPass) throws NoSuchAlgorithmException, SQLException {
         
		password = bean.getPassword();
                email = bean.getEmail();
               
                currentCon = ConnectionManager.getConnection();
		ps = currentCon.prepareStatement("SELECT * FROM CUSTOMERS WHERE email = '" + email +"' AND cust_password = '" + oPass +"'");		
		ResultSet rs = ps.executeQuery();
                
                if(rs.next()){
                String searchQuery = "UPDATE CUSTOMERS SET cust_password ='" + nPass + "' WHERE email ='" + email +"'";

		try {
			currentCon = ConnectionManager.getConnection();
			stmt = currentCon.createStatement();
			stmt.executeUpdate(searchQuery);
			//System.out.println("Your profile has been updated succesfully!");
		} catch(SQLException e) {
			e.printStackTrace();
		}
                }              
	}
    
}
