package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import service.MyBatisConnector;
import vo.WorkoutCaloryVo;
import vo.WorkoutVo;

public class WorkoutDao {

	//MyBatis 사용 위한 인터페이스 불러오기
	SqlSessionFactory factory;
	
	static WorkoutDao single = null; //자기자신의 값을 담는 변수

	public static WorkoutDao getInstance() { //DBService의 객체 요청

		if (single == null)
			single = new WorkoutDao(); //처음 요청시에는 만들어서 줌, static이므로 하나만 만들어짐, 두번째 요청시에는 single null아니므로 이전에 만들어진 정보 반환 (결국 같은 객체)

		return single; //만들어진 객체를 리턴

	} //singleton! (요청이 몇번 들어올지 모르기 때문에 싱글톤으로)
	
	private WorkoutDao() { //private생성자 -> singleton으로만 생성해라
		// TODO Auto-generated constructor stub
		//getInstance() : 자바에서 싱글톤 쓰는 방법(그냥 문법)
		factory = MyBatisConnector.getInstance().getSqlSessionFactory();
	}

	public int insert(WorkoutVo vo) {
		// TODO Auto-generated method stub
		int res = 0;
		
		//1. SqlSession얻어오기                      true -> auto commit
		SqlSession sqlSession = factory.openSession(true);
		
		//2.수행
		res = sqlSession.insert("workout.workout_insert", vo);
		
		//3.닫기
		sqlSession.close();
		
		return res;

	}

//	public List<WorkoutVo> selectList() {
//		// TODO Auto-generated method stub
//		List<WorkoutVo> list = null;
//		
//		//1. SqlSession얻어오기
//		SqlSession sqlSession = factory.openSession();
//		
//		//2.수행
//		list = sqlSession.selectList("workout.my_workout_list");
//		
//		//3.닫기
//		sqlSession.close();
//		
//		return list;
//	}
	
	public List<WorkoutVo> selectList(WorkoutVo vo) {
		// TODO Auto-generated method stub
		List<WorkoutVo> list = null; //MyBatis가 만들어줌
		
		//String sql = "select * from workout_kcal where w_regdate=24-02-24 order by idx desc";
		
		//1.sqlSession 얻어오기 (MyBatis 실제 작업객체)
		SqlSession sqlSession= factory.openSession();
		
		//2.작업수행                 namespace.mapper_id
		list = sqlSession.selectList("workout.my_workout_list", vo);
		//System.out.println(list);
		//3.닫기
		sqlSession.close();
		
		return list; //list 내에는 vo에서 가져온 레코드 값이 담겨있음
	}

	public List<WorkoutVo> selectListSearch(WorkoutVo vo) {
		// TODO Auto-generated method stub
		List<WorkoutVo> list = null; //MyBatis가 만들어줌
		
		//String sql = "select * from workout_kcal where w_regdate=24-02-24 order by idx desc";
		
		//1.sqlSession 얻어오기 (MyBatis 실제 작업객체)
		SqlSession sqlSession= factory.openSession();
		
		//2.작업수행                 namespace.mapper_id
		list = sqlSession.selectList("workout.my_workout_list_date", vo);
		//System.out.println(list);
		//3.닫기
		sqlSession.close();
		
		return list; //list 내에는 vo에서 가져온 레코드 값이 담겨있음
	}

	public List<WorkoutVo> selectListCalulate(WorkoutVo vo) {
		// TODO Auto-generated method stub
		List<WorkoutVo> list = null; //MyBatis가 만들어줌
		
		//String sql = "select * from workout_kcal where w_regdate=24-02-24 order by idx desc";
		
		//1.sqlSession 얻어오기 (MyBatis 실제 작업객체)
		SqlSession sqlSession= factory.openSession();
		
		//2.작업수행                 namespace.mapper_id
		list = sqlSession.selectList("workout.my_workout_list_date_cal", vo);

		//System.out.println(list);
		
		//3.닫기
		sqlSession.close();
		
		return list; //list 내에는 vo에서 가져온 레코드 값이 담겨있음
	}

	public List<WorkoutVo> selectListCalulate(int user_idx) {
		// TODO Auto-generated method stub
		List<WorkoutVo> list = null; //MyBatis가 만들어줌
		
		//String sql = "select * from workout_kcal where w_regdate=24-02-24 order by idx desc";
		
		//1.sqlSession 얻어오기 (MyBatis 실제 작업객체)
		SqlSession sqlSession= factory.openSession();
		
		//2.작업수행                 namespace.mapper_id
		list = sqlSession.selectList("workout.my_workout_list_cal", user_idx);

		//System.out.println(list);
		
		//3.닫기
		sqlSession.close();
		
		return list; //list 내에는 vo에서 가져온 레코드 값이 담겨있음
	}

	// 백상희 수정 20240228
	public double today_w_cal(int user_idx) {
		// TODO Auto-generated method stub
		
		Double today_w_cal = 0.0;
		
		//String sql = "select * from workout_kcal where w_regdate=24-02-24 order by idx desc";
		
		//1.sqlSession 얻어오기 (MyBatis 실제 작업객체)
		SqlSession sqlSession= factory.openSession();
		
		//2.작업수행                 namespace.mapper_id
		today_w_cal = sqlSession.selectOne("workout.my_workout_list_cal_today", user_idx);
        
		if(today_w_cal==null)
        	today_w_cal = 0.0;
		//System.out.println(today_w_cal);
		
		//3.닫기
		sqlSession.close();
		
		return today_w_cal; //list 내에는 vo에서 가져온 레코드 값이 담겨있음
	}

	public int my_workout_delete(int w_idx) {
		// TODO Auto-generated method stub
		int res = 0;
		//1.SqlSession 얻어오기					    true -> auto commit
		SqlSession sqlSession = factory.openSession(true);
				
		//2.수행
		res = sqlSession.delete("workout.my_workout_delete", w_idx);
		
		//3.닫기
		sqlSession.close();
		
		return res;
	}
	
	

	
	
	
	
}
