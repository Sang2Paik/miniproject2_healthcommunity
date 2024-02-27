package controller.action;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import annotation.RequestMapping;
import annotation.ResponseBody;
import dao.BoardDao;
import dao.CategoryDao;
import dao.CommentDao;
import myconstant.MyConstant;
import util.Paging;
import vo.BoardVo;
import vo.CategoryVo;
import vo.UserVo;

public class BoardController {

	//보드 목록으로 redirect
	@RequestMapping(value = "/board/board_home.do")
	public String board_list_redirect(HttpServletRequest request, HttpServletResponse response) {

		return "redirect:list.do";
	}
	
	//목록보기
	@RequestMapping("/board/list.do")
	public String list(HttpServletRequest request, HttpServletResponse response) {

		// /board/list.do
		// /board/list.do?page=
		// /board/list.do?page=1&search=&search_text=
		// /board/list.do?page=2&search=name&search_text=길동
		
		int nowPage = 1;
		
		String  page 		= request.getParameter("page");
		String  search		= request.getParameter("search"); 
		String  search_text	= request.getParameter("search_text"); 
		
		
		if(search==null || search.isEmpty())
			search = "all";
		
		
		if(page!=null && !page.isEmpty())
		   nowPage = Integer.parseInt(page);
		
		//start / end 계산
		int start = (nowPage-1) * MyConstant.Board.BLOCK_LIST + 1;
		int end   = start + MyConstant.Board.BLOCK_LIST - 1;
		
		//검색조건에 대한 정보를  맵으로 포장
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("start", start);
		map.put("end", end);
		
		if(search.equals("subject_content")) {
			// 제목 + 내용
			map.put("subject", search_text);
			map.put("content", search_text);
		
		}else if(search.equals("name")) {
			// 이름
			map.put("name", search_text);
			
		}else if(search.equals("subject")) {
			// 제목
			map.put("subject", search_text);
			
		}else if(search.equals("content")) {
			// 내용
			map.put("content", search_text);
		}

		//게시판 목록 가져오기
		List<BoardVo> list = BoardDao.getInstance().selectList(map);

		//Page Menu생성
		int rowTotal = BoardDao.getInstance().selectRowTotal(map);

		String search_filter = String.format("&search=%s&search_text=%s", search, search_text);

		String pageMenu = Paging.getPaging("list.do", 
				                             search_filter,	//검색조건
				                             nowPage,   	//현재페이지 
				                             rowTotal,  	//전체게시물수
				                             MyConstant.Board.BLOCK_LIST,  //1화면에 보여질 게시물수 
				                             MyConstant.Board.BLOCK_PAGE); //1화면에 보여질 메뉴수

		//세션에 게시물을 봤다는 정보를 삭제
		request.getSession().removeAttribute("show");
		request.getSession().removeAttribute("like");

		//카테고리얻어오기
		List<CategoryVo> category_list = CategoryDao.getInstance().selectList();

		//request binding
		request.setAttribute("list", list);
		request.setAttribute("category_list", category_list);
		request.setAttribute("pageMenu", pageMenu);


		return "board_list.jsp";
	}


	//상세보기
	@RequestMapping("/board/board_view.do")
	public String view(HttpServletRequest request, HttpServletResponse response) {
		// /board/view.do?b_idx=1
		int 	b_idx = Integer.parseInt(request.getParameter("b_idx"));
		String	page		= request.getParameter("page");
		String	search		= request.getParameter("search");
		String	search_text	= request.getParameter("search_text");
		
		
		if(search==null || search.isEmpty())
			search = "all";
		
		BoardVo vo = BoardDao.getInstance().selectOne(b_idx);
		
		
		//세션에서 게시물을 봤는지에 대한 체크
		if(request.getSession().getAttribute("show")==null) {
			//조회수 증가
			BoardDao.getInstance().update_readhit(b_idx);
			request.getSession().setAttribute("show", true);
		}
		
		//request binding
		request.setAttribute("vo", vo);
		request.setAttribute("page", page);
		request.setAttribute("search", search);
		request.setAttribute("search_text", search_text);
		
		return "board_view.jsp";
	}
	
	//글쓰기폼
	@RequestMapping("/board/insert_form.do")
	public String insert_form(HttpServletRequest request, HttpServletResponse response) {

		//5.카테고리에 저장
		List<CategoryVo> c_list = CategoryDao.getInstance().selectList();
		
		request.setAttribute("c_list", c_list);
		
		return "board_insert_form.jsp";
	}

	//글쓰기
	@RequestMapping("/board/insert.do")
	public String insert(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		// /board/insert.do?b_subject=제목&b_content=내용
		
		UserVo user = (UserVo) request.getSession().getAttribute("user");
		
		if(user==null) {
			
			//세션만료시(로그아웃)
			return "redirect:../user/login_form.do?reason=session_timeout";
		}
		
		//상대경로->절대경로를 구하기
		ServletContext application = request.getServletContext();
		
		String webPath = "/upload/";	//웹경로(상대적경로)
		//                         "c:\\work"
		String saveDir = application.getRealPath(webPath);	//저장위치(절대경로)
		/* System.out.println(saveDir); */
		
		int	   maxSize = 1024*1044*100;	//업로드(최대)크기(byte)
		MultipartRequest mr = new MultipartRequest(request, // request 처리 위임
				saveDir, // 저장위치(절대경로)
				maxSize,	// 업로드크기
				"utf-8", // 인코딩
				new DefaultFileRenamePolicy() // 동일화일인 경우 이름을 변경해서 저장
				);
		
		//업로드된 화일명 얻어온다
		// 방법1)
		// String filename = mr.getOriginalFileName("photo");
		// System.out.println(filename);
		
		// 방법2)
		String p_filename="no_file";
		//업로드된 화일정보 얻어온다
		File f1 = mr.getFile("b_photo"); // 올릴 파라메터name
		if(f1!=null) {
			p_filename=f1.getName();
		}
		
		/* System.out.println(photo); */
		//1.parameter받기
		String b_subject = mr.getParameter("b_subject");
		String b_content = mr.getParameter("b_content").replaceAll("\n", "<br>");
		String c_name	 = mr.getParameter("c_name");
		String b_open	 = mr.getParameter("b_open");
		
		//2.ip구하기
		String b_ip		 = request.getRemoteAddr();

		//4.등록회원정보
		int user_idx     = user.getuser_idx();
		String user_name = user.getuser_name();
		String user_id	 = user.getuser_id();
		
		int c_idx = CategoryDao.getInstance().selectOne(c_name);
		
		//5.BoardVo 포장
		BoardVo vo = new BoardVo(b_subject, c_idx, c_name, b_content, p_filename,
								 b_ip, b_open, user_idx, user_id, user_name);
		
		//6.DB insert
		BoardDao.getInstance().insert(vo);		
		
		
		return "redirect:list.do";
	}
	
	
	
	//좋아요 누르면 좋아요 수 증가
	@RequestMapping("/board/board_like.do")
	public String board_like(HttpServletRequest request, HttpServletResponse response) {

		int		b_idx		= Integer.parseInt(request.getParameter("b_idx"));
		String	page		= request.getParameter("page");
		String	search		= request.getParameter("search");
		String	search_text	= request.getParameter("search_text");
		
		if(search==null || search.isEmpty())
			search = "all";
		
		
		//세션에서 게시물을 봤는지에 대한 체크
		if(request.getSession().getAttribute("like")==null) {
			
			BoardVo vo = BoardDao.getInstance().selectOne(b_idx);
			//조회수 증가
			BoardDao.getInstance().update_like(vo);
			request.getSession().setAttribute("like", true);
		}
		
		return String.format("redirect:board_view.do?b_idx=%d&page=%s&search=%s&search_text=%s",
		b_idx, page, search, search_text);
	}
	
	
	//삭제하기
	@RequestMapping("/board/delete.do")
	public String delete(HttpServletRequest request, HttpServletResponse response) {

		// /board/delete.do?b_idx=13&page=2
		
		int		b_idx		= Integer.parseInt(request.getParameter("b_idx"));
		String	page		= request.getParameter("page");
		String	search		= request.getParameter("search");
		String	search_text	= request.getParameter("search_text");
		
		
		if(search==null || search.isEmpty())
			search = "all";
		
		//댓글삭제
		CommentDao.getInstance().delete_b_idx(b_idx);
		
		BoardVo vo = BoardDao.getInstance().selectOne(b_idx);
		
		//3.절대경로 구하기
		String absPath = request.getServletContext().getRealPath("/upload/");
		//System.out.println(absPath);
		
		//4.삭제화일정보 얻어오기->삭제처리
		File f = new File(absPath, vo.getB_photo());
		f.delete();
		
		//게시물삭제
		BoardDao.getInstance().BoardDelete(b_idx);
		
		
		return String.format("redirect:list.do?page=%s&search=%s&search_text=%s"
													, page, search, search_text);
		
	}
	
	
	//수정폼
	@RequestMapping("/board/modify_form.do")
	public String modify_form(HttpServletRequest request, HttpServletResponse response) {

		// /board/modify_form.do?b_idx=11
		//1.parameter받기
		int b_idx = Integer.parseInt(request.getParameter("b_idx"));
		
		String	page		= request.getParameter("page");
		String	search		= request.getParameter("search");
		String	search_text	= request.getParameter("search_text");
		
		if(search==null || search.isEmpty())
			search = "all";
		
		
		//2.수정할 원본게시물 정보 얻어오기
		BoardVo vo = BoardDao.getInstance().selectOne(b_idx);
		
		//3. <br> -> \n
		String b_content = vo.getB_content().replaceAll("<br>", "\n");
		vo.setB_content(b_content);
		
		//4.request binding
		request.setAttribute("page", page);
		request.setAttribute("search", search);
		request.setAttribute("search_text", search_text);
		request.setAttribute("vo", vo);
				
		return "board_modify_form.jsp";
	}
	
	//보드 이미지 업로드 수정폼
	@RequestMapping(value = "/board/photo_upload.do", produces = "application/json; charset=utf-8;")
	@ResponseBody
	public String photo_upload(HttpServletRequest request, HttpServletResponse response) throws IOException {

		ServletContext application = request.getServletContext();
		
			String webPath = "/upload/";         //웹경로(상대적경로) 
			//                                   저장위치(절대경로)
			String saveDir = application.getRealPath(webPath);
			
			int    maxSize    = 1024*1024*100;   //업로드(최대)크기(byte)
					
			MultipartRequest  mr = new MultipartRequest(request,//처리위임 
					                                    saveDir,//저장위치(절대경로) 
					                                    maxSize,//업로드크기
					                                    "utf-8",//수신인코딩 
					                                    //동일화일인경우 이름을 변경해서 저장
					                                    new DefaultFileRenamePolicy()
					                                    );
			//업로드된 화일명 얻어온다
			String p_filename="no_file";
			//업로드된 화일정보 얻어온다
			File f = mr.getFile("b_photo");
			if(f != null) {
				p_filename = f.getName();
			}
			
			
			//삭제할 기존 업로드 이미지 가져오기
			int b_idx = Integer.parseInt(mr.getParameter("b_idx"));
			BoardVo vo = BoardDao.getInstance().selectOne(b_idx);
			//기존화일을 삭제
			File oldFile = new File(saveDir,vo.getB_photo());
			oldFile.delete();
			
		vo.setB_photo(p_filename);
		
		BoardDao.getInstance().update_b_photo(vo);
		
		JSONObject json = new JSONObject();
		json.put("p_filename", p_filename);
		
		return json.toString();
	}
	
	
	//보드수정하기
	@RequestMapping("/board/modify.do")
	public String modify(HttpServletRequest request, HttpServletResponse response) {
		
		// /board/insert.do?b_idx=13&b_subject=제목&b_content=내용&page=4
		
		UserVo user = (UserVo) request.getSession().getAttribute("user");
		
		if(user==null) {
		
			//세션만료시(로그아웃)
			return "redirect:../user/login_form.do?reason=session_timeout";
		}
		
		
		
		//1.parameter받기
		int    b_idx     	= Integer.parseInt(request.getParameter("b_idx"));
		String b_subject 	= request.getParameter("b_subject");
		String b_content 	= request.getParameter("b_content").replaceAll("\n", "<br>");
		String page		 	= request.getParameter("page");
		String search	 	= request.getParameter("search");
		String search_text	= request.getParameter("search_text");
		
		if(search==null || search.isEmpty())
			search = "all";
		
		//2.ip구하기
		String b_ip			= request.getRemoteAddr();
				
		//3.BoardVo 포장
		BoardVo vo = new BoardVo(b_idx, b_subject, b_content, b_ip);
		
		
		//4.DB insert
		BoardDao.getInstance().update(vo);		
		
		//수정된 게시물 보기
		//return "redirect:view.do?b_idx=" + b_idx + "&page=" + page ;
		return String.format("redirect:board_view.do?b_idx=%d&page=%s&search=%s&search_text=%s", b_idx, page, search, search_text);
	}
	
	//카테고리 클릭시 카테고리출력
	@RequestMapping(value = "/board/board_category_search.do")
	public String board_category_search(HttpServletRequest request, HttpServletResponse response) {
		// /board/board_category.do?c_idx=2

		
		//파라메터 얻어오기
		int	   c_idx	= Integer.parseInt(request.getParameter("c_idx"));
		//c_idx와 동일한 c_name 얻어오기(카테고리 이름 얻어오기)
		String c_name	= CategoryDao.getInstance().selectListName(c_idx);
		
		//c_name과 동일한 카테고리 얻어오기
		List<BoardVo> board_c_name_list = BoardDao.getInstance().selectListCategoryName(c_name);
		
		//출력할 카테고리 메뉴
		List<CategoryVo> category_list = CategoryDao.getInstance().selectList();
		
		//request binding
		request.setAttribute("board_c_name_list", board_c_name_list);
		request.setAttribute("category_list", category_list);
		
		
		return "board_list.jsp";
	}
	
	// 마이페이지 정보 얻어오기
	@RequestMapping(value = "/board/my_health_list.do")
	public String my_health(HttpServletRequest request, HttpServletResponse response) {
		
		//파라메터 받아오기
		int user_idx = Integer.parseInt(request.getParameter("user_idx"));
		
		BoardVo vo_my_health = BoardDao.getInstance().selectOne(user_idx);
		
		request.setAttribute("vo_my_health", vo_my_health);
		
		
		return "../mypage/mypage.jsp";
	}
}







