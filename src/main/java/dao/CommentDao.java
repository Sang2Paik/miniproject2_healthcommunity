package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import service.MyBatisConnector;
import vo.CommentVo;

public class CommentDao {
	
	SqlSessionFactory factory;
	
	static CommentDao single = null;

	public static CommentDao getInstance() {

		if (single == null)
			single = new CommentDao();
		return single;
	}

	private CommentDao() {
		// TODO Auto-generated constructor stub
		factory = MyBatisConnector.getInstance().getSqlSessionFactory();	
	}
	
	public List<CommentVo> selectList(int b_idx){
		List<CommentVo> list = null;
		//sqlSession 얻어오기
		SqlSession sqlSession = factory.openSession();
		//작업수행
		list = sqlSession.selectList("comment.comment_list",b_idx);
		//닫기
		sqlSession.close();
		
		return list;
	}
	
	public List<CommentVo> selectList(Map<String, Object> map) {
		List<CommentVo> list = null;
		//sqlSession 얻어오기
		SqlSession sqlSession = factory.openSession();
		//작업수행
		list = sqlSession.selectList("comment.comment_condition_list", map);
		//닫기
		sqlSession.close();
		
		return list;
	}
	
	public int selectRowCount(int b_idx) {
		int res = 0;
		//sqlSession 얻어오기
		SqlSession sqlSession = factory.openSession();
		//작업수행
		res = sqlSession.selectOne("comment.comment_row_total", b_idx);
		//닫기
		sqlSession.close();
		
		return res;
	}
	
	public int insert(CommentVo vo) {
		
		int res = 0;
		//sqlSession 얻어오기                          auto commit
		SqlSession sqlSession = factory.openSession(true);
		//작업수행
		res = sqlSession.insert("comment.comment_insert",vo);
		//닫기
		sqlSession.close();
		return res;
	}
	
	public int delete(int cmt_idx) {
		
		int res = 0;
		//sqlSession 얻어오기                          auto commit
		SqlSession sqlSession = factory.openSession(true);
		//작업수행
		res = sqlSession.delete("comment.comment_delete", cmt_idx);
		//닫기
		sqlSession.close();
		
		return res;
	}

	public int delete_b_idx(int b_idx) {
		// TODO Auto-generated method stub
		int res = 0;
		//sqlSession 얻어오기                          auto commit
		SqlSession sqlSession = factory.openSession(true);
		//작업수행
		res = sqlSession.delete("comment.comment_delete_b_idx", b_idx);
		//닫기
		sqlSession.close();
		
		return res;
	}

	
	
}
