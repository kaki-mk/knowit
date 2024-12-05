package model;

import java.util.List;


public class LoginLogic {
	GetUserLogic getUserLogic = new GetUserLogic();
	
	public boolean execute(User user) {
		
		List<User> userList = getUserLogic.execute();
		for(User u : userList) {
			if(u.getUSERID() == user.getUSERID()) {
				if(u.getPASS().equals(user.getPASS())) {
					return true;
				}
			}
		}
		return false;
	}
	
	
	public int findType(int userId) {
		return getUserLogic.findType(userId);
	}
	
	public User findUser(int userId, String pass) {
		return getUserLogic.findUser(userId, pass);
	}
}
