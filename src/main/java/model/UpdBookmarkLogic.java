package model;

import dao.BookmarkDAO;

public class UpdBookmarkLogic {
	public void upd(Bookmark bookmark) {
		BookmarkDAO dao = new BookmarkDAO();
		dao.bookmarkupd(bookmark);
	}

}
