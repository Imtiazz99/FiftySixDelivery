package henshin.model;
import java.sql.Date;
/**
 *
 * @author syam
 */
public class reportBean {
    
    private int paymentID;
    private Date paymentTime;
    private float paymentTotal;
    private float paymentDelivery;
    
public reportBean() {
        super();
    }
    
public reportBean(int paymentID, Date paymentTime, float paymentTotal, float paymentDelivery) {
        super();
        this.paymentID = paymentID;
        this.paymentTime = paymentTime;
        this.paymentTotal = paymentTotal;
        this.paymentDelivery = paymentDelivery;
    }

public int getPaymentid() {
        return paymentID;
    }

public Date getPaymenttime() {
        return paymentTime;
    }

public float getPaymenttotal() {
        return paymentTotal;
    }

public float getPaymentdelivery() {
        return paymentDelivery;
    }

public void setPaymentid(int paymentID) {
        this.paymentID = paymentID;
 }
 
public void setPaymenttime(Date paymentTime) {
        this.paymentTime = paymentTime;
    }

public void setPaymenttotal(float paymentTotal) {
        this.paymentTotal = paymentTotal;
    }
 
public void setPaymentdelivery(float paymentDelivery) {
        this.paymentDelivery = paymentDelivery;
    }

}