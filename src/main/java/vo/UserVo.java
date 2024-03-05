package vo;

public class UserVo {

	int    user_idx;
	String user_name;
	String user_id;
	String user_pwd;
	int    user_age;
	String user_email;
	String user_gender;
	Double user_height;
	Double user_kg;
	Double user_target;
	String user_ip;
	String user_created_date;
	String user_modified_date;
	String user_grade;
	double user_BMI;
	
	String user_mask_pwd;
	
	/* ${ vo.user_mask_pwd } */
	public String getuser_mask_pwd() {
		
		int len = user_pwd.length();
		StringBuffer sb = new StringBuffer();
		sb.append(user_pwd.substring(0, len / 2));
		
		for (int i =len / 2; i < len; i++) {
			sb.append("*");
		}
		return sb.toString();
		
	}

	public UserVo() {
		// TODO Auto-generated constructor stub
	}
	
	// insert
	public UserVo(String user_name, String user_id, String user_pwd, int user_age, String user_email, String user_gender,
			Double user_height,Double user_kg, Double user_target, String user_grade,String user_ip) {
		super();
		this.user_name 	 = user_name;
		this.user_id 	 = user_id;
		this.user_pwd 	 = user_pwd;
		this.user_age 	 = user_age;
		this.user_email  = user_email;
		this.user_gender = user_gender;
		this.user_height = user_height;
		this.user_kg 	 = user_kg;
		this.user_target = user_target;
		this.user_grade  = user_grade;
		this.user_ip 	 = user_ip;
	}
	
	// update
	public UserVo(int user_idx, String user_name, String user_id, String user_pwd, int user_age, String user_email, String user_gender,
			Double user_height, Double user_kg, Double user_target, String user_ip,String user_grade) {
		super();
		this.user_idx 	 = user_idx;
		this.user_name 	 = user_name;
		this.user_id 	 = user_id;
		this.user_pwd 	 = user_pwd;
		this.user_age 	 = user_age;
		this.user_email  = user_email;
		this.user_gender = user_gender;
		this.user_height = user_height;
		this.user_kg 	 = user_kg;
		this.user_target = user_target;
		this.user_ip 	 = user_ip;
		this.user_grade  = user_grade;
	}

	//admin이 user 수정
	// update
	public UserVo(int user_idx, String user_name, String user_id, String user_pwd, int user_age, String user_email, String user_gender,
			 String user_ip,String user_grade) {
		super();
		this.user_idx 	 = user_idx;
		this.user_name   = user_name;
		this.user_id 	 = user_id;
		this.user_pwd 	 = user_pwd;
		this.user_age 	 = user_age;
		this.user_email  = user_email;
		this.user_gender = user_gender;
		this.user_ip 	 = user_ip;
		this.user_grade  = user_grade;
		}

	public int getuser_idx() {
		return user_idx;
	}
	public void setuser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public String getuser_name() {
		return user_name;
	}
	public void setuser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getuser_id() {
		return user_id;
	}
	public void setuser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getuser_pwd() {
		return user_pwd;
	}
	public void setuser_pwd(String user_pwd) {
		this.user_pwd = user_pwd;
	}
	public int getUser_age() {
		return user_age;
	}
	public void setUser_age(int user_age) {
		this.user_age = user_age;
	}
	public String getuser_email() {
		return user_email;
	}
	public void setuser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getuser_gender() {
		return user_gender;
	}
	public void setuser_gender(String user_gender) {
		this.user_gender = user_gender;
	}
	public Double getuser_height() {
		return user_height;
	}
	public void setuser_height(Double user_height) {
		this.user_height = user_height;
	}
	public Double getUser_kg() {
		return user_kg;
	}
	public void setUser_kg(Double user_kg) {
		this.user_kg = user_kg;
	}
	public String getuser_ip() {
		return user_ip;
	}
	public Double getUser_target() {
		return user_target;
	}
	public void setUser_target(Double user_target) {
		this.user_target = user_target;
	}

	public void setuser_ip(String user_ip) {
		this.user_ip = user_ip;
	}
	public String getuser_created_date() {
		return user_created_date;
	}
	public void setuser_created_date(String user_created_date) {
		this.user_created_date = user_created_date;
	}
	public String getuser_modified_date() {
		return user_modified_date;
	}
	public void setuser_modified_date(String user_modified_date) {
		this.user_modified_date = user_modified_date;
	}
	public String getuser_grade() {
		return user_grade;
	}
	public void setuser_grade(String user_grade) {
		this.user_grade = user_grade;
	}
	public double getUser_BMI() {
		return user_BMI;
	}
	public void setUser_BMI(double user_BMI) {
		this.user_BMI = user_BMI;
	}
	
	
		
}
