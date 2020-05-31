package com.vti.backend.presentationlayer;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;
import com.vti.backend.businesslayer.IUserService;
import com.vti.backend.businesslayer.UserService;
import com.vti.utils.MessageUtils;

public class UserController {
	private IUserService service;
	private MessageUtils messageUtils;

	public UserController() throws IOException {
		service = new UserService();
		messageUtils = new MessageUtils();
	}

	public void registerManager(String firstName, String lastName, String phone, String email, String password,
			int expInYear) throws Exception {
		String phonePattern = "^0(3[23456789]|8[12345689]|9[012346789]|7[06789]|5[689]){1}(-)?[0-9]{9}$";
		String emailPattern = "\\w+([.]\\w+)?@" + "vti.com.vn";
		String passwordPattern = "^(?=.*?[A-Z]).{6,12}$";

		// validation
		while (true) {
			if (isUserExists(email)) {
				throw new Exception(messageUtils.getProperty("registerUser.exists"));
			}

			if (!phone.matches(phonePattern)) {
				throw new Exception("Số điện thoại không hợp lệ!");
			}
			
			if (!email.matches(emailPattern)) {
				throw new Exception("Email không hợp lệ! Mời nhập lại email theo mẫu example@vti.com.vn!");
			}

			if (!password.matches(passwordPattern)) {
				throw new Exception("Mật khẩu phải có độ dài từ 6 -> 12 kí tự và có ít nhất một chữ cái viết hoa!");
			}
			if (expInYear > 20) {
				throw new Exception("Bạn có chắc mình có nhiều hơn 20 kinh nghiệm!");
			}

			service.registerManager(firstName, lastName, phone, email, password, expInYear);
		}
	}

	public void registerEmployee(String firstName, String lastName, String phone, String email, String password,
			String projectName, String proSkill) throws Exception {

		String phonePattern = "^(086|096|097|098|032|033|034|035|036|037|038|039|089|090|093|070|079|077|076|078|088|091|094|083|084|085|081|082|092|056|058|099|059){1}"
				+ "[0-9]{9}$";
		String emailPattern = "\\w+([.]\\w+)?@" + "vti.com.vn";
		String passwordPattern = "^(?=.*?[A-Z]).{6,12}$";

		// validation
		while (true) {
			if (isUserExists(email)) {
				throw new Exception(messageUtils.getProperty("registerUser.exists"));
			}

			if (!phone.matches(phonePattern)) {
				throw new Exception("Số điện thoại không hợp lệ!");
			}
			if (!email.matches(emailPattern)) {
				throw new Exception("Email không hợp lệ! Mời nhập lại email theo mẫu example@vti.com.vn!");
			}

			if (!password.matches(passwordPattern)) {
				throw new Exception("Mật khẩu phải có độ dài từ 6 -> 12 kí tự và có ít nhất một chữ cái viết hoa!");
			}

			if (!projectName.equals("Testing System") || !projectName.equals("CRM")
					|| !projectName.equals("TimeSheet")) {
				throw new Exception("Hãy nhập vào một trong những dự án: Testing System || CRM || TimeSheet");
			}
			service.registerEmployee(firstName, lastName, phone, email, password, projectName, proSkill);
		}
	}

	public void login(String email, String pass)
			throws SQLException, FileNotFoundException, ClassNotFoundException, IOException {
		service.login(email, pass);
	}

	private boolean isUserExists(String email)
			throws FileNotFoundException, ClassNotFoundException, IOException, SQLException {
		return service.isUserExists(email);
	}
}
