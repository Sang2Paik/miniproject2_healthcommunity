package util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import vo.WorkoutCaloryVo;

public class WorkoutUtils {
	
	static String serviceKey = "g6bfSQw2gVo25lHNU0Km5y4gNZFN7Kez9IF3V7VF%2FjP6fAFnrsI%2Ba%2BTP%2Fa5WGUnH2xYN7s5qLw92xCs10w2i0g%3D%3D";
	
	public static List<WorkoutCaloryVo> workout_cal_list (int page, int perPage) throws IOException{
		
		List<WorkoutCaloryVo> list = new ArrayList<WorkoutCaloryVo>();
		
		String str_url = String.format("https://api.odcloud.kr/api/15068730/v1/uddi:734ff9bb-3696-4993-a365-c0201eb0a6cd?page=%d&perPage=%d&serviceKey=%s",
				                                                                                                            page,    perPage,          serviceKey);
		
		//System.out.println(str_url);
		
		URL url = new URL(str_url);
		
		HttpURLConnection urlconn = (HttpURLConnection) url.openConnection();
		//여기서 요청헤더 설정(네이버/카카오 아이디/비번설정)
		
		urlconn.connect();
		
		InputStream 	  is  = urlconn.getInputStream();
		InputStreamReader isr = new InputStreamReader(is, "utf-8");
		BufferedReader    br  = new BufferedReader(isr);  // 성능향상 / 라인단위로 읽기
		
		StringBuffer	  sb  = new StringBuffer();
		
		while(true) {
			
			String data = br.readLine();//라인단위로 읽기
			if(data==null) break;
			
			sb.append(data); // 라인단위 읽은 데이터 스트링버퍼에 넣는다
		}
		
		//Json Parsing
		JSONObject json = new JSONObject(sb.toString());
		
		JSONArray data_array = json.getJSONArray("data");
		
		double cal_per_unit = 0.0;
		String workout_name = null;
		
		for(int i=0; i<data_array.length(); i++) {
			
			JSONObject json_workout = data_array.getJSONObject(i);
			
			cal_per_unit = json_workout.getDouble("단위체중당에너지소비량");
			workout_name = json_workout.getString("운동명");
			
			WorkoutCaloryVo search_vo = new WorkoutCaloryVo(cal_per_unit, workout_name);
			
			list.add(search_vo);
			
		}//end:for
				
		//System.out.println(list);
		
		return list;
	}
	
	public static List<WorkoutCaloryVo> workout_cal_list (String keyword,int page, int perPage) throws IOException{
		
		List<WorkoutCaloryVo> list = new ArrayList<WorkoutCaloryVo>();
		
		String str_url = String.format("https://api.odcloud.kr/api/15068730/v1/uddi:734ff9bb-3696-4993-a365-c0201eb0a6cd?page=%d&perPage=%d&serviceKey=%s",
				                                                                                                             page,    perPage,         serviceKey);
		
		//System.out.println(str_url);
		
		URL url = new URL(str_url);
		
		HttpURLConnection urlconn = (HttpURLConnection) url.openConnection();
		//여기서 요청헤더 설정(네이버/카카오 아이디/비번설정)
		
		urlconn.connect();
		
		InputStream 	  is  = urlconn.getInputStream();
		InputStreamReader isr = new InputStreamReader(is, "utf-8");
		BufferedReader    br  = new BufferedReader(isr);  // 성능향상 / 라인단위로 읽기
		
		StringBuffer	  sb  = new StringBuffer();
		
		while(true) {
			
			String data = br.readLine();//라인단위로 읽기
			if(data==null) break;
			
			sb.append(data); // 라인단위 읽은 데이터 스트링버퍼에 넣는다
		}
		
		//Json Parsing
		JSONObject json = new JSONObject(sb.toString());
		
		JSONArray data_array = json.getJSONArray("data");
		
		double cal_per_unit = 0.0;
		String workout_name = null;
		
		for(int i=0; i<data_array.length(); i++) {
			
			JSONObject json_workout = data_array.getJSONObject(i);
			
			cal_per_unit = json_workout.getDouble("단위체중당에너지소비량");
			workout_name = json_workout.getString("운동명");
			
			if(workout_name.contains(keyword)) {
				WorkoutCaloryVo search_vo = new WorkoutCaloryVo(cal_per_unit, workout_name);
				list.add(search_vo);
			}
			
		}//end:for
		
		//System.out.println(list);
		
		return list;
	}
/*
	public static List<WorkoutCaloryVo> workout_search(WorkoutCaloryVo vo) throws IOException {
		// TODO Auto-generated method stub
		
		List<WorkoutCaloryVo> list = new ArrayList<WorkoutCaloryVo>();
		
		int page = vo.getPage();
		int perPage = vo.getPerPage();
		//String search_text = vo.getWorkout_name();
		
		String api_url = String.format("https://api.odcloud.kr/api/15068730/v1/uddi:734ff9bb-3696-4993-a365-c0201eb0a6cd?page=%d&perPage=%d&serviceKey=%s&search_text=",
				                                                                                                            page,    perPage,          serviceKey);
		//String workout_name = URLEncoder.encode(search_text, "utf-8");
		
		//String str_url = api_url+workout_name;
		String str_url = api_url;
		
		//System.out.println(str_url);
		
		URL url = new URL(str_url);
		
		HttpURLConnection urlconn = (HttpURLConnection) url.openConnection();
		//여기서 요청헤더 설정(네이버/카카오 아이디/비번설정)
		
		urlconn.connect();
		
		InputStream 	  is  = urlconn.getInputStream();
		InputStreamReader isr = new InputStreamReader(is, "utf-8");
		BufferedReader    br  = new BufferedReader(isr);  // 성능향상 / 라인단위로 읽기
		
		StringBuffer	  sb  = new StringBuffer();
		
		while(true) {
			
			String data = br.readLine();//라인단위로 읽기
			if(data==null) break;
			
			sb.append(data); // 라인단위 읽은 데이터 스트링버퍼에 넣는다
		}
		
		//Json Parsing
		JSONObject json = new JSONObject(sb.toString());
		
		JSONArray data_array = json.getJSONArray("data");
		
		double cal_per_unit = 0.0;
		String workout_name  = null;
		
		for(int i=0; i<data_array.length(); i++) {
			
			JSONObject json_workout = data_array.getJSONObject(i);
			
			cal_per_unit = json_workout.getDouble("단위체중당에너지소비량");
			workout_name = json_workout.getString("운동명");
			
			WorkoutCaloryVo search_vo = new WorkoutCaloryVo(cal_per_unit, workout_name);
			
			list.add(search_vo);
			
		}//end:for
				
		//System.out.println(list);
		
		return list;
	}
*/
}
