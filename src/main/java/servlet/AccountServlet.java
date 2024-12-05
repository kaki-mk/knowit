package servlet;

import java.io.IOException;
import java.io.InputStream;
import java.util.Base64;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import dao.UserDAO;
import model.PostUserLogic;
import model.User;

@WebServlet("/AccountServlet")
@MultipartConfig // マルチパートデータの処理を有効化
public class AccountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// リクエストパラメータの取得
		request.setCharacterEncoding("UTF-8");
		String NAME = request.getParameter("NAME");
		String PASS = request.getParameter("PASS");

		// 画像データの取得
		Part filePart = request.getPart("ICON"); // JSPのファイルフィールド名に一致させる
		InputStream iconInputStream = filePart.getInputStream(); // ファイルのInputStream

		// ログインユーザーの取得
		HttpSession sess = request.getSession();
		User loginUser = (User) sess.getAttribute("loginUser");
		User user = new User(loginUser.getUSERID(), NAME, PASS, loginUser.getCLASS(),
				loginUser.getMAIL(), iconInputStream, loginUser.getTYPEID());

		// AccountServletの変更後のコード
		PostUserLogic postUserLogic = new PostUserLogic();
		if (postUserLogic.account(user)) {
		    request.setAttribute("msg", "アカウント情報の変更完了");

		    // ユーザーアイコンの再取得とBase64エンコード
		    UserDAO userDAO = new UserDAO();
		    try {
		        byte[] iconData = userDAO.getUserIcon(user.getUSERID());
		        if (iconData != null) {
		            String base64Image = Base64.getEncoder().encodeToString(iconData);
		            request.setAttribute("base64Image", base64Image);
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		        request.setAttribute("msg", "アイコンの取得に失敗しました");
		    }

		    sess.setAttribute("loginUser", user);

		} else {
		    request.setAttribute("msg", "アカウント情報の変更に失敗しました");
		}

		RequestDispatcher rd = request.getRequestDispatcher("jsp/accountTM.jsp");
		rd.forward(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		IconServlet icon = new IconServlet();
		icon.doGet(request, response);
//		RequestDispatcher rd = request.getRequestDispatcher("account.jsp");
//		rd.forward(request, response);
	}
}
