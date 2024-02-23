package vo;

public class WeatherVo {
	int   temp;
	int   temp_min;
	int   temp_max;
	String description;
	String icon;
	String name; //동이름
	
	public WeatherVo() {
		// TODO Auto-generated constructor stub
	}
	
	public WeatherVo(int temp, int temp_min, int temp_max, String description, String icon, String name) {
		super();
		this.temp = temp;
		this.temp_min = temp_min;
		this.temp_max = temp_max;
		this.description = description;
		this.icon = icon;
		this.name = name;
	}
	public int getTemp() {
		return temp;
	}
	public void setTemp(int temp) {
		this.temp = temp;
	}
	public int getTemp_min() {
		return temp_min;
	}
	public void setTemp_min(int temp_min) {
		this.temp_min = temp_min;
	}
	public int getTemp_max() {
		return temp_max;
	}
	public void setTemp_max(int temp_max) {
		this.temp_max = temp_max;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
	
	
	
		
}