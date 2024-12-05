package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.InfoDAO;
import model.Info;
import model.User;

@WebServlet("/InfoDeleteServlet")
public class InfoDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");

		// セッションが無効な場合、ログイン画面にリダイレクト
		if (loginUser == null) {
			response.sendRedirect("jsp/index.jsp");
			return;
		}

		InfoDAO dao = new InfoDAO();

		// クリックされた通知IDを取得
		String infoId = request.getParameter("infoId");   
		System.out.println(infoId);
		Info info = dao.getNotificationById(Integer.parseInt(infoId));
		
		        if (infoId != null) {
		            // 通知を削除
		            dao.deleteNotification(Integer.parseInt(infoId));
		            System.out.println("sakujo");
		        }
		   
		//
		
//		if (dao.deleteInfo()) {
//			System.out.println("ok");
//		} else {
//			System.out.println("ng");
//		}
		
		
		request.setAttribute("senderId", info.getRecipientId());
		        
		System.out.println(info.getSenderId());
		System.out.println(info.getRecipientId());
		request.setAttribute("recipientId", info.getSenderId());

		request.getRequestDispatcher("jsp/chat.jsp").forward(request, response);

	}

}
