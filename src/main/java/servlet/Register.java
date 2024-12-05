package servlet;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import model.GetUserLogic;
import model.PostUserLogic;
import model.User;

@WebServlet("/Register")
@MultipartConfig // マルチパートデータの処理を有効化
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("jsp/register.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//リクエストパラメータの取得
		request.setCharacterEncoding("UTF-8");
		int USERID = Integer.parseInt(request.getParameter("USERID"));//新規ユーザーID
		String PASS = request.getParameter("PASS");//新規PW
		String NAME = request.getParameter("NAME");
		//		String ICON = request.getParameter("icon");
		String CLASS = request.getParameter("CLASS");
		int TYPEID =  Integer.parseInt(request.getParameter("TYPEID"));   
		String MAIL = request.getParameter("MAIL");

		
			System.out.println(CLASS);
		// 画像データの取得
		Part filePart = request.getPart("ICON"); // JSPのファイルフィールド名に一致させる
		InputStream iconInputStream = filePart.getInputStream(); // ファイルのInputStream

		//Userインスタンス（ユーザー情報）の生成
		User user = new User(USERID, NAME,PASS, CLASS, MAIL, iconInputStream, TYPEID);

		GetUserLogic getUserLogic = new GetUserLogic();
		PostUserLogic postUserLogic = new PostUserLogic();
		boolean userCheck = true;
		List<User> userList = getUserLogic.execute();
		if (userList != null) {
			for (User us : userList) {
				if (us.getUSERID() == USERID) {
					request.setAttribute("msg", "すでに登録済みのIDです");
					userCheck = false;
					break;

				}
			}
		}

		if (userCheck) {
			if (postUserLogic.execute(user)) {
				request.setAttribute("msg", "新規登録に成功しました<br>");
			} else {
				request.setAttribute("msg", "新規登録に失敗しました<br>");
				userCheck = false;
			}
		}

		request.setAttribute("userList", userList);
		if (userCheck) {
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
			rd.forward(request, response);
		} else {
			RequestDispatcher rd = request.getRequestDispatcher("jsp/register.jsp"); //パスは修正する
			rd.forward(request, response);
		}

	}

}
