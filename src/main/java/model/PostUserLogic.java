package model;

import dao.UserDAO;

public class PostUserLogic {
	UserDAO dao = new UserDAO();

	public boolean execute(User user) {

		if (dao.create(user)) {
			return true;
		}
		return false;

	}

	public boolean account(User user) {
		if (dao.account(user)) {
			return true;
		}
		return false;
	}
}
