package vo;

public class WorkoutVo {

	int w_idx;
	String w_name;
	String w_regdate;
	int w_time;
	double w_unit_kcal;
	int user_idx;
	String user_name;
	
	String w_unit_kcal_dot2;
	
	double total_sum;

	String regdate; //포맷수정date
	
	
	
	public WorkoutVo(String w_regdate, int user_idx, String user_name) {
		super();
		this.w_regdate = w_regdate;
		this.user_idx = user_idx;
		this.user_name = user_name;
	}


	public WorkoutVo(int user_idx, String user_name) {
		super();
		this.user_idx = user_idx;
		this.user_name = user_name;
	}


	public String getRegdate() {
		return regdate;
	}


	public double getTotal_sum() {
		return total_sum;
	}


	public WorkoutVo() {
		// TODO Auto-generated constructor stub
	}
	

	public WorkoutVo(String w_name, int w_time, Double w_unit_kcal, int user_idx, String user_name) {
		super();
		this.w_name = w_name;
		this.w_time = w_time;
		this.w_unit_kcal = w_unit_kcal;
		this.user_idx = user_idx;
		this.user_name = user_name;
	}

	public WorkoutVo(int w_idx, String w_name, String w_regdate, int w_time, Double w_unit_kcal, int user_idx) {
		super();
		this.w_idx = w_idx;
		this.w_name = w_name;
		this.w_regdate = w_regdate;
		this.w_time = w_time;
		this.w_unit_kcal = w_unit_kcal;
		this.user_idx = user_idx;
	}
	
	
	public String getW_unit_kcal_dot2() {
		return String.format("%.1f", w_unit_kcal);
	}


	public String getUser_name() {
		return user_name;
	}


	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public int getW_idx() {
		return w_idx;
	}
	public void setW_idx(int w_idx) {
		this.w_idx = w_idx;
	}
	public String getW_name() {
		return w_name;
	}
	public void setW_name(String w_name) {
		this.w_name = w_name;
	}
	public String getW_regdate() {
		return w_regdate;
	}
	public void setW_regdate(String w_regdate) {
		this.w_regdate = w_regdate;
	}
	public int getW_time() {
		return w_time;
	}
	public void setW_time(int w_time) {
		this.w_time = w_time;
	}
	public Double getW_unit_kcal() {
		return w_unit_kcal;
	}
	public void setW_unit_kcal(Double w_unit_kcal) {
		this.w_unit_kcal = w_unit_kcal;
	}
	public int getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	
	
	
}
