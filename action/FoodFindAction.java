package action;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.FoodInfoSearchUtils;
import vo.FoodVo;

@WebServlet("/food/find.do")
public class FoodFindAction extends HttpServlet{
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		//수신인코딩 설정
		request.setCharacterEncoding("utf-8");
		
		String desc_kor = request.getParameter("desc_kor");
//		System.out.println(desc_kor);
		
		try {
			List<FoodVo> food_search_list = FoodInfoSearchUtils.search_food_json(desc_kor);
			request.setAttribute("food_search_list", food_search_list);
			
			String forward_page = "food_search_list.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(forward_page);
			dispatcher.forward(request, response);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
			
	}
}
