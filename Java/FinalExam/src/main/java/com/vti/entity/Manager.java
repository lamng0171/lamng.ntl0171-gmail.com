package com.vti.entity;

public class Manager extends User {
	private int expInYear;

	public Manager() {

	}

	public Manager(int expInYear, String firstName, String lastName, String phone, String email) throws Exception {
		super(firstName, lastName, phone, email);
		this.expInYear = expInYear;
	}

	public int getExpInYear() {
		return expInYear;
	}
}
