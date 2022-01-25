package henshin.model;

 
public class LoginBean{
    private String email;
    private String password;
       int custID;

      public int getCustID() {
        return custID;
    }

    public void setCustID(int custID) {
        this.custID = custID;
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