package util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import vo.FoodVo;

	public class FoodInfoSearchUtils {
		
		public static List<FoodVo> search_food_json(String desc_kor) throws Exception{
			
			List<FoodVo> list = new ArrayList<FoodVo>();
			String food_name = URLEncoder.encode(desc_kor, "utf-8");
			String URL_API = "http://apis.data.go.kr/1471000/FoodNtrIrdntInfoService1/getFoodNtrItdntList1?ServiceKey=a96J0tKvv02DQpyMUPbMo8WgC6a0q5i%2B%2Be%2FSDoDLhT%2B2edaiBWjzqdFxC1IZjI35XDHHWVLhB2HGo8b752r%2B1Q%3D%3D&type=json&pageNo=1&numOfRows=30&desc_kor=";
			String str_url = URL_API+food_name;
			
//			System.out.println(str_url);
			
			URL url = new URL(str_url);
			
			HttpURLConnection urlConn = (HttpURLConnection) url.openConnection();
			urlConn.connect();
			
			BufferedReader br = new BufferedReader(new InputStreamReader(urlConn.getInputStream(),"utf-8" ));
			StringBuffer sb = new StringBuffer();
			while(true) {
				
				String data = br.readLine();
				if(data==null) break;
				
				sb.append(data);
			}
			
			JSONObject json = new JSONObject(sb.toString());
			JSONArray foodArray = json.getJSONObject("body").getJSONArray("items");
			
			for(int i=0; i<foodArray.length(); i++) {
				JSONObject food = foodArray.getJSONObject(i);
				
				String f_name = food.optString("DESC_KOR", "");
				int f_unit_g = food.optInt("SERVING_WT", 0);
				double f_unit_kcal = food.optDouble("NUTR_CONT1", 0.0);
				String animal_plant = food.optString("ANIMAL_PLANT", "");
				
				FoodVo vo = new FoodVo();
				vo.setF_name(f_name);
				vo.setF_unit_g(f_unit_g);
				vo.setF_unit_kcal(f_unit_kcal);
				vo.setAnimal_plant(animal_plant);
				
				list.add(vo);
				
			}
			return list;
			
		}

}
