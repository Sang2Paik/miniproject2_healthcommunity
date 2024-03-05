package controller.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import annotation.RequestMapping;
import annotation.ResponseBody;
import dao.FoodDao;
import vo.FoodVo;
import vo.MealTypeVo;
import vo.UserVo;

public class FoodController {
	
	//	검색어로 음식 찾기 
	@RequestMapping("/food/find_list.do")
	public String list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		List<FoodVo> food_search_list = null;
		
		String desc_kor = request.getParameter("desc_kor");
		String f_eattime = request.getParameter("f_eattime");
		int m_idx = Integer.parseInt(request.getParameter("m_idx"));
		String m_name = request.getParameter("m_name");
		
		food_search_list = util.FoodSearchUtils.search_food_json(desc_kor);	
		//System.out.println(f_name);
		request.setAttribute("food_search_list", food_search_list);
		request.setAttribute("f_eattime", f_eattime);
		request.setAttribute("m_idx", m_idx);
		request.setAttribute("m_name", m_name);
		
		return "food_search_list.jsp";
	}
	
	// 등록 폼 - 일반정보 
		@RequestMapping("/food/insert_basic.do")
		public String insert_basic(HttpServletRequest request, HttpServletResponse response) throws Exception {
									
			List<MealTypeVo> meal_type_list = FoodDao.getInstance().selectList(); 			

			request.setAttribute("meal_type_list", meal_type_list);

			return "food_insert_form_basic.jsp";
		}
	
	// 등록 폼 - 음식찾기 
	@RequestMapping("/food/insert_form.do")
	public String insert(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		return "food_insert_form.jsp";
	}
	
	// 음식 중복 찾기
	@RequestMapping(value="/food/add_check.do", produces="application/json;charset=utf-8;")
	@ResponseBody
	public String add_check(HttpServletRequest request, HttpServletResponse response) {
		
		String f_name = request.getParameter("f_name");
		double f_unit_kcal = Double.parseDouble(request.getParameter("f_unit_kcal")); 	
		String f_maker	= request.getParameter("f_maker"); 
		int user_idx	= Integer.parseInt(request.getParameter("user_idx"));
		
		FoodVo vo = new FoodVo(f_name, f_unit_kcal, user_idx, f_maker);
		
		FoodVo findVo = FoodDao.getInstance().selectOne(vo);
		
		boolean result = false;
		if(findVo != null) {
			result = true; // 있다는 뜻
		}
		
		String json = String.format("{\"result\" : %b}", result);
		
		return json;
	}
	
	// 음식 담기
	@RequestMapping("/food/add_food.do")
	public String add_food(HttpServletRequest request, HttpServletResponse response) {
		
		String f_name = request.getParameter("f_name"); 
		int user_idx	= Integer.parseInt(request.getParameter("user_idx"));
		if(f_name != null) {
			int f_unit_g = Integer.parseInt(request.getParameter("f_unit_g")); 
			double f_csum_g = Double.parseDouble(request.getParameter("f_csum_g")); 
			double f_unit_kcal = Double.parseDouble(request.getParameter("f_unit_kcal")); 
			String f_maker	= request.getParameter("f_maker"); 
			String f_eattime = request.getParameter("f_eattime");
			int m_idx	= Integer.parseInt(request.getParameter("m_idx"));
			String m_name = request.getParameter("m_name");
			
			
	//		System.out.println(f_name);
	//		System.out.println(f_unit_kcal);
	//		System.out.println(f_maker);
			
			FoodVo vo = new FoodVo(f_name, f_eattime, m_idx, m_name, f_unit_g, f_unit_kcal, f_csum_g, f_maker, user_idx);
			
			FoodVo findVo = FoodDao.getInstance().selectOne(vo);
			
			if(findVo == null) {
				int res = FoodDao.getInstance().insert(vo);
			}
		}		
				
		List<FoodVo> add_food_list = FoodDao.getInstance().add_selectList(user_idx);
		
		request.setAttribute("add_food_list", add_food_list);
				
		return "add_food_list.jsp";
	}
	
	// 담기에서 음식 삭제
	@RequestMapping("/food/delete.do")
	public String delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int f_idx = Integer.parseInt(request.getParameter("f_idx"));
		UserVo user = (UserVo) request.getSession().getAttribute("user");
		int user_idx = user.getuser_idx();
		
		int res = FoodDao.getInstance().delete(f_idx);
					
		List<FoodVo> add_food_list = FoodDao.getInstance().add_selectList(user_idx);
		
		request.setAttribute("add_food_list", add_food_list);
		
		return "add_food_list.jsp";
	}
	
	
	//음식 등록 확정
	@RequestMapping("/food/food_cal_list.do")
	public String confirm_update(HttpServletRequest request, HttpServletResponse response) {
		
	
		String [] str_f_idx_array = request.getParameterValues("f_idx");
		
		if(str_f_idx_array != null) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("f_idx_array", str_f_idx_array);
			
			int f_no = FoodDao.getInstance().selectFoodNo();
			//System.out.println(f_no);
			FoodVo vo = new FoodVo();
			
			for(String str_idx : str_f_idx_array) {
				
				int f_idx = Integer.parseInt(str_idx);
				vo.setF_no(f_no);
				vo.setF_idx(f_idx);
				
				int res = FoodDao.getInstance().update(vo);
			}
		}					
		
		
		return "redirect:food_list_page.do";
	}
	
	// 계산 리스트 보기
	@RequestMapping("/food/food_list_page.do")
	public String foodListPage(HttpServletRequest request, HttpServletResponse response) {
				
		return "food_cal_list.jsp";
	}
	
	// confirm food_list 불러오기
	@RequestMapping("/food/food_list.do")
	public String foodList(HttpServletRequest request, HttpServletResponse response) {
		
		UserVo user = (UserVo) request.getSession().getAttribute("user");
		int user_idx = user.getuser_idx();
		
		List<FoodVo> confirm_food_list = FoodDao.getInstance().confirm_selectList(user_idx);
		
		request.setAttribute("confirm_food_list", confirm_food_list);
		
		return "confirm_food_list.jsp";
	}
	
	// 차트 보기
	@RequestMapping(value="/food/food_cal_chart.do", produces="application/json;charset=utf-8;")
	@ResponseBody
	public String foodChart(HttpServletRequest request, HttpServletResponse response) {
		
		UserVo user = (UserVo) request.getSession().getAttribute("user");
		int user_idx = user.getuser_idx();
		
		List<FoodVo> food_chart_list = FoodDao.getInstance().foodChartList(user_idx);
				
		JSONObject json = new JSONObject();
		json.put("food_chart_list", food_chart_list);

		
		return json.toString();
	}
	
	// 컴펌된 식사 삭제
	@RequestMapping("/food/confirm_food_delete.do")
	public String confirmFoodDelete(HttpServletRequest request, HttpServletResponse response) {
		
		int f_no = Integer.parseInt(request.getParameter("f_no"));
		
		int res = FoodDao.getInstance().cf_delete(f_no);		
		
		return "redirect:food_cal_list.do";
	}
	
	// 백상희 20240229 수정 관련 시작
	
	// 수정 폼 처음 가기
	@RequestMapping("/food/food_modify_basic.do")
	public String modifyBasic(HttpServletRequest request, HttpServletResponse response) throws Exception {
								
		List<MealTypeVo> meal_type_list = FoodDao.getInstance().selectList(); 			
				
		request.setAttribute("meal_type_list", meal_type_list);
		
		return "food_modify_form_basic.jsp";
	}
	
	// 수정하기 음식리스트 찾기
	@RequestMapping("/food/food_modify_form.do")
	public String foodModifyForm(HttpServletRequest request, HttpServletResponse response) {
		
		int m_idx = Integer.parseInt(request.getParameter("m_idx"));
		String m_name = request.getParameter("m_name");
		String f_eattime = request.getParameter("f_eattime");
		int f_no = Integer.parseInt(request.getParameter("f_no"));
		
		List<FoodVo> list = FoodDao.getInstance().modifyList(f_no); // f_no의 길이와 각각의 f_idx 찾아서 날짜, meal type 변경
		
		FoodVo vo = new FoodVo();
		vo.setM_idx(m_idx);
		vo.setM_name(m_name);
		vo.setF_eattime(f_eattime);
		
		for(FoodVo food : list) {
			
			int f_idx = food.getF_idx();
			vo.setF_idx(f_idx);
			int res = FoodDao.getInstance().modifyBasicInfo(vo);
		}
		
		
		return "food_modify_form.jsp";
	}
	
	//	검색어로 음식 찾기 
		@RequestMapping("/food/find_modify_list.do")
		public String modifyList(HttpServletRequest request, HttpServletResponse response) throws Exception {
			
			List<FoodVo> food_search_list = null;
			
			int f_no = Integer.parseInt(request.getParameter("f_no"));
			String desc_kor = request.getParameter("desc_kor");
			String f_eattime = request.getParameter("f_eattime");
			int m_idx = Integer.parseInt(request.getParameter("m_idx"));
			String m_name = request.getParameter("m_name");
			
			food_search_list = util.FoodSearchUtils.search_food_json(desc_kor);	
			//System.out.println(f_name);
			request.setAttribute("food_search_list", food_search_list);
			request.setAttribute("f_eattime", f_eattime);
			request.setAttribute("m_idx", m_idx);
			request.setAttribute("m_name", m_name);
			
			return "food_search_list_modify.jsp";
		}
	
	// 수정할 리스트 출력 
	@RequestMapping("/food/modify_confirm_food_list.do")
	public String modifyConfirmFoodList(HttpServletRequest request, HttpServletResponse response) {
		
		int f_no = Integer.parseInt(request.getParameter("f_no"));
		
		List<FoodVo> confirm_food_list_modify = FoodDao.getInstance().modifyList(f_no);
		
		// 수정할 리스트 f_idx에 해당되는 항목을 f_confirm을 N으로 수정
		for(FoodVo food : confirm_food_list_modify) {
			int f_idx = food.getF_idx();
			int res = FoodDao.getInstance().modifyYtoN(f_idx);
		}
		
		request.setAttribute("confirm_food_list_modify", confirm_food_list_modify);
		request.setAttribute("f_no", f_no);
		
		return "modify_confirm_food_list.jsp";
	}
	
	//확정된 음식의 수정 완료단계
		@RequestMapping("/food/food_modify_list.do")
		public String modify_update(HttpServletRequest request, HttpServletResponse response) {
				
			String [] str_f_idx_array = request.getParameterValues("f_idx");
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("f_idx_array", str_f_idx_array);
			
			int f_no = Integer.parseInt(request.getParameter("f_no"));
			
			for(String str_idx : str_f_idx_array) {
				
				int f_idx = Integer.parseInt(str_idx);
				
				int res = FoodDao.getInstance().modify_update(f_idx);
			}
					
			return "redirect:food_list_page.do";
		}
		
		// 수정페이지에서 새로운 음식 담기
		@RequestMapping("/food/add_food_modify.do")
		public String addFoodModify(HttpServletRequest request, HttpServletResponse response) {
			
			String f_name = request.getParameter("f_name"); 
			int f_no=Integer.parseInt(request.getParameter("f_no"));
			int user_idx	= Integer.parseInt(request.getParameter("user_idx"));
			if(f_name != null) {
		
				int f_unit_g = Integer.parseInt(request.getParameter("f_unit_g")); 
				double f_csum_g = Double.parseDouble(request.getParameter("f_csum_g")); 
				double f_unit_kcal = Double.parseDouble(request.getParameter("f_unit_kcal")); 
				String f_maker	= request.getParameter("f_maker"); 
				String f_eattime = request.getParameter("f_eattime");
				int m_idx	= Integer.parseInt(request.getParameter("m_idx"));
				String m_name = request.getParameter("m_name");
				
				FoodVo vo = new FoodVo(f_no, f_name, f_eattime, m_idx, m_name, f_unit_g, f_unit_kcal, f_csum_g, f_maker, user_idx);
				
				FoodVo findVo = FoodDao.getInstance().selectOneModify(vo);
				
				if(findVo == null) {
					int res = FoodDao.getInstance().updateModify(vo);
				}
			}
			
//			//f_no 을 가지고 가야함
//			List<FoodVo> add_food_list = FoodDao.getInstance().modifyList(f_no); //수정된 담기 리스트를 보여주기
//			
//			request.setAttribute("add_food_list", add_food_list);
					
			return "modify_confirm_food_list.jsp";
		}
		
		// 수정용 담기에서 음식 삭제
		@RequestMapping("/food/delete_for_modify.do")
		public String deleteForModify(HttpServletRequest request, HttpServletResponse response) throws Exception {
			
			int f_idx = Integer.parseInt(request.getParameter("f_idx"));
//			UserVo user = (UserVo) request.getSession().getAttribute("user");
//			int user_idx = user.getuser_idx();
//			int f_no = Integer.parseInt(request.getParameter("f_no"));
			
			int res = FoodDao.getInstance().delete(f_idx);
						
			return "modify_confirm_food_list.jsp";
		}
				
		

}
