package controller.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import annotation.RequestMapping;
import dao.CategoryDao;
import dao.UserDao;
import vo.CategoryVo;
import vo.UserVo;

// 해당 action controller를 사용하려면 web.xml의 FrontController 생성부분에 등록해야 함
public class AdminController {
	
	//어드민폴더에서 어드민 페이지 호출
	@RequestMapping(value = "/admin/admin_page.do")
	public String admin_page(HttpServletRequest request, HttpServletResponse response) {
		
		List<UserVo> admin_user_list 		 = UserDao.getInstance().selectList();
		List<CategoryVo> admin_category_list = CategoryDao.getInstance().selectList();
		
		request.setAttribute("admin_user_list", admin_user_list);
		request.setAttribute("admin_category_list", admin_category_list);
		
		return "admin_page.jsp";
	}
	

	//어드민 멤버 제명
	@RequestMapping(value = "/admin/admin_user_delete.do")
	public String admin_user_delete(HttpServletRequest request, HttpServletResponse response) {

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
		
		return "redirect:admin_page.do";
	} // end : user_delete
	
	//회원수정 폼
	@RequestMapping(value = "/admin/admin_user_modify_form.do")
	public String user_mofify_form(HttpServletRequest request, HttpServletResponse response) {

		int user_idx = Integer.parseInt(request.getParameter("user_idx"));
		
		UserVo user_vo = UserDao.getInstance().selectOne(user_idx);
		
		request.setAttribute("user_vo", user_vo);
		
		return "admin_user_modify_form.jsp";
	}
	
	
	//회원수정
	@RequestMapping(value = "/admin/admin_user_modify.do")
	public String admin_user_modify(HttpServletRequest request, HttpServletResponse response) {

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
		UserVo vo = new UserVo(user_idx, user_name, user_id, user_pwd, user_age, user_email, user_gender, user_height, user_kg, user_target, user_ip, user_grade);
		
		//4.DB update : update user set user_pwd=?,user_email=?,user_zipcode=?,user_addr=?,user_ip=?,
		//                                user_grade=?,user_modifydate=now()
		//              where user_idx=?
		UserDao.getInstance().update(vo);
		
		return "redirect:admin_page.do";
	} // end : user_modify
		
	
	
	
}
