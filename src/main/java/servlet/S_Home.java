package servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import model.CallPythonScript;

/**
 * Servlet implementation class S_Home
 */
@WebServlet("/S_Home")
@MultipartConfig
public class S_Home extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public S_Home() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		// アップロードされたファイルを取得
		Part filePart = request.getPart("image");
		if (filePart != null && filePart.getSize() > 0) {
			// 画像を保存するパスを指定
			String fileName = filePart.getSubmittedFileName();
			String uploadPath = "D:\\pleiades\\2024-09\\workspace\\knowit\\src\\main\\webapp\\WEB-INF\\img"
					+ File.separator + fileName;
			// ディレクトリが存在しない場合は作成
			File uploadDir = new File("D:\\pleiades\\2024-09\\workspace\\knowit\\src\\main\\webapp\\WEB-INF\\img");
			if (!uploadDir.exists()) {
				uploadDir.mkdir();
			}

			// アップロードされたファイルを保存
			try (InputStream inputStream = filePart.getInputStream();
					FileOutputStream outputStream = new FileOutputStream(uploadPath)) {
				byte[] buffer = new byte[1024];
				int bytesRead;
				while ((bytesRead = inputStream.read(buffer)) != -1) {
					outputStream.write(buffer, 0, bytesRead);
				}
			}
			CallPythonScript cps = new CallPythonScript();
			cps.execute(fileName);
			request.setAttribute("fileName", fileName);
		}

//		RequestDispatcher rd = request.getRequestDispatcher("WEB-INF\\jsp\\kaisetusentaku.jsp");
		RequestDispatcher rd = request.getRequestDispatcher("jsp/a-sentaku.jsp");
		rd.forward(request, response);
		// 処理後のページにリダイレクト（必要に応じて変更）
	}
}
