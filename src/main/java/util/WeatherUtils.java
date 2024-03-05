package util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import vo.WeatherVo;

public class WeatherUtils {
	
//	static Map<Integer, String> weatherMap = new HashMap<Integer,String>();
	
	static String appid = "서비스키필요";
	
	public static List<WeatherVo> weather_list(Double lon,Double lat,String units,String appid) throws IOException{
		
		List<WeatherVo> list = new ArrayList<WeatherVo>();
		
		String str_url =String.format("https://api.openweathermap.org/data/2.5/weather?lat=%.7f&lon=%.7f&units=%s&appid=%s",
											                                              lat,      lon,      units,    appid);
		//System.out.println(str_url);
		
		URL url = new URL(str_url);
		//System.out.println(url);
		HttpURLConnection urlConn = (HttpURLConnection) url.openConnection();
		//여기서 요청헤더 설정(네이버/카카오 아이디/비번설정)
		
		urlConn.connect();
		
		InputStream is 			= urlConn.getInputStream();
		InputStreamReader isr	= new InputStreamReader(is, "utf-8");
		BufferedReader    br 	= new BufferedReader(isr);// 성능향상 / 라인단위로 읽기
		
		StringBuffer      sb	= new StringBuffer();
		while(true) {
			
			String data = br.readLine();//라인단위로 읽기
			if(data==null) break;
			
			sb.append(data);// 라인단위 읽은 데이터 스트링버퍼에 넣는다
		}
		
		//System.out.println(sb.toString());
	
		JSONObject json = new JSONObject(sb.toString());
		
		JSONArray weather_array = json.getJSONArray("weather");
		
		String description=null;
		String icon=null;
		
		for(int i=0; i<weather_array.length(); i++) {
			JSONObject json_weather = weather_array.getJSONObject(i);
			description = json_weather.getString("description");
			icon = json_weather.getString("icon"); 
		}//end:for
//		/
		JSONObject main = json.getJSONObject("main");
		
		int temp = (int) Math.floor(main.getDouble("temp"));
		int temp_min = (int) Math.floor(main.getDouble("temp_min"));
		int temp_max = (int) Math.floor(main.getDouble("temp_max"));
		
		String name = json.getString("name");
        
		//System.out.println(temp);
        //WeatherVo포장
        WeatherVo vo = new WeatherVo(temp, temp_min, temp_max, description, icon, name);
		
        //System.out.println(vo.getIcon());
        
		list.add(vo);

		//System.out.println(list);
		//System.out.println(vo.getIcon());
        
		return list;
	}
}
