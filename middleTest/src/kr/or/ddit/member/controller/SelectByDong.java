package kr.or.ddit.member.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.ZipVO;

@WebServlet("/SelectByDong.do")
public class SelectByDong extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		// 전송 데이터 받기 - dong
		String dong = request.getParameter("dong");
		
		// service객체
		IMemberService service = MemberServiceImpl.getInstance();
		
		// service 메소드 호출 - List
		List<ZipVO> list = service.selectByDong(dong);
		
		// list결과를 저장
		request.setAttribute("result", list);
		
		// jsp view 페이지 설정 - forward
		request.getRequestDispatcher("/memberview/selectDong.jsp").forward(request, response);
		
	}

}
