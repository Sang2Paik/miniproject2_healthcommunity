package vo;

public class CategoryVo {
	int 	c_idx;
	String 	c_name;
	
	
	
	public CategoryVo() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	public CategoryVo(String c_name) {
		super();
		this.c_name = c_name;
	}


	public int getC_idx() {
		return c_idx;
	}
	public void setC_idx(int c_idx) {
		this.c_idx = c_idx;
	}
	public String getC_name() {
		return c_name;
	}
	public void setC_name(String c_name) {
		this.c_name = c_name;
	}
	
	
	
}
