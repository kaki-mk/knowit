package servlet;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.LoginLogic;
import model.User;


/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Login() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//リクエストパラメータの取得
		request.setCharacterEncoding("UTF-8");
		int USERID = Integer.parseInt(request.getParameter("USERID"));
		String PASS = request.getParameter("PASS");

		//Userインスタンス（ユーザー情報）の生成
		User user = new User(USERID, PASS);

		//ログイン処理
		LoginLogic loginLogic = new LoginLogic();
		boolean isLogin = loginLogic.execute(user);
		
		//追記
		
		try {
		//ログイン成功時の処理
		if (isLogin) {

			
			//ユーザー情報をセッションスコープに保存
			HttpSession sess = request.getSession();
			sess.setAttribute("loginUser",loginLogic.findUser(USERID, PASS));
			
			
			//学生
			if(loginLogic.findType(USERID) == 102) {
				RequestDispatcher rd = request.getRequestDispatcher("jsp/S_Home.jsp");
				rd.forward(request, response);
			//先生
			}else if(loginLogic.findType(USERID) == 101){
//				ChatListServlet chatlist = new ChatListServlet();
//				chatlist.doGet(request, response);
				InfoServlet info = new InfoServlet();
				info.doGet(request, response);
			}

		}else {
			//ログイン画面にフォワード
			request.setAttribute("errorMsg", "※IDまたはパスワードが正しくありません");
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
			rd.forward(request, response);
			
		}
		}catch(Exception e) {
			e.printStackTrace(); // エラーログに出力
		}

		
		
	}

}
