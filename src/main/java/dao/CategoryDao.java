package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import service.MyBatisConnector;
import vo.CategoryVo;

public class CategoryDao {
	
	SqlSessionFactory factory;
	static CategoryDao single = null;

	public static CategoryDao getInstance() {

		if (single == null)
			single = new CategoryDao();
		return single;
	}

	private CategoryDao() {
		// TODO Auto-generated constructor stub
		factory = MyBatisConnector.getInstance().getSqlSessionFactory();
	}
	
	public List<CategoryVo> selectList() {
		List<CategoryVo> list = null;
		//sql얻어오기
		SqlSession sqlSession = factory.openSession(true);
		//작업수행
		list = sqlSession.selectList("category.category_list");
		//닫기
		sqlSession.close();
		
		return list;
		
	}
	
	public String selectListName(int c_idx) {
		// TODO Auto-generated method stub
		
		SqlSession sqlSession = factory.openSession();
		
		String c_name = sqlSession.selectOne("category.category_search_c_name",c_idx);
		
		sqlSession.close();
		
		return c_name;
	}
	
	public int selectInsert(String c_name) {
		int res = 0;
		//sql얻어오기
		SqlSession sqlSession = factory.openSession(true);
		//작업수행
		res = sqlSession.insert("category.category_insert", c_name);
		//닫기
		sqlSession.close();
		
		return res;
	} 
	
	public int selectDelete(int c_idx) {
		int res = 0;
		
		SqlSession sqlSession = factory.openSession(true);
		//작업수행
		res = sqlSession.delete("category.category_delete", c_idx);
		//닫기
		sqlSession.close();
		
		return res;
		
	}

	public int selectOne(String c_name) {
		// TODO Auto-generated method stub
		int res;
		
		SqlSession sqlSession = factory.openSession(true);
		//작업수행
		res = sqlSession.selectOne("category.category_search_c_idx", c_name);
		//닫기
		sqlSession.close();
		
		return res;
	}

	
	
}
