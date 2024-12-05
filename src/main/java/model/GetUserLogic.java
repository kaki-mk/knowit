package model;

import java.util.List;

import dao.UserDAO;

public class GetUserLogic {
	UserDAO dao = new UserDAO();
	public List<User>  execute(){
		
		List<User> userList = dao.findAll();
		return userList;
	}
	
	public int findType(int userId) {
		return dao.findType(userId);
	}
	
	public User findUser(int userId, String pass) {
		return dao.findUser(userId, pass);
	}
}