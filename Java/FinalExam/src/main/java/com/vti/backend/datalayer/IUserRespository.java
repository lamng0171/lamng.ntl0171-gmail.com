package com.vti.backend.datalayer;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;

public interface IUserRespository {

	void registerManager(String firstName, String lastName, String phone, String email, String password, int expInYear)
			throws Exception;

	void registerEmployee(String firstName, String lastName, String phone, String email, String password,
			String projectName, String proSkill) throws Exception;

	boolean isUserExists(String email)
			throws FileNotFoundException, ClassNotFoundException, IOException, SQLException;
	
	void login(String email, String pass)
			throws SQLException, FileNotFoundException, ClassNotFoundException, IOException;
}
