/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package henshin.model;

import java.io.InputStream;
import java.sql.Blob;
import javax.servlet.http.Part;

/**
 *
 * @author User
 */
public class menuBean {
    
    private String menuName,menuDesc,menuCatName;
    private int menuID,menuCat,menuQuantity;
    private float menuPrice;
    public boolean valid;
    private String base64Image;
    private Part filePart;
    private String filename; // filename
    //private Blob image;    // blob - image
    private InputStream file;
    
    public menuBean(){
        super();
    }

    public menuBean(String menuName, float menuPrice, String menuDesc, int menuQuantity, int menuCat, InputStream file) {
        super();
        this.menuName = menuName;
        this.menuPrice = menuPrice;
        this.menuDesc = menuDesc;
        this.menuQuantity = menuQuantity;
        //this.filename = filename;
        this.menuCat = menuCat;
        this.file = file;
    }
    
    public int getMenuID(){
        return menuID;
    }
    
    public void setMenuID(int menuID){
        this.menuID = menuID;
    }
    
    public String getMenuName(){
        return menuName;
    }
    
    public void setMenuName(String menuName){
        this.menuName = menuName;
    }
    
    public float getMenuPrice(){
        return menuPrice;
    }
    
    public void setMenuPrice(float menuPrice){
        this.menuPrice = menuPrice;
    }
    
    public String getMenuDesc(){
        return menuDesc;
    }
    
    public void setMenuDesc(String menuDesc){
        this.menuDesc = menuDesc;
    }
    
    public int getMenuQuan(){
        return menuQuantity;
    }
    
    public void setMenuQuan(int menuQuantity){
        this.menuQuantity = menuQuantity;
    }
    
    public int getMenuCat(){
        return menuCat;
    }
    
    public void setMenuCat(int menuCat){
        this.menuCat = menuCat;
    }
    
    public String getMenuCategoryName(){
        if (menuCat == 1){
            return "Whole Cake";
        }
        else if (menuCat == 2){
            return "Cupcake";
        }
        else if (menuCat == 3){
            return "Cookies";
        }
        else if (menuCat == 4){
            return "Dessert";
        }
        else{
            return null;
        }
    }
    
    public void setMenuCategoryName(String menuCatName){
        if (menuCat == 1){
            this.menuCatName =  "Whole Cake";
        }
        else if (menuCat == 2){
            this.menuCatName =  "Cupcake";
        }
        else if (menuCat == 3){
            this.menuCatName =  "Cookies";
        }
        else if (menuCat == 4){
            this.menuCatName =  "Dessert";
        }
        else{
        }
    }
    
    public String getFileName(){
        return filename;
    }
    
    public void setFileName(String filename){
        this.filename = filename;
    }
    
    
    
    public Part getPath(){
        return filePart;
    }
    
    public void setPath(Part filePart){
        this.filePart = filePart;
    }
    
    public boolean isValid(){
        return valid;
    }
    
    public void setValid(boolean valid){
        this.valid = valid;
    }
    
    public String getBase64Image() {
        return base64Image;
    }
 
    public void setBase64Image(String base64Image) {
        this.base64Image = base64Image;
    }
    
    public InputStream getFile(){
        return file;
    }
    
    public void setFile(InputStream file){
        this.file = file;
    }

}
