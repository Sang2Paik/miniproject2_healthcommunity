package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import service.MyBatisConnector;
import vo.UserVo;

public class UserDao {

	SqlSessionFactory factory;
	
	static UserDao single = null;

	public static UserDao getInstance() {

		if (single == null)
			single = new UserDao();
		return single;
	}

	private UserDao() {
		// TODO Auto-generated constructor stub
		factory = MyBatisConnector.getInstance().getSqlSessionFactory();
	}
	
	// 목록조회
	public List<UserVo> selectList() {

		List<UserVo> list = null;

		SqlSession sqlSession = factory.openSession(true);
		
		list = sqlSession.selectList("user.user_list");
		
		sqlSession.close();
		
		return list;
		
	}//end:selectList

	public UserVo selectOne(int user_idx) {
		// TODO Auto-generated method stub

		SqlSession sqlSession = factory.openSession(true);
		
		UserVo vobj = sqlSession.selectOne("user.user_list_idx_one", user_idx);
		
		sqlSession.close();
		
		return vobj;
		
	}//end:selectOne(user_idx)
	
	public UserVo selectOne(String user_id) {
		// TODO Auto-generated method stub

		SqlSession sqlSession = factory.openSession(true);
		
		UserVo vo = sqlSession.selectOne("user.user_list_id_one", user_id);
		
		sqlSession.close();
		
		return vo;
		
	}//end:selectOne(user_id)

	public int insert(UserVo vo) {
		// TODO Auto-generated method stub
		int res = 0;
		
		SqlSession sqlSession = factory.openSession(true);
		
		sqlSession.selectOne("user.user_insert", vo);
		
		sqlSession.close();

		return res;
	}

	public int delete(int user_idx) {
		// TODO Auto-generated method stub
		int res = 0;
		
		SqlSession sqlSession = factory.openSession(true);
		
		sqlSession.delete("user.user_delete", user_idx);

		sqlSession.close();
		
		return res;
	}

	public int update(UserVo vo) {
		// TODO Auto-generated method stub
		int res = 0;
		
		SqlSession sqlSession = factory.openSession(true);
		
		sqlSession.delete("user.user_update", vo);

		sqlSession.close();

		return res;
	}
	
	

}
