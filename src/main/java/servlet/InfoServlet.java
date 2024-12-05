package servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.InfoDAO;
import model.Info;
import model.User;

@WebServlet("/InfoServlet")
public class InfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");

		// セッションが無効な場合、ログイン画面にリダイレクト
		if (loginUser == null) {
			response.sendRedirect("index.jsp");
			return;
		}

		InfoDAO dao = new InfoDAO();

		// クリックされた通知IDを取得
//		String infoId = request.getParameter("infoId");
//		
//		        if (infoId != null) {
//		            // 通知を削除
//		            dao.deleteNotification(Integer.parseInt(infoId));
//		            System.out.println("sakujo");
//		        }
//		if (dao.deleteInfo()) {
//			System.out.println("ok");
//		} else {
//			System.out.println("ng");
//		}

		// 再度通知リストを取得
		List<Info> info = dao.getNotifications(loginUser.getUSERID());
		request.setAttribute("info", info);
		for(Info i : info) {
			System.out.println(i.getInfoId());
		}

		request.getRequestDispatcher("jsp/t-home.jsp").forward(request, response);

	}

}
