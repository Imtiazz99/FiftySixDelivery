package henshin.model;

import java.sql.Date;


/**
 *
 * @author Aina Syazana
 */
public class assignRiderBean {
    int riderID;
    int orderid;
    String riderName;
    String identificationNo;
    String riderPhone;
    Date regDate;
    String status;
    String plateNo;
    String email;
    String password;
    String street, city, state, postcode;
    private boolean valid;
    
    public boolean isValid() {
        return valid;
    }
    
    public void setValid(boolean valid) {
        this.valid = valid;
    }
    
    public int getRiderID() {
        return riderID;
    }

    public void setRiderID(int riderID) {
        this.riderID = riderID;
    }
   public int getOrderID() {
        return orderid;
    }

    public void setOrderID(int orderid) {
        this.orderid = orderid;
    }
    public String getRiderName() {
        return riderName;
    }

    public void setRiderName(String riderName) {
        this.riderName = riderName;
    }
    
    public String getIdentificationNo() {
        return identificationNo;
    }

    public void setIdentificationNo(String identificationNo) {
        this.identificationNo = identificationNo;
    }
    
    public String getRiderPhone() {
        return riderPhone;
    }

    public void setRiderPhone(String riderPhone) {
        this.riderPhone = riderPhone;
    }
    
    public Date getRegDate() {
        return regDate;
    }

    public void setRegDate(Date regDate) {
        this.regDate = regDate;
    }
    
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getPlateNo() {
        return plateNo;
    }

    public void setPlateNo(String plateNo) {
        this.plateNo = plateNo;
    }
    
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }
    
    public String getCity() {
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
    
}
