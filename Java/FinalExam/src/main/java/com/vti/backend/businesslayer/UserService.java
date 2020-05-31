package com.vti.backend.businesslayer;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;

import com.vti.backend.datalayer.IUserRespository;
import com.vti.backend.datalayer.UserRespository;

public class UserService implements IUserService {
	private IUserRespository repository;

	public UserService() throws IOException {
		repository = new UserRespository();
	}

	@Override
	public void registerManager(String firstName, String lastName, String phone, String email, String password,
			int expInYear) throws Exception {
		repository.registerManager(firstName, lastName, phone, email, password, expInYear);
	}

	@Override
	public void registerEmployee(String firstName, String lastName, String phone, String email, String password,
			String projectName, String proSkill) throws Exception {
		repository.registerEmployee(firstName, lastName, phone, email, password, projectName, proSkill);
	}

	@Override
	public void login(String email, String pass)
			throws SQLException, FileNotFoundException, ClassNotFoundException, IOException{
		repository.login(email, pass);
	}
	
	@Override
	public boolean isUserExists(String email)
			throws FileNotFoundException, ClassNotFoundException, IOException, SQLException {
		return repository.isUserExists(email);
	}
}
