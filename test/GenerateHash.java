/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author laman
 */
public class GenerateHash {

    public static void main(String[] args) {
        String password = "admin123";
        String newHash = BCrypt.hashpw(password, BCrypt.gensalt());
        System.out.println("Chuỗi Hash:");
        System.out.println(newHash);
        System.out.println("Kiểm tra thử: " + BCrypt.checkpw(password, newHash));
    }
}
