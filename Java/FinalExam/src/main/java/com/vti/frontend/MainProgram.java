package com.vti.frontend;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Scanner;

import com.vti.backend.presentationlayer.UserController;
import com.vti.utils.ScannerUtils;

public class MainProgram {

	private static UserController userController;

	public static void main(String[] args) throws Exception {
		userController = new UserController();
		int choose;
		do {
			menu();

			System.out.println("Nhập vào chức năng bạn muốn sử dụng: ");
			choose = ScannerUtils.inputInt("");
			switch (choose) {
			case 1:
				// register for manager
				System.out.println("======Register Manager=====");
				registerManager();
				break;

			case 2:
				// register for employee
				System.out.println("=======Register Employee======");
				registerEmployee();
				break;

			case 3:
				// login
				System.out.println("=========Login=========");
				login();
				break;

			case 4:
				// exit
				System.out.println("=========Exit=========");
				break;

			default:
				System.out.println("Mời nhập lại!");
				break;
			}
		} while (choose != 4);
	}

	private static void menu() {
		System.out.println("============MENU===========");
		System.out.println("=|1. Register Manager    |=");
		System.out.println("=|2. Register Employee   |=");
		System.out.println("=|3. Login   		 |=");
		System.out.println("=|4. Exit                |=");
		System.out.println("===========================");
	}

	private static void registerManager() throws Exception {
		System.out.println("First Name: ");
		String firstName = ScannerUtils.inputString("Thông tin không thể bỏ trống!");

		System.out.println("Last Name: ");
		String lastName = ScannerUtils.inputString("Thông tin không thể bỏ trống!");

		System.out.println("Phone: ");
		String phone = ScannerUtils.inputString("Thông tin không thể bỏ trống!");

		System.out.println("Email: ");
		String email = ScannerUtils.inputString("Thông tin không thể bỏ trống!");

		System.out.println("Password: ");
		String password = ScannerUtils.inputString("Thông tin không thể bỏ trống!");

		System.out.println("Years Of Experience: ");
		int expInYear = ScannerUtils.inputInt("Thông tin không thể bỏ trống!");

		userController.registerManager(firstName, lastName, phone, email, password, expInYear);
	}

	private static void registerEmployee() throws Exception {
		System.out.println("First Name: ");
		String firstName = ScannerUtils.inputString("Thông tin không thể bỏ trống!");

		System.out.println("Last Name: ");
		String lastName = ScannerUtils.inputString("Thông tin không thể bỏ trống!");

		System.out.println("Phone: ");
		String phone = ScannerUtils.inputString("Thông tin không thể bỏ trống!");

		System.out.println("Email: ");
		String email = ScannerUtils.inputString("Thông tin không thể bỏ trống!");

		System.out.println("Password: ");
		String password = ScannerUtils.inputString("Thông tin không thể bỏ trống!");

		System.out.println("Project Name: ");
		String projectName = ScannerUtils.inputString("Thông tin không thể bỏ trống!");

		System.out.println("Proskill: ");
		String proSkill = ScannerUtils.inputString("Thông tin không thể bỏ trống!");

		userController.registerEmployee(firstName, lastName, phone, email, password, projectName, proSkill);
	}

	private static void login() throws FileNotFoundException, ClassNotFoundException, SQLException, IOException {

		System.out.println("Email: ");
		String email = ScannerUtils.inputString("Email không tồn tại!");

		System.out.println("Password: ");
		String pass = ScannerUtils.inputString("Nhập sai mật khẩu! Xin hãy nhập lại!");

		userController.login(email, pass);
	}

}
