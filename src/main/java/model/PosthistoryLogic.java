package model;

import dao.HistoryDAO;

public class PosthistoryLogic {
	public void execute(History history){
		HistoryDAO dao = new HistoryDAO();
		dao.historyaddition(history);//閲覧履歴をDBに

	}

}
