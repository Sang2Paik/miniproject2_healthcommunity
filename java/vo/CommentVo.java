package vo;

public class CommentVo {
	int    cmt_idx;
	String cmt_content;
	String cmt_ip;
	String cmt_regdate;
	int	   b_idx;
	int	   user_idx;
	String user_id;
	String user_name;

	String user_mask_id;
	
	int	   no;



	//user_id중 앞쪽 반만 노출시키고 나머지는 **처리
	public String getuser_mask_id() {
		
		int length = user_id.length();
		int half   = length/2;
		
		StringBuffer sb = new StringBuffer(user_id.substring(0, half));
		for (int i = 0; i < length-half; i++) {
			sb.append("*");
		}
		return sb.toString();
	}
	
	
	public CommentVo() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public CommentVo(String cmt_content, String cmt_ip, int b_idx, int user_idx, String user_id, String user_name) {
		super();
		this.cmt_content = cmt_content;
		this.cmt_ip = cmt_ip;
		this.b_idx = b_idx;
		this.user_idx = user_idx;
		this.user_id = user_id;
		this.user_name = user_name;
	}
	
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getCmt_idx() {
		return cmt_idx;
	}
	public void setCmt_idx(int cmt_idx) {
		this.cmt_idx = cmt_idx;
	}
	public String getCmt_content() {
		return cmt_content;
	}
	public void setCmt_content(String cmt_content) {
		this.cmt_content = cmt_content;
	}
	public String getCmt_ip() {
		return cmt_ip;
	}
	public void setCmt_ip(String cmt_ip) {
		this.cmt_ip = cmt_ip;
	}
	public String getCmt_regdate() {
		return cmt_regdate;
	}
	public void setCmt_regdate(String cmt_regdate) {
		this.cmt_regdate = cmt_regdate;
	}
	public int getB_idx() {
		return b_idx;
	}
	public void setB_idx(int b_idx) {
		this.b_idx = b_idx;
	}
	public int getuser_idx() {
		return user_idx;
	}
	public void setuser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public String getuser_id() {
		return user_id;
	}
	public void setuser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getuser_name() {
		return user_name;
	}
	public void setuser_name(String user_name) {
		this.user_name = user_name;
	}

	
}
