/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package inc;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author Ceng
 */
public class koneksi {
    public static Connection conn;
    public static Connection Conn(){
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/ceng_bookstore", "root", "");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return conn;
    }

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        System.out.println(koneksi.Conn());
    }
    
}
