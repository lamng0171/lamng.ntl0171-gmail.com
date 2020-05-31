package com.vti.utils;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class JdbcUtils {
	public void connectForTesting() throws FileNotFoundException, IOException, ClassNotFoundException, SQLException {

		Properties properties = new Properties();
		properties.load(new FileInputStream("src\\main\\java\\resource\\database.properties"));

		String url = properties.getProperty("url");
		String user = properties.getProperty("user");
		String password = properties.getProperty("password");

		Class.forName(properties.getProperty("driver"));

		System.out.println("Success");
	}

	public Connection connect() throws FileNotFoundException, IOException, ClassNotFoundException, SQLException {

		Properties properties = new Properties();
		properties.load(new FileInputStream("src\\main\\java\\resource\\database.properties"));

		String url = properties.getProperty("url");
		String user = properties.getProperty("user");
		String password = properties.getProperty("password");

		Class.forName(properties.getProperty("driver"));

		return DriverManager.getConnection(url, user, password);
	}

	public void disconnect(Connection connect) throws SQLException {
		connect.close();
	}
}
