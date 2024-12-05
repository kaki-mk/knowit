package servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.UserDAO;
import model.User;

@WebServlet("/ChatListServlet")
public class ChatListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // セッションからユーザー情報を取得
        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute("loginUser");
        
        if (loginUser == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        
        int senderId = loginUser.getUSERID();
        
        // チャット履歴を取得
        UserDAO userDAO = new UserDAO();
        List<User> chatUsers = userDAO.getChatUsers(senderId);  // チャットしたユーザーのリストを取得
        
        // チャット履歴が存在しない場合、typeid = 101 のユーザーを取得
        if (chatUsers.isEmpty()) {
            chatUsers = userDAO.getUsersByTypeId(101);  // typeid = 101 のユーザーを取得
        }
        
        // チャットユーザーリストをリクエストにセット
        request.setAttribute("chatUsers", chatUsers);
        
        // チャットリスト画面に遷移
        request.getRequestDispatcher("jsp/chatlist.jsp").forward(request, response);
    }
}
