package model;

import java.util.List;

import dao.BookmarkDAO;
//import servlet.History;

public class GetBookmarkLogic {

	public List<Bookmark> execute(User user){
		BookmarkDAO dao = new BookmarkDAO();
		List<Bookmark> bookmarkList = dao.findAll(user);
		return bookmarkList;

	}

}
