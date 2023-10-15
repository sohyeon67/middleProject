package kr.or.ddit.member.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberVO;

/**
 * Servlet implementation class SelectById
 */
@WebServlet("/SelectById.do")
public class SelectById extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SelectById() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		
		// 클라이언트 요청시 전송데이터 받기
		String userId = request.getParameter("id");
		String userPass = request.getParameter("pass");
		
		// service객체 얻기
		IMemberService service = MemberServiceImpl.getInstance();
		
		// service메소드 호출하기 - 결과값 받기 - MemberVO
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", userId);
		map.put("pass", userPass);
		MemberVO vo = service.selectById(map);
		
		// 결과값을 view페이지로 이동하기 위해 저장
		request.setAttribute("result", vo);
		
		// forward를 위한 객체 생성
		request.getRequestDispatcher("/memberview/viewSelectOne.jsp").forward(request, response);
		
		
	}

}
