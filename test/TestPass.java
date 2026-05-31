/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
 import org.mindrot.jbcrypt.BCrypt;
/**
 *
 * @author laman
 */
public class TestPass {

    public static void main(String[] args) {
        String pass = "admin123";
        // Chuỗi hash của admin password
        String hashFromDB = "$2a$10$78C6k4hCmqpAn7H7Aupwdu9.wU4D.pYV3O7DkFm78e9M7W1t6uS72";      
        System.out.println("KẾT QUẢ SO SÁNH: " + BCrypt.checkpw(pass, hashFromDB));
    }
}
