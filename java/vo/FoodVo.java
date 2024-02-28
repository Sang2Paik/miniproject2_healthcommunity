package vo;

public class FoodVo {
	
	//DB에 넣을부분 
	int f_no;				//등록 완료시 생성되는 번호  ifnull(max(f_no),0)
	int f_idx;				//음식 메뉴마다 등록되는 번호  auto_increment
	String f_name;
	String f_eattime;
	int m_idx;
	String m_name;
	String f_regdate;
	int f_unit_g;
	double f_unit_kcal;
	double f_csum_g;
	int user_idx;
	String f_maker;			//제조사
	double f_csum_kcal;
	
	double f_total_kcal;
	String f_eat_date;
	
	
	//API에서가져와 보여주기만 할 값
	double carbo;   // 탄수화물
	double protein; // 단백질
	double fat;     // 지방
	double sweet;   // 당
	double natrium; // 나트륨
	double chole;   // 콜레스테롤
	double sat_fat; // 포화지방산
	double trans_fat; // 트랜스지방산
		
	
	public FoodVo() {
		// TODO Auto-generated constructor stub
	}
	
	
	// 내가 먹은 음식에 담기시 생성자 : 이름, 단위칼로리, 단위량, 제조사
	public FoodVo(String f_name, String f_eattime, int m_idx, String m_name, int f_unit_g, double f_unit_kcal,
			double f_csum_g, String f_maker, int user_idx) {
		super();
		this.f_name = f_name;
		this.f_eattime = f_eattime;
		this.m_idx = m_idx;
		this.m_name = m_name;
		this.f_unit_g = f_unit_g;
		this.f_unit_kcal = f_unit_kcal;
		this.f_csum_g = f_csum_g;
		this.f_maker = f_maker;
		this.user_idx = user_idx;
	}
	
	
	// 찾은 리스트 생성자

	public FoodVo(String f_name, int f_unit_g, double f_unit_kcal, String f_maker, double carbo, double protein,
			double fat, double sweet, double natrium, double chole, double sat_fat, double trans_fat) {
		super();
		this.f_name = f_name;
		this.f_unit_g = f_unit_g;
		this.f_unit_kcal = f_unit_kcal;
		this.f_maker = f_maker;
		this.carbo = carbo;
		this.protein = protein;
		this.fat = fat;
		this.sweet = sweet;
		this.natrium = natrium;
		this.chole = chole;
		this.sat_fat = sat_fat;
		this.trans_fat = trans_fat;
	}
	
	//중복값 체크시 사용
	
	public FoodVo(String f_name, double f_unit_kcal, int user_idx, String f_maker) {
		super();
		this.f_name = f_name;
		this.f_unit_kcal = f_unit_kcal;
		this.user_idx = user_idx;
		this.f_maker = f_maker;
	}
	


	public int getF_no() {
		return f_no;
	}


	public void setF_no(int f_no) {
		this.f_no = f_no;
	}


	public int getF_idx() {
		return f_idx;
	}


	public void setF_idx(int f_idx) {
		this.f_idx = f_idx;
	}


	public String getF_name() {
		return f_name;
	}


	public void setF_name(String f_name) {
		this.f_name = f_name;
	}


	public String getF_eattime() {
		return f_eattime;
	}


	public void setF_eattime(String f_eattime) {
		this.f_eattime = f_eattime;
	}


	public int getM_idx() {
		return m_idx;
	}


	public void setM_idx(int m_idx) {
		this.m_idx = m_idx;
	}


	public String getM_name() {
		return m_name;
	}


	public void setM_name(String m_name) {
		this.m_name = m_name;
	}


	public String getF_regdate() {
		return f_regdate;
	}


	public void setF_regdate(String f_regdate) {
		this.f_regdate = f_regdate;
	}


	public int getF_unit_g() {
		return f_unit_g;
	}


	public void setF_unit_g(int f_unit_g) {
		this.f_unit_g = f_unit_g;
	}


	public double getF_unit_kcal() {
		return f_unit_kcal;
	}


	public void setF_unit_kcal(double f_unit_kcal) {
		this.f_unit_kcal = f_unit_kcal;
	}


	public double getF_csum_g() {
		return f_csum_g;
	}


	public void setF_csum_g(double f_csum_g) {
		this.f_csum_g = f_csum_g;
	}


	public int getUser_idx() {
		return user_idx;
	}


	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}


	public String getF_maker() {
		return f_maker;
	}


	public void setF_maker(String f_maker) {
		this.f_maker = f_maker;
	}


	public double getCarbo() {
		return carbo;
	}


	public void setCarbo(double carbo) {
		this.carbo = carbo;
	}


	public double getProtein() {
		return protein;
	}


	public void setProtein(double protein) {
		this.protein = protein;
	}


	public double getFat() {
		return fat;
	}


	public void setFat(double fat) {
		this.fat = fat;
	}


	public double getSweet() {
		return sweet;
	}


	public void setSweet(double sweet) {
		this.sweet = sweet;
	}


	public double getNatrium() {
		return natrium;
	}


	public void setNatrium(double natrium) {
		this.natrium = natrium;
	}


	public double getChole() {
		return chole;
	}


	public void setChole(double chole) {
		this.chole = chole;
	}


	public double getSat_fat() {
		return sat_fat;
	}


	public void setSat_fat(double sat_fat) {
		this.sat_fat = sat_fat;
	}


	public double getTrans_fat() {
		return trans_fat;
	}


	public void setTrans_fat(double trans_fat) {
		this.trans_fat = trans_fat;
	}
	
	public double getF_csum_kcal() {
		return f_csum_kcal;
	}


	public void setF_csum_kcal(double f_csum_kcal) {
		this.f_csum_kcal = f_csum_kcal;
	}
	
	


	public double getF_total_kcal() {
		return f_total_kcal;
	}


	public void setF_total_kcal(double f_total_kcal) {
		this.f_total_kcal = f_total_kcal;
	}


	public String getF_eat_date() {
		return f_eat_date;
	}


	public void setF_eat_date(String f_eat_date) {
		this.f_eat_date = f_eat_date;
	}

	
	

}
