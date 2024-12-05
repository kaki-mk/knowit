package model;

import dao.BookmarkDAO;

public class DeletebookmarkLogic {
	
	public void execute(Bookmark book) {
		BookmarkDAO dao = new BookmarkDAO();
		dao.bookmarkdelete(book);
	}

}
