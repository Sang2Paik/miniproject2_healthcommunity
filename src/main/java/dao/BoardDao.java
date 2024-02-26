package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import service.MyBatisConnector;
import vo.BoardVo;

public class BoardDao {

	SqlSessionFactory factory;
	
	static BoardDao single = null;

	public static BoardDao getInstance() {

		if (single == null)
			single = new BoardDao();
		return single;
	}

	private BoardDao() {
		// TODO Auto-generated constructor stub
		factory = MyBatisConnector.getInstance().getSqlSessionFactory();
	}
	
	//게시글조회
	public List<BoardVo> selectList(){
		
		List<BoardVo> list = null;
		
		//1.SqlSession 얻어오기
		SqlSession sqlSession = factory.openSession();
		
		//2.수행
		list = sqlSession.selectList("board.board_list");
		
		//3.닫기
		sqlSession.close();
			
		
		return list;
	}
	
	public List<BoardVo> selectList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		List<BoardVo> list = null;
		
		//1.SqlSession 얻어오기
		SqlSession sqlSession = factory.openSession();
		
		//2.수행
		list = sqlSession.selectList("board.board_condition_list", map);
		
		//3.닫기
		sqlSession.close();
			
		
		return list;
	}
	
	//같은 카테고리 이름의 보드리스트 가져오기
	public List<BoardVo> selectListCategoryName(String c_name) {
		// TODO Auto-generated method stub
		
		List<BoardVo> list = null;
		
		SqlSession sqlSession = factory.openSession(true);
		//작업수행
		list = sqlSession.selectList("board.board_list_c_name", c_name);
		//닫기
		sqlSession.close();
		
		return list;
	}
	

	//게시물 1건 얻어오기
	public BoardVo selectOne(int b_idx) {
		// TODO Auto-generated method stub
		BoardVo vo = null;
		
		//1.SqlSession 얻어오기
		SqlSession sqlSession = factory.openSession();
		
		//2.수행
		vo = sqlSession.selectOne("board.board_one", b_idx);
		
		//3.닫기
		sqlSession.close();
		
		return vo;
	}
	
	//등록시킬 게시물의 번호 얻어오기
	public int selectOneB_idx() {
		// TODO Auto-generated method stub
		int b_idx=0;
		
		//1.SqlSession 얻어오기
		SqlSession sqlSession = factory.openSession();
		
		//2.수행
		b_idx = sqlSession.selectOne("board.board_b_idx");
		
		//3.닫기
		sqlSession.close();
		
		return b_idx;
	}

	public int insert(BoardVo vo) {
		// TODO Auto-generated method stub
		int res = 0;
		
		//1.SqlSession 얻어오기                    true <- auto commit
		SqlSession sqlSession = factory.openSession(true);
		
		//2.수행
		res = sqlSession.insert("board.board_insert", vo);
		
		//3.닫기
		sqlSession.close();
		
		
		return res;
	}

	public int update_readhit(int b_idx) {
		// TODO Auto-generated method stub
		int res = 0;
		
		//1.SqlSession 얻어오기                    true <- auto commit
		SqlSession sqlSession = factory.openSession(true);
		
		//2.수행
		res = sqlSession.update("board.board_update_readhit", b_idx);
		
		//3.닫기
		sqlSession.close();
		
		
		return res;
	}

	public int update_step(BoardVo baseVo) {
		// TODO Auto-generated method stub
		int res = 0;
		
		//1.SqlSession 얻어오기                    true <- auto commit
		SqlSession sqlSession = factory.openSession(true);
		
		//2.수행
		res = sqlSession.update("board.board_update_step", baseVo);
		
		//3.닫기
		sqlSession.close();
		
		
		return res;
	}

	public int reply(BoardVo vo) {
		// TODO Auto-generated method stub
		int res = 0;
		
		//1.SqlSession 얻어오기                    true <- auto commit
		SqlSession sqlSession = factory.openSession(true);
		
		//2.수행
		res = sqlSession.insert("board.board_reply", vo);
		
		//3.닫기
		sqlSession.close();
		
		
		return res;
	}

	public int BoardDelete(int b_idx) {
		// TODO Auto-generated method stub
		int res = 0;
		
		//1.SqlSession 얻어오기                    true <- auto commit
		SqlSession sqlSession = factory.openSession(true);
		
		//2.수행
		res = sqlSession.update("board.board_delete", b_idx);
		
		//3.닫기
		sqlSession.close();
		
		
		return res;
	}

	public int update(BoardVo vo) {
		// TODO Auto-generated method stub
		int res = 0;
		
		//1.SqlSession 얻어오기                    true <- auto commit
		SqlSession sqlSession = factory.openSession(true);
		
		//2.수행
		res = sqlSession.update("board.board_modify_update", vo);
		
		//3.닫기
		sqlSession.close();
		
		
		return res;
	}

	public int selectRowTotal() {
		// TODO Auto-generated method stub
		int rowTotal = 0;
		
		//1.SqlSession 얻어오기
		SqlSession sqlSession = factory.openSession();
		
		//2.수행
		rowTotal = sqlSession.selectOne("board.board_row_total");
		
		//3.닫기
		sqlSession.close();
		
		
		return rowTotal;
	}

	public int selectRowTotal(Map<String, Object> map) {
		// TODO Auto-generated method stub
		int rowTotal = 0;
		
		//1.SqlSession 얻어오기
		SqlSession sqlSession = factory.openSession();
		
		//2.수행
		rowTotal = sqlSession.selectOne("board.board_condition_row_total",map);
		
		//3.닫기
		sqlSession.close();
		
		
		return rowTotal;
	}

	public int update_b_photo(BoardVo vo) {
		// TODO Auto-generated method stub
		
		int res = 0;
		
		SqlSession sqlSession = factory.openSession(true);
		
		sqlSession.update("board.board_b_photo_update", vo);
		
		sqlSession.close();
		
		return res;
	}

	public int update_like(BoardVo vo) {
		// TODO Auto-generated method stub
		int res = 0;
		
		SqlSession sqlSession = factory.openSession(true);
		
		sqlSession.update("board.board_like_update", vo);
		
		sqlSession.close();
		
		return res;
	}

	
	
	
	
	
	
	
}
