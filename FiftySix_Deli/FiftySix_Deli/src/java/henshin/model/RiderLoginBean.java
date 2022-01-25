package henshin.model;

 
public class RiderLoginBean{
    private String email;
    private String password;
    int riderID;

      public int getRiderID() {
        return riderID;
    }

    public void setRiderID(int riderID) {
        this.riderID = riderID;
    }
  
    
 public String getEmail() {
        return email;
    }
 public void setEmail(String email) {
        this.email= email;
 }
 
 public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
 
}