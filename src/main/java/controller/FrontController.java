package controller;

import java.io.IOException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import annotation.RequestMapping;
import annotation.ResponseBody;

/**
 * Servlet implementation class FrontController
 */
//@WebServlet("*.do")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	//Object ob = null;
	List<Method> method_list = new ArrayList<Method>();
	List<Object> object_list = new ArrayList<Object>();
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		super.init(config);
		
		// action = "controller.action.MemberController,controller.action.BoardController"
		String action = config.getInitParameter("action")
				              .trim()
				              .replaceAll("\r", "")
				              .replaceAll("\n", "")
				              .trim();
		
		// action_array = {"controller.action.MemberController" , "controller.action.BoardController"};
				
		
		String [] action_array = action.split(",");
		
		for(String action_name : action_array) {
			try {
				Class c = Class.forName(action_name.trim());
				Object ob = c.newInstance();
				
				
				//해당객체내의 메소드정보 추출
				Method [] method_array = c.getDeclaredMethods();
				
				for(Method method : method_array) {
					object_list.add(ob);
					method_list.add(method);
				}
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
	}
	
	
	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
        //URI Pattern분석
		
		
		
		String uri = request.getRequestURI();  //  uri = "/ProjectName/book/list.do"
		
		String forward_page="";
		boolean bResponseBody=false;
		String contentType="";
		
		for(Method method : method_list) {	
		
			if(method.isAnnotationPresent(RequestMapping.class)) {
				
				RequestMapping annotation = method.getAnnotation(RequestMapping.class);
				if(uri.contains(((RequestMapping)annotation).value())){
					try {
						
					
						int index = method_list.indexOf(method);
						Object ob = object_list.get(index);
						
						forward_page = (String) method.invoke(ob, request,response);
							
						
						if(method.isAnnotationPresent(ResponseBody.class)) {
							
							contentType = ((RequestMapping)annotation).produces();
							
							bResponseBody = true;
						}
						
						break;
						
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
			
			
		}
		
		//forward or redirect내용이 없으면 끝내라...
		//if(forward_page.isEmpty())return;
		
		if(bResponseBody) {
			
			response.setContentType(contentType);
			response.getWriter().print(forward_page);
			
			return;
		}
		
		// forward_page="redirect:list.do"
		if(forward_page.contains("redirect:")) {
			
			String redirect_page = forward_page.replaceAll("redirect:", "");
			response.sendRedirect(redirect_page);
			
		}else {
			//forward
			RequestDispatcher disp = request.getRequestDispatcher(forward_page);
			disp.forward(request, response);
		}
				
	}
		
}