package kr.or.ddit.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;

@WebServlet("/IdCheck.do")
public class IdCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json; charset=utf-8");
		
		// 전송 데이터 받기
		String userId = request.getParameter("id");
		
		// service
		IMemberService service = MemberServiceImpl.getInstance();
		
		// 메소드 실행
		String res = service.idCheck(userId);
		
		Gson gson = new Gson();
		String flag = null;
		
		if(res==null) {
			flag = gson.toJson("사용 가능 ID");
		} else {
			flag = gson.toJson("사용 불가능 ID");
		}
		
		response.getWriter().write(flag);
		response.flushBuffer();
		//request.setAttribute("result", res);
		
		//request.getRequestDispatcher("/memberview/idcheck.jsp").forward(request, response);
	}

}
