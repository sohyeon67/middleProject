package kr.or.ddit.member.dao;

import java.util.List;
import java.util.Map;

import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.ZipVO;

public interface IMemberDao {

	// 메소드 선언

	// 전체 리스트 가져오기
	public List<MemberVO> selectMember();

	// id, pass 검색해서 데이터 가져오기
	public MemberVO selectById(Map<String, Object> map);
	
	public String idCheck(String id);
	
	public List<ZipVO> selectByDong(String dong);
	
	public int insertMember(MemberVO vo);
}
