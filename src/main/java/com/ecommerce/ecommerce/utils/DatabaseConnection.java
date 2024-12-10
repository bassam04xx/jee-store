package com.ecommerce.ecommerce.utils;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseConnection {
    private static final String URL = "jdbc:postgresql://autorack.proxy.rlwy.net:45539/railway";
    private static final String USER = "postgres";
    private static final String PASSWORD = "NfZIadStFntpjFDjNqERUZyyjZeeVlDL";

    public static Connection getConnection() throws Exception {
        Class.forName("org.postgresql.Driver"); // Load the PostgreSQL driver
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
