package controller.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import annotation.RequestMapping;
import dao.UserDao;
import vo.UserVo;

// 해당 action controller를 사용하려면 web.xml의 FrontController 생성부분에 등록해야 함
public class AdminController {
	
	@RequestMapping("/board/admin_page.do")
	public String list(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		List<UserVo> admin_user_list = UserDao.getInstance().selectList();
		
		request.setAttribute("admin_user_list", admin_user_list);
		
		return "../admin/admin_page.jsp";   //forward

	} // end:list

	
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
		
		String user_grade		=	request.getParameter("user_grade");
		//2.IP 구하기
		String user_ip			=	request.getRemoteAddr();
		
		
		//3.VO포장
		
		UserVo vo = new UserVo(user_idx, user_name, user_id, user_pwd, user_age,
								user_email, user_gender, user_ip, user_grade);
		
		//4.DB update : update user set user_pwd=?,user_email=?,user_zipcode=?,user_addr=?,user_ip=?,
		//                                user_grade=?,user_modifydate=now()
		//              where user_idx=?
		UserDao.getInstance().update(vo);
		
		return "redirect:list.do";
	} // end : user_modify
		
}
