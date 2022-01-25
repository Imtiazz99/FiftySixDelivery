
package henshin.model;
import java.sql.Date;
import java.sql.Timestamp;
/**
 *
 * @author Asus
 */
public class customerBean {
    private int custID, addressID;
    private String custName;
    private String email;
    private String password;
    Timestamp regDate;
    private String phoneNo;
    private String deliveryAddress;
    private String street;
    private String city;
    private String state;
    private String postcode;
    private boolean valid;
    public String session;

    public boolean isValid() {
        return valid;
    }
    
    public void setValid(boolean valid) {
        this.valid = valid;
    }
    
    public void setSession(String session){
        this.session = session;
    } 
            
    public int getCustID() {
        return custID;
    }

    public void setCustID(int custID) {
        this.custID = custID;
    }
    
    public int getAddressID() {
        return addressID;
    }

    public void setAddressID(int addressID) {
        this.addressID = addressID;
    }

    public String getCustName() {
        return custName;
    }

    public void setCustName(String custName) {
        this.custName = custName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
        
    }public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }
    
    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }
    
    public String getPostcode() {
        return postcode;
    }

    public void setPostcode(String postcode) {
        this.postcode = postcode;
    }
    
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

     public Timestamp getRegDate() {
        return regDate;
    }

    public void setRegDate(Timestamp regDate) {
        this.regDate = regDate;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }
}
