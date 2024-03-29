package controller.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import annotation.RequestMapping;
import annotation.ResponseBody;
import dao.BoardDao;
import dao.CategoryDao;
import dao.FoodDao;
import dao.UserDao;
import dao.WorkoutDao;
import vo.BoardVo;
import vo.CategoryVo;
import vo.UserVo;

public class UserController {
	
	//회원정보 가져오기
	@RequestMapping(value = "/user/list.do")
	public String user_list(HttpServletRequest request, HttpServletResponse response) {
		
		//회원정보 가져오기
		List<UserVo> list = UserDao.getInstance().selectList();
		
		//request binding
		request.setAttribute("list", list);
		
		return "user_list.jsp";
	} // end : list
	
	
	//로그인 폼 띄우기
	@RequestMapping(value = "/user/login_form.do")
	public String login_form(HttpServletRequest request, HttpServletResponse response) {

		return "user_login_form.jsp";
	} // end : user_login_form
	
	
	//로그인
	@RequestMapping(value = "/login.do")
	public String user_login(HttpServletRequest request, HttpServletResponse response) {
		
		// /user/login.do?user_id=one&user_pwd=1234&url=
		
		//1.paramter받기
		String user_id	=	request.getParameter("user_id");
		String user_pwd	=	request.getParameter("user_pwd");
		String url		=	request.getParameter("url");
		
		
		// select * from user where user_id=one111
        //2.user_id에 해당되는 유저정보 읽어오기
		UserVo user = UserDao.getInstance().selectOne(user_id);
		
		//아이디가 틀린경우
		if(user==null) {
			//response.sendRedirect("login_form.do?reason=fail_id&url="+url);
			return "redirect:login_form.do?reason=fail_id&url=" + url;
		}
		
		//비밀번호가 틀린경우
		if(user.getuser_pwd().equals(user_pwd)==false) {
			//response.sendRedirect(String.format("login_form.do?reason=fail_pwd&user_id=%s&url=%s", user_id, url));
			return String.format("redirect:login_form.do?reason=fail_pwd&user_id=%s&url=%s", user_id, url);
		}
		
		//세션정보 얻어오기->로그인 유저정보 저장
		HttpSession session = request.getSession();
		
		session.setAttribute("user", user);
		
		//메인페이지 이동: 현재경로 /user/login.do
		if(url.isEmpty()) {
			
			return "redirect:../main.do";
		}else {
			//response.sendRedirect(url);
			return "redirect:" + url;
		}
	} // end : user_login
	

	
	//보드에서 로그아웃
	@RequestMapping(value = "/board/logout.do")
	public String board_logout(HttpServletRequest request, HttpServletResponse response) {

		//로그아웃: session에 저장된 user삭제
		request.getSession().removeAttribute("user");
		
		return "redirect:../main.do";
	} // end : board_user_logout
	
	//메인화면에서 로그아웃
	@RequestMapping(value = "/logout.do")
	public String index_jsp_logout(HttpServletRequest request, HttpServletResponse response) {

		//로그아웃: session에 저장된 user삭제
		request.getSession().removeAttribute("user");
		
		return "redirect:main.do";
	} // end : index_jsp_user_logout
	
	//마이페이지에서 로그아웃
	@RequestMapping(value = "/user/logout.do")
	public String mypage_logout(HttpServletRequest request, HttpServletResponse response) {

		//로그아웃: session에 저장된 user삭제
		request.getSession().removeAttribute("user");
		
		return "redirect:../main.do";
	} // end : index_jsp_user_logout
	
	
	//멤버view
	@RequestMapping(value = "/user/view.do")
	public String user_view(HttpServletRequest request, HttpServletResponse response) {

		// /user/view.do?user_idx=5
		
		//1.parameter받기
		int user_idx  = Integer.parseInt(request.getParameter("user_idx"));
		
		//2.user_idx에 해당되는 userVo얻어오기
		UserVo vo = UserDao.getInstance().selectOne(user_idx);
		
		//3.request binding
		request.setAttribute("vo", vo);
		
		return "user_view.jsp";
	} // end : user_view
	
	
	//회원수정 form
	@RequestMapping(value = "/user/modify_form.do")
	public String user_modify_form(HttpServletRequest request, HttpServletResponse response) {

		// /user/modify_form.do?user_idx=5
		
		//1.parameter 받기
		int user_idx = Integer.parseInt(request.getParameter("user_idx"));
		
		//2.user_idx에 해당되는 회원정보 1건을 얻어온다
		UserVo  vo = UserDao.getInstance().selectOne(user_idx);
		
		//3.request binding
		request.setAttribute("vo", vo);
		
		return "user_modify_form.jsp";
	} // end : user_modify_form
	
	
	
	//회원수정
	@RequestMapping(value = "/user/modify.do")
	public String user_modify(HttpServletRequest request, HttpServletResponse response) {

		// /user/modify.do?user_idx=2&user_name=insert_test&user_id=insert&user_pwd=insert&user_cellphone=010-2222-3333
		//  &user_email=insert%40insert.insert&user_gender=man&user_height=12.0&user_kg=12.0&user_grade=일반

		//1.parameter받기
		int    user_idx			=	Integer.parseInt(request.getParameter("user_idx"));
		String user_name		=	request.getParameter("user_name");
		String user_id			=	request.getParameter("user_id");
		String user_pwd			=	request.getParameter("user_pwd");
		int    user_age			=	Integer.parseInt(request.getParameter("user_age"));
		String user_email		=	request.getParameter("user_email");
		String user_gender		=	request.getParameter("user_gender");
		Double user_height;
		try {
			user_height = Double.parseDouble(request.getParameter("user_height"));
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			user_height = 0.0;
			//e.printStackTrace();
		}
		Double user_kg;
		try {
			user_kg = Double.parseDouble(request.getParameter("user_kg"));
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			user_kg = 0.0;
			//e.printStackTrace();
		}
		Double user_target;
		try {
			user_target = Double.parseDouble(request.getParameter("user_target"));
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			user_target = 0.0;
			//e.printStackTrace();
		}
		String user_grade		=	request.getParameter("user_grade");
		//2.IP 구하기
		String user_ip			=	request.getRemoteAddr();
		
		
		//3.VO포장
		
		UserVo vo = new UserVo(user_idx, user_name, user_id, user_pwd, user_age,
								user_email, user_gender, user_height, user_kg, user_target,user_ip, user_grade);
		
		//4.DB update : update user set user_pwd=?,user_email=?,user_zipcode=?,user_addr=?,user_ip=?,
		//                                user_grade=?,user_modifydate=now()
		//              where user_idx=?
		UserDao.getInstance().update(vo);
		UserVo user = (UserVo) request.getSession().getAttribute("user");
		user.setUser_age(user_age);
		user.setuser_email(user_email);
		user.setuser_gender(user_gender);
		user.setuser_height(user_height);
		user.setuser_ip(user_ip);
		user.setUser_kg(user_kg);
		user.setuser_name(user_name);
		user.setuser_pwd(user_pwd);
		user.setUser_target(user_target);
		
		double BMI = Math.round((user_kg/((user_height/100)*(user_height/100)))*100/100.0);
		user.setUser_BMI(BMI);
		
		//(user_kg/((user_height/100)*(user_height/100)),2) as user_BMI
		
		request.getSession().setAttribute("user", user);
		
		return "redirect:mypage_main.do?user_idx=" + user_idx;
	} // end : user_modify
	
	
	//멤버 insert form
	@RequestMapping(value = "/user/insert_form.do")
	public String user_insert_form(HttpServletRequest request, HttpServletResponse response) {

		return "user_insert_form.jsp";
	} // end : user_insert_form
	
	
	//멤버 insert
	@RequestMapping(value = "/user/insert.do")
	public String user_insert(HttpServletRequest request, HttpServletResponse response) {

		// /user/insert.do?user_name=박길동&user_id=park&user_pwd=1234&user_email=a@b.com&
		//                   user_zipcode=06267&user_addr=서울 강남구 강남대로 238

		//1.paramter 받기
		String user_name		=	request.getParameter("user_name");
		String user_id			=	request.getParameter("user_id");
		String user_pwd			=	request.getParameter("user_pwd");
		int	   user_age 		=	Integer.parseInt(request.getParameter("user_age"));
		String user_email		=	request.getParameter("user_email");
		String user_gender		=	request.getParameter("user_gender");
		Double user_height;
		
		try {
			user_height = Double.parseDouble(request.getParameter("user_height"));
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			user_height = 0.0;
			//e.printStackTrace();
		}
		Double user_kg;
		try {
			user_kg = Double.parseDouble(request.getParameter("user_kg"));
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			user_kg = 0.0;
			//e.printStackTrace();
		}
		Double user_target;
		try {
			user_target = Double.parseDouble(request.getParameter("user_target"));
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			user_target = 0.0;
			//e.printStackTrace();
		}
		String user_grade		=	request.getParameter("user_grade");
		
		
		//2.IP
		String user_ip		=	request.getRemoteAddr();
		
		//3.VO포장
		UserVo vo = new UserVo(user_name, user_id, user_pwd, user_age ,user_email, user_gender, user_height, user_kg, user_target,user_grade, user_ip);
		
		//4.DB insert
		UserDao.getInstance().insert(vo);
		
		return "redirect:../user/login_form.do";
	} // end : user_insert
	
	
	//유저delete
	@RequestMapping(value = "/user/delete.do")
	public String user_delete(HttpServletRequest request, HttpServletResponse response) {

		// /user/delete.do?user_idx=4
		
		//1.삭제할 user_idx 받는다
		int user_idx = Integer.parseInt(request.getParameter("user_idx"));
		
		//2.DB delete : DML(insert/update/delete)처리후 결과행수반환(res)
		int res = UserDao.getInstance().delete(user_idx);
		if(res==1) {
			//성공
		}else {
			//실패
		}
		
		
		return "redirect:../logout.do";
	} // end : user_delete
	
	//멤버 id 여부 확인
	@RequestMapping(value = "/user/check_id.do", produces = "application/json;charset=utf-8;")
	@ResponseBody
	public String user_check_id(HttpServletRequest request, HttpServletResponse response) {

		// /user/check_id.do?user_id=one
		String user_id = request.getParameter("user_id");
		
		UserVo vo = UserDao.getInstance().selectOne(user_id);
		
		//true : 사용가능한 아이디
		//false: 이미사용중 아이디
		boolean bResult = (vo==null);
		
		JSONObject json = new JSONObject();
		json.put("result", bResult);// {"result":true}
		
		return json.toString();
	} // end : user_check_id
	
	@RequestMapping(value = "/main.do")
	public String main(HttpServletRequest request, HttpServletResponse response) {

		return "index.jsp";
	}
	
	//유저페이지에서 main.do호출했을 시
	@RequestMapping(value = "/user/main.do")
	public String user_main(HttpServletRequest request, HttpServletResponse response) {

		return "index.jsp";
	}
	
	//마이페이지 메뉴로 이동
	@RequestMapping("/user/mypage_main.do")
    public String mypage(HttpServletRequest request, HttpServletResponse response) {
        
		UserVo user  = (UserVo) request.getSession().getAttribute("user");
        
        int user_idx = user.getuser_idx();
		
        
        double today_workout_kal 	   = WorkoutDao.getInstance().today_w_cal(user_idx);
        double  today_food_kcal 	   = FoodDao.getInstance().today_f_cal(user_idx);
        List<BoardVo> mypage_board	   = BoardDao.getInstance().selectListUserBoard(user_idx);
        List<CategoryVo> category_list = CategoryDao.getInstance().selectList();
        
        request.setAttribute("today_food_kcal"  , today_food_kcal);
        request.setAttribute("today_workout_kal", today_workout_kal);
        request.setAttribute("category_list"    , category_list);
		request.setAttribute("mypage_board"	    , mypage_board);
		request.setAttribute("user"	  			, user);
		
        return "mypage_main.jsp";
        
	}

	@RequestMapping(value = "/board/mypage_main.do")
	public String mypage_home(HttpServletRequest request, HttpServletResponse response) {
		
		
		return "../user/mypage_main.do"; // user_idx값 forward
	}
	
	//마이 페이지에서 보드 이미지 클릭 시 이미지 뷰로 이동
	@RequestMapping(value = "/user/mypage_board_view.do")
	public String mypage_board_view(HttpServletRequest request, HttpServletResponse response) {
		
		int b_idx 	= Integer.parseInt(request.getParameter("b_idx"));
		
		BoardVo vo	= BoardDao.getInstance().selectOne(b_idx); 

		
		request.setAttribute("vo", vo);
		
		return "mypage_board_view.jsp";
	}
	
	
	
	
	
	
	
}