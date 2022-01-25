package henshin.model;

import java.sql.Timestamp;
/**
 *
 * @author Aina Syazana
 */
public class riderBean {
    int riderID;
    String riderName;
    String identificationNo;
    String riderPhone;
    String status;
    String plateNo;
    String email;
    String password;
    private boolean valid;
    Timestamp regDate;
    
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
    
    public Timestamp getRegDate() {
        return regDate;
    }

    public void setRegDate(Timestamp regDate) {
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
    
}
