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
import model.DeletebookmarkLogic;
import model.GetBookmarkLogic;
import model.PostbookmarkLogic;
import model.User;

@WebServlet("/Bookmarkservlet")//メニューバー
public class Bookmarkservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {//これ、ここではないかも
		request.setCharacterEncoding("UTF-8");
		//String USERIDstr = request.getParameter("userid");
		String BOOKIDstr = request.getParameter("bookid");
		String QIDstr = request.getParameter("qid");
		String BMARKstr = request.getParameter("bmark");//一旦Stringで取得
		boolean BMARK = Boolean.parseBoolean(BMARKstr);
		//String VIEWTIONstr = request.getParameter("viewtime");
		/*Part filePart = request.getPart("qimg");
		InputStream QIMG = request.getInputStream();
		String EXPLANATION = request.getParameter("explanation");
		String QTXT = request.getParameter("qtxt");*/
		
		//上記で必要USER_IDとQ_IDだけかも
		
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loginUser");
		
		
		int BOOKID = 0;
		int QID = 0;
		
		try {
			
			if(BOOKIDstr != null) {
				BOOKID = Integer.parseInt(BOOKIDstr);
			}
			
			
		} catch (NumberFormatException e) {
			//数字に変換できない場合の処理
			e.printStackTrace();;
		}

		
		try {
			if(QIDstr != null) {
				QID = Integer.parseInt(QIDstr);
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}

		

		if(BMARK) {
			BMARK = false;
			Bookmark bookmark = new Bookmark(BOOKID,BMARK);
			DeletebookmarkLogic deletebookmarkLogic = new DeletebookmarkLogic();
			deletebookmarkLogic.execute(bookmark);
			GetBookmarkLogic getbookmarkLogic = new GetBookmarkLogic();
			List<Bookmark> bookmarkList = getbookmarkLogic.execute(user);
			request.setAttribute("bookmarkList",bookmarkList);
			RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/bookmarks.jsp");//履歴画面に遷移
			dispatcher.forward(request, response);
			
		}else {
			BMARK = true;
			Bookmark bookmark = new Bookmark(QID,user.getUSERID(),BMARK);
			PostbookmarkLogic postbookmarkLogic = new PostbookmarkLogic();
			postbookmarkLogic.execute(bookmark);
			
			
		}
		

		
		
		
		
		
	}
	
	
	
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loginUser");
		
		
		GetBookmarkLogic getbookmark = new GetBookmarkLogic();
		List<Bookmark> bookmarkList = getbookmark.execute(user);
		request.setAttribute("bookmarkList",bookmarkList);

		RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/bookmarks.jsp");//履歴画面に遷移
		dispatcher.forward(request, response);
		
	
	}

}
