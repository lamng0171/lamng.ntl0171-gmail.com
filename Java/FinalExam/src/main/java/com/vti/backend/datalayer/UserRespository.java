package com.vti.backend.datalayer;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

import com.vti.utils.JdbcUtils;
import com.vti.utils.MessageUtils;
import com.vti.utils.ScannerUtils;

public class UserRespository implements IUserRespository {
	private JdbcUtils jdbcUtils;
	private MessageUtils messageUtils;

	private static Scanner scanner = new Scanner(System.in);

	// create UserRespository constructor
	public UserRespository() throws IOException {
		jdbcUtils = new JdbcUtils();
		messageUtils = new MessageUtils();
	}

	// a) tạo chức năng register cho Manager & Employee

	@Override
	public void registerManager(String firstName, String lastName, String phone, String email, String password,
			int expInYear) throws Exception {
		// get connection
		Connection connection = jdbcUtils.connect();

		// if not exist
		// create a statement object
		String sql = "INSERT INTO `User` 	(firstName, lastName, phone, email, passWord)"
				+ "VALUE              	(   ? ,   		?   ,   ? 	,	?	,	?)";
		PreparedStatement preparedStatement = connection.prepareStatement(sql);

		String sql1 = "INSERT INTO Manager 	(email,	expInYear)" + "VALUE ( ? , ? )";
		PreparedStatement preparedStatement1 = connection.prepareStatement(sql1);

		// set parameter
		preparedStatement.setString(1, firstName);
		preparedStatement.setString(2, lastName);
		preparedStatement.setString(3, phone);
		preparedStatement.setString(4, email);
		preparedStatement.setString(5, password);

		preparedStatement1.setString(1, email);
		preparedStatement1.setInt(2, expInYear);

		// execute query
		int check = preparedStatement.executeUpdate();
		int check1 = preparedStatement1.executeUpdate();

		// check create success or false
		System.out.println(
				check > 0 && check1 > 0 ? messageUtils.getProperty("Success!") : messageUtils.getProperty("Failure!"));

		// disconnect
		jdbcUtils.disconnect(connection);
	}

	@Override
	public void registerEmployee(String firstName, String lastName, String phone, String email, String password,
			String projectName, String proSkill) throws Exception {
		// get connection
		Connection connection = jdbcUtils.connect();

		// if not exist
		// create a statement object
		String sql = "INSERT INTO `User` 	(firstName, lastName, phone, email, passWord)"
				+ "VALUE              	(	?	,	?	,	?	,	?	,	?	)";
		PreparedStatement preparedStatement = connection.prepareStatement(sql);

		String sql1 = "INSERT INTO Employee (email, projectName, proSkill)" + "VALUE ( ? , ? , ? )";
		PreparedStatement preparedStatement1 = connection.prepareStatement(sql1);

		// set parameter
		preparedStatement.setString(1, firstName);
		preparedStatement.setString(2, lastName);
		preparedStatement.setString(3, phone);
		preparedStatement.setString(4, email);
		preparedStatement.setString(5, password);

		preparedStatement1.setString(1, email);
		preparedStatement1.setString(2, projectName);
		preparedStatement1.setString(3, proSkill);

		// execute query
		int check = preparedStatement.executeUpdate();
		int check1 = preparedStatement1.executeUpdate();

		// check create success or false
		System.out.println(
				check > 0 && check1 > 0 ? messageUtils.getProperty("Success!") : messageUtils.getProperty("Failure!"));

		// disconnect
		jdbcUtils.disconnect(connection);
	}

	// check User exists or not
	@Override
	public boolean isUserExists(String email)
			throws FileNotFoundException, ClassNotFoundException, IOException, SQLException {
		// get connection
		Connection connection = jdbcUtils.connect();

		// create a statement object
		String sql = "SELECT email FROM `User` WHERE email = ?";
		PreparedStatement preparedStatement = connection.prepareStatement(sql);

		// set parameter
		preparedStatement.setString(1, email);

		// execute query
		ResultSet resultSet = preparedStatement.executeQuery();

		// handling result set
		if (resultSet.next()) {
			// disconnect
			jdbcUtils.disconnect(connection);
			return true;

		} else {
			// disconnect
			jdbcUtils.disconnect(connection);
			return false;
		}
	}

	// b) tao chuc nang login
	@Override
	public void login(String email, String pass)
			throws SQLException, FileNotFoundException, ClassNotFoundException, IOException {
		try {
				// get connection
				Connection connection = jdbcUtils.connect();

				// create a statement object
				String sql = "SELECT * FROM `User` WHERE email = ? AND `password` = ?";
				PreparedStatement preparedStatement = connection.prepareStatement(sql);

				// set parameter
				preparedStatement.setString(1, email);
				preparedStatement.setString(2, pass);

				// execute query
				ResultSet resultSet = preparedStatement.executeQuery();

				// handling result set
				if (resultSet.next()) {
					// disconnect
					jdbcUtils.disconnect(connection);
					System.out.println("Đăng nhập thành công!");

				} else {
					// disconnect
					jdbcUtils.disconnect(connection);
					System.out.println("Đăng nhập thất bại!");
				}
		} catch (Exception e) {
			System.err.println("Kết nối thất bại!");
		}
	}
}
