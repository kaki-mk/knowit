package model;

import java.util.List;

import dao.HistoryDAO;
//import servlet.History;

public class GethistoryLogic {

	public List<History> execute(User user){
		HistoryDAO dao = new HistoryDAO();
		List<History> historyList = dao.findAll(user);
		return historyList;

	}
	
}
