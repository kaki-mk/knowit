package model;

import dao.BookmarkDAO;

public class PostbookmarkLogic {
	public void  execute(Bookmark bookmark) {
		BookmarkDAO dao = new BookmarkDAO();
		dao.bookmarkaddition(bookmark);
		
	}

}
