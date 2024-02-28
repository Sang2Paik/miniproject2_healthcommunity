package vo;

public class WorkoutCaloryVo {
	double	cal_per_unit;
	String	workout_name;
	int     page;
	int     perPage;
	
	
	
	public WorkoutCaloryVo(String workout_name, int page, int perPage) {
		super();
		this.workout_name = workout_name;
		this.page = page;
		this.perPage = perPage;
	}
	public WorkoutCaloryVo(double cal_per_unit, String workout_name) {
		super();
		this.cal_per_unit = cal_per_unit;
		this.workout_name = workout_name;
	}
	public double getCal_per_unit() {
		return cal_per_unit;
	}
	public void setCal_per_unit(double cal_per_unit) {
		this.cal_per_unit = cal_per_unit;
	}
	public String getWorkout_name() {
		return workout_name;
	}
	public void setWorkout_name(String workout_name) {
		this.workout_name = workout_name;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getPerPage() {
		return perPage;
	}
	public void setPerPage(int perPage) {
		this.perPage = perPage;
	}
	
	

	
}
