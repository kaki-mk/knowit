package servlet;

import java.io.IOException;
import java.util.Base64;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.UserDAO;
import model.User;

@WebServlet("/IconServlet")
public class IconServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // セッションからログインユーザーを取得
        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute("loginUser");

        if (loginUser == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not logged in");
            return;
        }

        int userId = loginUser.getUSERID();

        // DAOを使用してアイコンを取得
        UserDAO userDAO = new UserDAO();
        try {
            byte[] iconData = userDAO.getUserIcon(userId);

            if (iconData == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Icon not found for user ID: " + userId);
                return;
            }

            // 画像データをBase64形式にエンコード
            String base64Image = Base64.getEncoder().encodeToString(iconData);

            // JSPに渡すためリクエスト属性に設定
            request.setAttribute("base64Image", base64Image);

            // JSPにフォワード
            RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/accountTM.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while retrieving the icon");
        }
    }
}
