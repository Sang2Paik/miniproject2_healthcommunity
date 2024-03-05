package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import service.MyBatisConnector;
import vo.FoodVo;
import vo.MealTypeVo;

public class FoodDao {
	
	static FoodDao single = null;
	SqlSessionFactory factory;

	public static FoodDao getInstance() {

		if (single == null)
			single = new FoodDao();
		return single;
	}

	private FoodDao() {
		
		factory = MyBatisConnector.getInstance().getSqlSessionFactory();

	}
	
	// 음식 찾기의 리스트 보여주기
	public List<FoodVo> selectList(String f_name){
		
		List<FoodVo> food_list = null;
		
		SqlSession sqlSession = factory.openSession();
		
		food_list = sqlSession.selectList("food.food_select_list", f_name);
		
		sqlSession.close();
		
		return food_list;
	}
	
	// 식사 타입 리스트
	public List<MealTypeVo> selectList(){
		
		List<MealTypeVo> meal_type_list = null;
		
		SqlSession sqlSession = factory.openSession();
		
		meal_type_list = sqlSession.selectList("food.meal_type_list");
		
		sqlSession.close();
		
		return meal_type_list;
	}
	
	// 음식 담기의 리스트 보여주기
	public List<FoodVo> add_selectList(int user_idx) {
		// TODO Auto-generated method stub
		
		List<FoodVo> add_food_list = null;
		
		SqlSession sqlSession = factory.openSession();
		
		add_food_list = sqlSession.selectList("food.add_selectList", user_idx);
		
		sqlSession.close();
		
		return add_food_list;

	}
	
	//음식 담기에서 중복된 항목이 있는지 체크
	public FoodVo selectOne(FoodVo vo) {
		// TODO Auto-generated method stub
		
		FoodVo findVo = new FoodVo();
		
		SqlSession sqlSession = factory.openSession();
		
		findVo = sqlSession.selectOne("food.find_check_vo", vo);
		
		sqlSession.close();
		
		return findVo;
	}
	
	// 컴펌된 음식의 음식 담기에서 중복된 항목이 있는지 체크
	public FoodVo selectOneModify(FoodVo vo) {
		// TODO Auto-generated method stub
		
		FoodVo findVo = new FoodVo();
		
		SqlSession sqlSession = factory.openSession();
		
		findVo = sqlSession.selectOne("food.find_check_vo_modify", vo);
		
		sqlSession.close();
		
		return findVo;
	}
	
	//음식 담기
	public int insert(FoodVo vo) {
		// TODO Auto-generated method stub
		
		int res = 0;
		
		SqlSession sqlSession = factory.openSession(true);
		
		res = sqlSession.insert("food.add_food", vo);
		
		sqlSession.close();
		
		return res;
	}

	// 음식 담기에서 삭제
	public int delete(int f_idx) {
		// TODO Auto-generated method stub
		int res = 0;
		
		SqlSession sqlSession = factory.openSession(true);
		
		res = sqlSession.delete("food.delete_food", f_idx);
		
		sqlSession.close();
		
		return res;
	}

	public int selectFoodNo() {
		// TODO Auto-generated method stub
		
		int f_no = 0;
		
		SqlSession sqlSession = factory.openSession();
		
		f_no = sqlSession.selectOne("food.f_no_select");
		
		sqlSession.close();
		
		return f_no;
	}

	public int update(FoodVo vo) {
		// TODO Auto-generated method stub
		int res = 0;
		
		SqlSession sqlSession = factory.openSession(true);
		
		res = sqlSession.insert("food.food_confirm_update", vo);
		
		sqlSession.close();
		
		return res;
	}

	public List<FoodVo> confirm_selectList(int user_idx) {
		// TODO Auto-generated method stub
		
		List<FoodVo> food_record_list= null;
		
		SqlSession sqlSession = factory.openSession();
		
		food_record_list = sqlSession.selectList("food.confirm_food_list", user_idx);
		
		sqlSession.close();
		
		return food_record_list;
	}
	
	
	// 백상희 수정 20240228
	public double today_f_cal(int user_idx) {
		// TODO Auto-generated method stub
		Double today_cal = 0.0;
		
		SqlSession sqlSession = factory.openSession();
		
		today_cal = sqlSession.selectOne("food.today_cal", user_idx);
		
		if(today_cal == null)
			today_cal = 0.0;
		
		sqlSession.close();
		
		return today_cal;
	}

	public List<FoodVo> foodChartList(int user_idx) {
		// TODO Auto-generated method stub
		
		List<FoodVo> food_chart_list= null;
		
		SqlSession sqlSession = factory.openSession();
		
		food_chart_list = sqlSession.selectList("food.food_chart_list", user_idx);
		
		sqlSession.close();
		
		return food_chart_list;
	}

	public int cf_delete(int f_no) {
		// TODO Auto-generated method stub
		int res = 0;
		
		SqlSession sqlSession = factory.openSession(true);
		
		res = sqlSession.delete("food.confirm_food_delete", f_no);
		
		sqlSession.close();
		
		return res;
	}

	public int updateConfirmFood(int f_no) {
		// TODO Auto-generated method stub
		int res = 0;
		
		SqlSession sqlSession = factory.openSession(true);
		
		res = sqlSession.update("food.confirm_food_modify", f_no);
		
		sqlSession.close();
		
		return res;
	}

	// 수정된 담기 리스트 보여주기
	public List<FoodVo> modifyList(int f_no) {
		
		// TODO Auto-generated method stub
		List<FoodVo> modify_food_list = null;
		
		SqlSession sqlSession = factory.openSession();
		
		modify_food_list = sqlSession.selectList("food.modify_food_select_list", f_no);
		
		sqlSession.close();
		
		return modify_food_list;
	}
	// 수정한 리스트를 f_confirm 을 Y로 변경해주기
	public int modify_update(int f_idx) {
		// TODO Auto-generated method stub
		int res = 0;
		
		SqlSession sqlSession = factory.openSession(true);
		
		res = sqlSession.update("food.food_modify_list_update", f_idx);
		
		sqlSession.close();
		
		return res;
	}

	public int updateModify(FoodVo vo) {
		// TODO Auto-generated method stub
		int res = 0;
		
		SqlSession sqlSession = factory.openSession(true);
		
		res = sqlSession.insert("food.food_modify_insert", vo);
		
		sqlSession.close();
		
		return res;
	}

	// 컴펌된 리스트를 수정하기 위해서 담기 리스트에 가져와 Y->N으로 수정
	public int modifyYtoN(int f_idx) {
		// TODO Auto-generated method stub
		int res = 0;
		
		SqlSession sqlSession = factory.openSession(true);
		
		res = sqlSession.update("food.modify_y_to_n", f_idx);
		
		sqlSession.close();
		
		return res;
	}

	public int modifyBasicInfo(FoodVo vo) {
		// TODO Auto-generated method stub
		int res = 0;
		
		SqlSession sqlSession = factory.openSession(true);
		
		res = sqlSession.update("food.modify_basic_info", vo);
		
		sqlSession.close();
		
		return res;
	}
	

	



	

	

	


	
}
