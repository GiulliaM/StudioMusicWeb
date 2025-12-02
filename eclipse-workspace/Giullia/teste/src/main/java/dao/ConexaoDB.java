package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexaoDB {

    private static final String URL = "jdbc:mysql://localhost:3306/studiomusic_db?useSSL=false&serverTimezone=America/Sao_Paulo";
    private static final String USER = "root";
    private static final String PASSWORD = ""; // coloque sua senha se tiver

    public static Connection getConnection() throws SQLException {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // carrega o driver do MySQL
        } catch (ClassNotFoundException e) {
            System.err.println("ERRO: Driver MySQL JDBC não encontrado no classpath!");
            throw new SQLException(e);
        }

        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
