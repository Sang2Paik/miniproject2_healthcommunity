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
import util.FoodInfoSearchUtils;
import vo.FoodVo;

@WebServlet("/food/add.do")
public class FoodAddAction extends HttpServlet{
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		//수신인코딩 설정
		request.setCharacterEncoding("utf-8");
				
		String f_name = request.getParameter("f_name");
		int f_unit_g  = Integer.parseInt(request.getParameter("f_unit_g"));
		double f_unit_kcal = Double.parseDouble(request.getParameter("f_unit_kcal"));
		String animal_plant = request.getParameter("animal_plant");
		
		FoodVo vo = new FoodVo();
		vo.setF_name(f_name);
		vo.setF_unit_g(f_unit_g);
		vo.setF_unit_kcal(f_unit_kcal);
		vo.setAnimal_plant(animal_plant);
		
		FoodVo findVo = FoodDao.getInstance().selectOne(vo);
		int total_kcal = 0;
		
		if(findVo == null) {
			int res = FoodDao.getInstance().insert(vo);
			total_kcal = FoodDao.getInstance().selectOne();
		}
		
		List<FoodVo> add_food_list = FoodDao.getInstance().selectList();
		
		request.setAttribute("add_food_list", add_food_list);
		request.setAttribute("total_kcal", total_kcal);
		
		String forward_page = "add_food_list.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(forward_page);
		dispatcher.forward(request, response);
			
	}
}
