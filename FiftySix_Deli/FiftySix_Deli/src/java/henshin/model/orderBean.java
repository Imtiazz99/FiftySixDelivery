

package henshin.model;

import java.util.Date;

/**
 *
 * @author Asus
 */
public class orderBean {
    int orderid;
    String deliverycharges;
    String cust_name;
    String deliveryaddress;
    String menuname;
    String menuprice;
    String rider_name;
    String order_status;
    Date order_time;
    Date delivery_time;
    Date complete_time;
    Date payment_time;
    int quantity;
    int rider_id;
    String phone_no;
    String street, city, state, postcode, status;
    int menu_id;
    int custID;
    int statusID;
    String methodname;
    float totPayment;
    private boolean valid;

    public boolean isValid() {
        return valid;
    }
    
    public void setValid(boolean valid) {
        this.valid = valid;
    }
    
    public int getCustID() {
        return custID;
    }

    public void setCustID(int custID) {
        this.custID = custID;
    }
    
    public float getTotPayment() {
        return totPayment;
    }

    public void setTotPayment(float totPayment) {
        this.totPayment = totPayment;
    }
    
    public int getMenu_id() {
        return menu_id;
    }

    public void setMenu_id(int menu_id) {
        this.menu_id = menu_id;
    }
    public int getRider_id() {
        return rider_id;
    }

    public void setRider_id(int rider_id) {
        this.rider_id = rider_id;
    }
    public int getOrderid() {
        return orderid;
    }

    public void setOrderid(int orderid) {
        this.orderid = orderid;
    }
    
    public int getStatusID() {
        return statusID;
    }

    public void setStatusID(int statusID) {
        this.statusID = statusID;
    }
    
    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    public String getPhone_no() {
        return phone_no;
    }
    public void setPhone_no(String phone_no) {
        this.phone_no = phone_no;
    }
    public String getDeliverycharges() {
        return deliverycharges;
    }

    public void setDeliverycharges(String deliverycharges) {
        this.deliverycharges = deliverycharges;
    }
    
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    public String getCust_name() {
        return cust_name;
    }

    public void setCust_name(String cust_name) {
        this.cust_name = cust_name;
    }
    public String getRider_name() {
        return rider_name;
    }

    public void setRider_name(String rider_name) {
        this.rider_name = rider_name;
    }
    public String getOrder_status() {
        return order_status;
    }

    public void setOrder_status(String order_status) {
        this.order_status = order_status;
    }
    
    public String getMenuprice() {
        return menuprice;
    }

    public void setMenuprice(String menuprice) {
        this.menuprice = menuprice;
    }
    public String getDeliveryaddress() {
        return deliveryaddress;
    }

    public void setDeliveryaddress(String deliveryaddress) {
        this.deliveryaddress = deliveryaddress;
    }
    public String getMenuname() {
        return menuname;
    }

    public void setMenuname(String menuname) {
        this.menuname = menuname;
    }

    public Date getOrder_time() {
        return order_time;
    }

    public void setOrder_time(Date order_time) {
        this.order_time = order_time;
    }
    public Date getDelivery_time() {
        return delivery_time;
    }

    public void setDelivery_time(Date delivery_time) {
        this.delivery_time = delivery_time;
    }

    public Date getComplete_time() {
        return complete_time;
    }

    public void setComplete_time(Date complete_time) {
        this.complete_time= complete_time;
    }
    
    public String getMethodname() {
        return methodname;
    }

    public void setMethodname(String methodname) {
        this.methodname = methodname;
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
    
     public Date getPayment_time() {
        return payment_time;
    }

    public void setPayment_time(Date payment_time) {
        this.payment_time = payment_time;
    }

}
