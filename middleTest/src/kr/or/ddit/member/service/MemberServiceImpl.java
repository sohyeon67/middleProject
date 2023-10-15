package kr.or.ddit.member.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.member.dao.IMemberDao;
import kr.or.ddit.member.dao.MemberDaoImpl;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.ZipVO;


/*
 * dao객체가 필요
 * Singleton을 위한 자기 자신의 객체를 생성해서 리턴하는 메서드 필요
 * 
 */
public class MemberServiceImpl implements IMemberService {

	private IMemberDao dao;
	private static IMemberService service;
	
	// 생성자
	private MemberServiceImpl() {
		dao = MemberDaoImpl.getInstance();
	}
	
	public static IMemberService getInstance() {
		if(service == null) service = new MemberServiceImpl();
		
		return service;
	}
	
	@Override
	public List<MemberVO> selectMember() {
		
//		List<MemberVO> list = null;
//		list = dao.selectMember();
//		return list;
		
		return dao.selectMember();
	}

	@Override
	public MemberVO selectById(Map<String, Object> map) {
		MemberVO vo = null;
		
		vo = dao.selectById(map);
		
		return vo;
	}

	@Override
	public String idCheck(String id) {
		return dao.idCheck(id);
	}

	@Override
	public List<ZipVO> selectByDong(String dong) {
		return dao.selectByDong(dong);
	}

	@Override
	public int insertMember(MemberVO vo) {
		return dao.insertMember(vo);
	}

}
