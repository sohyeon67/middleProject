package kr.or.ddit.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.ZipVO;
import kr.or.ddit.mybatis.config.MyBatisUtil;

/*
 * Data Access Object
 * SqlSession객체가 필요
 * Singleton을 위한 자신의 객체를 생성해서 리턴하는 메서드 필요
 */

public class MemberDaoImpl implements IMemberDao {

	private static IMemberDao dao;
	private SqlSession session;
	
	// 생성자

	public static IMemberDao getInstance() {
		if (dao == null) dao = new MemberDaoImpl();

		return dao;
	}

	@Override
	public List<MemberVO> selectMember() {
		session = MyBatisUtil.getSqlSession();
		List<MemberVO> list = null;
		
		try {
			list = session.selectList("member.selectMember");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.commit();
			session.close();
		}

		return list;
	}

	@Override
	public MemberVO selectById(Map<String, Object> map) {
		session = MyBatisUtil.getSqlSession();
		MemberVO vo = null;
		
		try {
			vo = session.selectOne("member.selectById", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.commit();
			session.close();
		}
		return vo;
	}

	// id중복체크
	@Override
	public String idCheck(String id) {
		session = MyBatisUtil.getSqlSession();
		String res = null;
		
		try {
			res = session.selectOne("member.idCheck", id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.commit();
			session.close();
		}
		
		return res;
	}

	// 우편번호 찾기
	@Override
	public List<ZipVO> selectByDong(String dong) {
		session = MyBatisUtil.getSqlSession();
		List<ZipVO> list = null;
		
		try {
			list = session.selectList("member.selectByDong", dong);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.commit();
			session.close();
		}
		
		return list;
	}

	@Override
	public int insertMember(MemberVO vo) {
		session = MyBatisUtil.getSqlSession();
		int cnt = 0;
		
		try {
			cnt = session.insert("member.insertMember", vo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.commit();
			session.close();
		}
		
		return cnt;
	}

}
