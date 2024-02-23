package vo;

public class BoardVo {

	int 	b_idx;			//게시판번호
	String	b_subject;		//제목
	int		c_idx;			//카테고리번호
	String	c_name;			//카테고리이름
	String	b_content;		//내용
	String 	b_photo;		//사진
	String	b_ip;			//아이피
	String	b_regdate;		//생성일자
	String	b_modify_date;	//수정일자
	int		b_readhit;		//조회수
	String	b_like;			//좋아요 수
	String	b_open;			//공개여부
	int		user_idx;		//유저번호
	String	user_id;		//유저아이디
	String	user_name;		//유저이름
	
	int		cmt_count;		// 댓글갯수
	
	
	
	public BoardVo() {
		// TODO Auto-generated constructor stub
	}
	//boardInsert
	public BoardVo(String b_subject, int c_idx, String c_name, String b_content, String b_photo,
			String b_ip, String b_open, int user_idx, String user_id, String user_name) {
		super();
		this.b_subject 		= b_subject;
		this.c_idx 			= c_idx;
		this.c_name 		= c_name;
		this.b_content 		= b_content;
		this.b_photo 		= b_photo;
		this.b_ip 			= b_ip;
		this.b_open 		= b_open;
		this.user_idx 		= user_idx;
		this.user_id 		= user_id;
		this.user_name 		= user_name;
	}
	
	
	
	public BoardVo(int b_idx, String b_subject, int c_idx, String c_name, String b_content, String b_photo, 
				   String b_ip, String b_regdate, String b_open, int user_idx, String user_name) {
		super();
		this.b_idx 		= b_idx;
		this.b_subject 	= b_subject;
		this.c_idx 		= c_idx;
		this.c_name 	= c_name;
		this.b_content 	= b_content;
		this.b_photo	= b_photo;
		this.b_ip 		= b_ip;
		this.b_regdate 	= b_regdate;
		this.b_open 	= b_open;
		this.user_idx 	= user_idx;
		this.user_name 	= user_name;
	}
	

	
	public BoardVo(int b_idx, String b_subject, String b_content, String b_ip, int user_idx, String user_name) {
		super();
		this.b_idx 		= b_idx;
		this.b_subject 	= b_subject;
		this.b_content 	= b_content;
		this.b_ip 		= b_ip;
		this.user_idx 	= user_idx;
		this.user_name 	= user_name;
	}




	public BoardVo(int b_idx, String b_subject, String b_content, String b_ip) {
		super();
		this.b_idx 		= b_idx;
		this.b_subject 	= b_subject;
		this.b_content 	= b_content;
		this.b_ip 		= b_ip;
	}
	
	
	public int getCmt_count() {
		return cmt_count;
	}


	public void setCmt_count(int cmt_count) {
		this.cmt_count = cmt_count;
	}


	public int getB_idx() {
		return b_idx;
	}


	public String getB_photo() {
		return b_photo;
	}
	
	public void setB_photo(String b_photo) {
		this.b_photo = b_photo;
	}
	
	public void setB_idx(int b_idx) {
		this.b_idx = b_idx;
	}


	public String getB_subject() {
		return b_subject;
	}


	public void setB_subject(String b_subject) {
		this.b_subject = b_subject;
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


	public String getB_content() {
		return b_content;
	}


	public void setB_content(String b_content) {
		this.b_content = b_content;
	}


	public String getB_ip() {
		return b_ip;
	}


	public void setB_ip(String b_ip) {
		this.b_ip = b_ip;
	}


	public String getB_regdate() {
		return b_regdate;
	}


	public void setB_regdate(String b_regdate) {
		this.b_regdate = b_regdate;
	}


	public String getB_modify_date() {
		return b_modify_date;
	}


	public void setB_modify_date(String b_modify_date) {
		this.b_modify_date = b_modify_date;
	}


	public int getB_readhit() {
		return b_readhit;
	}


	public void setB_readhit(int b_readhit) {
		this.b_readhit = b_readhit;
	}


	public String getB_like() {
		return b_like;
	}


	public void setB_like(String b_like) {
		this.b_like = b_like;
	}


	public String getB_open() {
		return b_open;
	}


	public void setB_open(String b_open) {
		this.b_open = b_open;
	}


	public int getUser_idx() {
		return user_idx;
	}


	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}


	public String getUser_name() {
		return user_name;
	}


	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}


	public String getUser_id() {
		return user_id;
	}


	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	
	
	
}
