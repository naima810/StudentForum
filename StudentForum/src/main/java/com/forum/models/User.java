package com.forum.models;

public class User {
	
	private int uId;
	private String uName;
	private String uEmail;
	private String hashedPassword;

	public User() {}
	
	public User(int uId,String uName, String uEmail, String hashedPassword) {
		this.uId = uId;
		this.uName = uName;
		this.uEmail = uEmail;
		this.hashedPassword = hashedPassword;		
	}
	
	public int getId() {return uId; }
	public void setId(int uId) { this.uId = uId;  }
	
	public String getName() {return uName;}
	public void setName(String uName) { this.uName = uName; }
	
	public String getEmail() { return uEmail; }
	public void setEmail(String uEmail) { this.uEmail = uEmail; }
	
	public String getPassword() { return hashedPassword; }
	public void setPassword(String hashedPassword) { this.hashedPassword = hashedPassword; }

}
