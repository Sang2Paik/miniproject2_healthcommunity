package util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import vo.FoodVo;

public class FoodSearchUtils {

	static String API_URL = "http://apis.data.go.kr/1471000/FoodNtrIrdntInfoService1/getFoodNtrItdntList1?ServiceKey=a96J0tKvv02DQpyMUPbMo8WgC6a0q5i%2B%2Be%2FSDoDLhT%2B2edaiBWjzqdFxC1IZjI35XDHHWVLhB2HGo8b752r%2B1Q%3D%3D&numOfRows=30&pageNo=1&type=json&desc_kor=";

	public static List<FoodVo> search_food_json(String desc_kor) throws Exception{

		List<FoodVo> list = new ArrayList<FoodVo>();

		String food_name = URLEncoder.encode(desc_kor, "utf-8");
		String str_url = API_URL+food_name;

		URL url = new URL(str_url);
		//System.out.println(str_url);
		HttpURLConnection urlConn = (HttpURLConnection) url.openConnection();

		urlConn.connect();
		BufferedReader br = new BufferedReader(new InputStreamReader(urlConn.getInputStream(), "utf-8"));

		StringBuffer sb = new StringBuffer();
		while(true) {
			String data = br.readLine();
			if(data==null) break;

			sb.append(data);
		}

		//json객체로 만들기
		JSONObject json = new JSONObject(sb.toString());
		JSONArray foodArray = json.getJSONObject("body").getJSONArray("items");

		for(int i=0; i<foodArray.length(); i++) {

			JSONObject food = foodArray.getJSONObject(i);

			String f_name = food.optString("DESC_KOR", "");
			String f_maker = food.optString("ANIMAL_PLANT", "");

			int f_unit_g = 0;
			double f_unit_kcal = 0.0;
			double carbo = 0.0;
			double protein = 0.0;
			double fat = 0.0;
			double sweet = 0.0;
			double natrium = 0.0;
			double chole = 0.0;
			double sat_fat = 0.0;
			double trans_fat = 0.0;

			try {
				f_unit_g = food.getInt("SERVING_WT");
				f_unit_kcal = food.getDouble("NUTR_CONT1");
				carbo = food.getDouble("NUTR_CONT2");
				protein = food.getDouble("NUTR_CONT3");
				fat = food.getDouble("NUTR_CONT4");
				sweet = food.getDouble("NUTR_CONT5");
				natrium = food.getDouble("NUTR_CONT6");
				chole = food.getDouble("NUTR_CONT7");
				sat_fat = food.getDouble("NUTR_CONT8");
				trans_fat = food.getDouble("NUTR_CONT9");

			} catch (Exception e) {
				// TODO Auto-generated catch block

			}

		FoodVo vo = new FoodVo(f_name, f_unit_g, f_unit_kcal, f_maker, carbo, protein, fat, sweet, natrium, chole, sat_fat, trans_fat);
		list.add(vo);

		}

		return list;
	}

}