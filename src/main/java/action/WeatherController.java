package controller.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import annotation.RequestMapping;
import util.WeatherUtils;
import vo.WeatherVo;

// 해당 action controller를 사용하려면 web.xml의 FrontController 생성부분에 등록해야 함
public class WeatherController {
	
	@RequestMapping("/weather/list.do")
	public String list(HttpServletRequest request, HttpServletResponse response) throws IOException { //invoke할 때 인자 두개 받아야 함

		// 20240302 백상희 수정
		double lon;//경도
		double lat;//위도
		
		String units = "metric";
		
		// 20240302 백상희 수정
		try {
			lon = Double.parseDouble(request.getParameter("lon")); 
			lat = Double.parseDouble(request.getParameter("lat"));
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			lon = 127.0249726;
			lat = 37.5012336;
		}
		
		String appid = "611b3f8090aed6b02f7c41b9259ea748";
	
		List<WeatherVo> weather_list = WeatherUtils.weather_list(lon,lat,units,appid);
		//System.out.printf("%f, %f", lon, lat);
		//request binding
		request.setAttribute("weather_list", weather_list);
		//System.out.println(weather_list);
		return "weather_list.jsp";   //forward

	} // end:list

	
}
