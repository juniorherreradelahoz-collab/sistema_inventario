package com.mycompany.sistema_inventario;

import java.sql.Connection;
import java.sql.DriverManager;

public class Conexion {
    private Connection con;

    public Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/sistema_inventario",
                "root",
                "Junior2026*"
            );
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return con;
    }
}
