package servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Bookmark;
import model.GetBookmarkLogic;
import model.GethistoryLogic;
import model.History;
import model.PosthistoryLogic;
import model.User;

@WebServlet("/Historyservlet")//メニューバー
public class Historyservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {//これ、ここではないかも
		request.setCharacterEncoding("UTF-8");
		String Q_IDstr = request.getParameter("qId");
		String USER_IDstr = request.getParameter("userId");
		int USER_ID = 0;
		int Q_ID = 0;
		
		 try {
		        if (Q_IDstr != null) Q_ID = Integer.parseInt(Q_IDstr);
		        if (USER_IDstr != null) USER_ID = Integer.parseInt(USER_IDstr);
		    } catch (NumberFormatException e) {
		        e.printStackTrace();
		    }
		
		User user = new User(USER_ID);
		
		//java.sql.Date VIEWTION = null;
		//VIEWTION = java.sql.Date.valueOf(VIEWTIONstr);
		
		History history = new History(USER_ID,Q_ID);
		
		PosthistoryLogic posthistoryLogic = new PosthistoryLogic();
		posthistoryLogic.execute(history);
		GethistoryLogic getHistoryLogic = new GethistoryLogic();
		List<History> historyList = getHistoryLogic.execute(user);
		request.setAttribute("historyList",historyList);

		
		//RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/rireki.jsp");//履歴画面に遷移
		//dispatcher.forward(request, response);
		
		
	}
	
	
	
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loginUser");
		//DAOとかいろんな処理を書く!!たぶん
		
		
		
		GethistoryLogic getHistoryLogic = new GethistoryLogic();
		List<History> historyList = getHistoryLogic.execute(user);
		request.setAttribute("historyList",historyList);
		GetBookmarkLogic getbookmark = new GetBookmarkLogic();
		List<Bookmark> bookmarkList = getbookmark.execute(user);
		request.setAttribute("bookmarkList",bookmarkList);
		

		RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/rireki.jsp");//履歴画面に遷移
		dispatcher.forward(request, response);
		
	
	}

}
