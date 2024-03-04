package controller.action;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import com.mysql.cj.Session;

import annotation.RequestMapping;
import annotation.ResponseBody;
import dao.WorkoutDao;
import util.WorkoutUtils;
import vo.UserVo;
import vo.WorkoutCaloryVo;
import vo.WorkoutVo;

public class WorkoutController {
	
	//내 운동 리스트
	@RequestMapping("/workout/my_workout_list.do")
	public String my_workout_list(HttpServletRequest request, HttpServletResponse response) {

		// /workout/list.do
		// /workout/list.do?search_text=24-02-24
		
		UserVo user = (UserVo) request.getSession().getAttribute("user");
		
		int user_idx = user.getuser_idx();
		String user_name = user.getuser_name();
		
		WorkoutVo vo = new WorkoutVo(user_idx, user_name);
		
		List<WorkoutVo> list = WorkoutDao.getInstance().selectList(vo);
		
		request.setAttribute("list", list);
		
		//System.out.println(list);
		
		return "my_workout_list.jsp";  //forward
	}
	
	//내 운동 리스트 검색
	@RequestMapping("/workout/my_workout_list_search.do")
	@ResponseBody
	public String my_workout_list_search(HttpServletRequest request, HttpServletResponse response) {

		// /workout/list.do
		// /workout/list.do?search_text=24-02-24
		
		UserVo user = (UserVo) request.getSession().getAttribute("user");
		
		int user_idx = user.getuser_idx();
		String user_name = user.getuser_name();
		
		String w_regdate = request.getParameter("w_regdate");
		
		//System.out.println(search_text);
		
		//검색에 필요한 정보를 vo에 넣는다
		WorkoutVo vo = new WorkoutVo(w_regdate, user_idx, user_name);
		
		List<WorkoutVo> list = WorkoutDao.getInstance().selectListSearch(vo);
		
//		request.setAttribute("list", list);
		
//		System.out.println(list);
		
//		return "my_workout_list.jsp";  //forward
		
		
		JSONObject json = new JSONObject();
		json.put("list", list);
		
		//System.out.println(json);
		
		return json.toString();
	}
	
	//내 운동 리스트 계산
	@RequestMapping("/workout/my_workout_calculate.do")
	@ResponseBody
	public String my_workout_calculate(HttpServletRequest request, HttpServletResponse response) {		

		UserVo user = (UserVo) request.getSession().getAttribute("user");
		
		int user_idx = user.getuser_idx();
		
		List<WorkoutVo> list = WorkoutDao.getInstance().selectListCalulate(user_idx);
		
		JSONObject json = new JSONObject();
		json.put("list", list);

		return json.toString();
		//System.out.println(list);
		
		//return "my_workout_list.jsp";
	}
	
	//내 운동 리스트 검색 계산
	@RequestMapping("/workout/my_workout_calculate_search.do")
	@ResponseBody
	public String my_workout_calculate_search(HttpServletRequest request, HttpServletResponse response) {
		
		UserVo user = (UserVo) request.getSession().getAttribute("user");
		
		int user_idx = user.getuser_idx();
		String user_name = user.getuser_name();
		
		String w_regdate = request.getParameter("w_regdate");
//		String w_unit_kcal = request.getParameter("w_unit_kcal");
		
		//System.out.println(w_regdate);
		
		WorkoutVo vo = new WorkoutVo(w_regdate, user_idx, user_name);

		
		List<WorkoutVo> list = WorkoutDao.getInstance().selectListCalulate(vo);
		
		JSONObject json = new JSONObject();
		json.put("list", list);

		return json.toString();
		//System.out.println(list);
		
		//return "my_workout_list.jsp";
	}
	
	
	//운동 입력 메인
	@RequestMapping("/workout/workout_insert_form.do")
	public String workout_insert_form(HttpServletRequest request, HttpServletResponse response) {

		String w_regdate = request.getParameter("w_regdate");
		
		return "workout_insert_form.jsp?w_redgate=" + w_regdate;
	}
	
	//운동선택 리스트
	@RequestMapping("/workout/workout_cal_list.do")
	public String workout_cal_list(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		//날짜 받기 추가
		String w_regdate = request.getParameter("w_regdate");
		
		int page = Integer.parseInt(request.getParameter("page"));
		int perPage = Integer.parseInt(request.getParameter("perPage"));
		
		List<WorkoutCaloryVo> list = WorkoutUtils.workout_cal_list(page, perPage);
		
		String workout_name = null;
		double cal_per_unit = 0.0;
		
		WorkoutCaloryVo vo = new WorkoutCaloryVo(cal_per_unit, workout_name);
		
		
		//request binding
		request.setAttribute("list", list);
		//System.out.println(list);

		//3/4 수정
		request.setAttribute("w_regdate", w_regdate);
		
		return "workout_list.jsp";
	}
	
	

	
	//운동 찾기
	@RequestMapping("/workout/search.do")
	public String search(HttpServletRequest request, HttpServletResponse response) throws IOException {

		//날짜받기 추기
		
		int page = Integer.parseInt(request.getParameter("page"));
		int perPage = Integer.parseInt(request.getParameter("perPage"));
				
		String w_regdate = request.getParameter("w_regdate");
		
		String search_text = request.getParameter("search_text");
		
		search_text = request.getParameter("search_text");
		
		List<WorkoutCaloryVo> workout_list = null;
		
		//WorkoutCaloryVo vo = new WorkoutCaloryVo(search_text, page, perPage);
		WorkoutCaloryVo vo = new WorkoutCaloryVo(page, perPage);
		
		workout_list = WorkoutUtils.workout_cal_list(search_text, page, perPage);
		
		//request binding
		request.setAttribute("list", workout_list);
		//3/4 수정
		request.setAttribute("w_regdate", w_regdate);
		//System.out.println(list);
		
		
		return "workout_list.jsp";
	}
	
	//운동 입력
	@RequestMapping("/workout/workout_insert.do")
	public String my_workout(HttpServletRequest request, HttpServletResponse response) {

		// /workout/workout_insert.do?w_name=다트&w_unit_kcal=210&w_time=60&w_regdate=2024-02-29
		
		//parameter 받기
		String	w_name	     = request.getParameter("w_name");
		double w_unit_kcal = 0.0;

		w_unit_kcal = Double.parseDouble(request.getParameter("w_unit_kcal"));
	
		int	    w_time	   	 = Integer.parseInt(request.getParameter("w_time"));
		
		String  w_regdate    = request.getParameter("w_regdate");
		
		//user정보
		UserVo user = (UserVo) request.getSession().getAttribute("user");
		
		int user_idx = user.getuser_idx();
		String user_name = user.getuser_name();
		
		//세션정보 얻어오기->로그인 유저정보 저장(X)
		//HttpSession session = request.getSession();
		//session.setAttribute("user", user);
		//int user_idx	     = user.user_idx;
		
		//4.등록회원정보
		//int    user_idx	= user.getUser_idx();
		//String mem_name = user.getUser_name();
		
//		int user_idx	     = 2;
//		String user_name     = "홍길동";
	
		//System.out.println(w_name);
		//System.out.println(w_time);
		//System.out.println(w_unit_kcal);
		//System.out.println(user_idx);
		//System.out.println(user_name);
		
		//5. DB 포장
		WorkoutVo vo  =new WorkoutVo(w_name, w_regdate, w_time, w_unit_kcal, user_idx, user_name);	
		
		//6.DB insert
		int res = WorkoutDao.getInstance().insert(vo);
		
		return "redirect: my_workout_list.do?w_regdate=" + w_regdate;
	}
	
	//수정하기 폼 띄우기
//	@RequestMapping("/workout/my_workout_modify_form.do")
//	public String my_workout_modify(HttpServletRequest request, HttpServletResponse response) {
//
//		// /workout/my_workout_modify_form.do?w_idx=3&regdate=2024-03-01
//	
//		//1.parameter받기
//		int w_idx = Integer.parseInt(request.getParameter("w_idx"));
//		
//		//2.수정할 b_idx해당되는 게시물 1건 얻어오기
//		WorkoutVo vo = WorkoutDao.getInstance().selectOne(w_idx);
//		
//		//request binding
//		request.setAttribute("vo", vo);
//		
//		
//		return "my_workout_modify_form.jsp";
//		
//	}//end:modify_form
	
	//운동 삭제
	@RequestMapping("/my_workout_delete.do")
	public String my_workout_delete(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {

		// /workout/my_workout_delete.do?w_idx=13
		
		String w_regdate = request.getParameter("w_regdate");
		int w_idx = Integer.parseInt(request.getParameter("w_idx"));
		
		int res = WorkoutDao.getInstance().my_workout_delete(w_idx);
		
		return "redirect:my_workout_list.do?w_regdate=" + w_regdate;
	}
	
}
