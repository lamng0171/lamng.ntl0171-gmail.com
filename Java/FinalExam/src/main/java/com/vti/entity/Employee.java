package com.vti.entity;

public class Employee extends User {
	private String projectName;
	private String proSkill;

	public Employee() {

	}

	public Employee(String firstName, String lastName, String phone, String email, String projectName,
			String proSkill) {
		super(firstName, lastName, phone, email);
		this.projectName = projectName;
		this.proSkill = proSkill;
	}

	public String getProjectName() {
		return projectName;
	}

	public String getProSkill() {
		return proSkill;
	}
}
