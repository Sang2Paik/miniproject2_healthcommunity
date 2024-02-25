package action;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.FoodDao;
import vo.FoodVo;

@WebServlet("/food/delete.do")
public class FoodDeleteAction extends HttpServlet{
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		//수신인코딩 설정
		request.setCharacterEncoding("utf-8");
		
		int f_idx = Integer.parseInt(request.getParameter("f_idx"));
		
		int res = FoodDao.getInstance().delete(f_idx);
	
		List<FoodVo> add_food_list = FoodDao.getInstance().selectList();
		
		request.setAttribute("add_food_list", add_food_list);
		
		String forward_page = "add_food_list.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(forward_page);
		dispatcher.forward(request, response);
	}
}
