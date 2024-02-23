package controller.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import annotation.RequestMapping;
import annotation.ResponseBody;
import dao.CommentDao;
import myconstant.MyConstant;
import util.Paging;
import vo.CommentVo;

public class CommentController {
	
	@RequestMapping(value = "/board/comment_list.do")
	public String list(HttpServletRequest request, HttpServletResponse response) {
		
		// /board/comment_list.do?b_idx=5&page=1
		int nowPage = 1;
		
		int b_idx 	   = Integer.parseInt(request.getParameter("b_idx"));
		String strPage = request.getParameter("page");
		
		if(strPage!=null && !strPage.isEmpty()) {
			nowPage = Integer.parseInt(strPage);
		}
		
		int start	= (nowPage-1) * MyConstant.Comment.BLOCK_LIST + 1;
		int end		= start + MyConstant.Comment.BLOCK_LIST - 1;
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("b_idx", b_idx);
		map.put("start", start);
		map.put("end", end);
		
		List<CommentVo> cmt_list = CommentDao.getInstance().selectList(map);
		
		int rowTotal = CommentDao.getInstance().selectRowCount(b_idx);
		
		String pageMenu = Paging.getPaging("list.do",
				                            nowPage,
				                            rowTotal,
				                            MyConstant.Comment.BLOCK_LIST,
				                            MyConstant.Comment.BLOCK_PAGE);
		
		//request binding
		request.setAttribute("cmt_list", cmt_list);
		request.setAttribute("pageMenu", pageMenu);
		
		return "board_comment_list.jsp";
	}
	
	
	@RequestMapping(value = "/board/comment_insert.do", produces = "application/json; charset=utf-8;")
	@ResponseBody
	public String insert(HttpServletRequest request, HttpServletResponse response) {

		// /board/comment_insert.do?b_idx=5&cmt_content=댓글내용&mem_idx=1&mem_id=one&mem_name=일길동
		
		//1.parameter 받기
		int    b_idx 		= Integer.parseInt(request.getParameter("b_idx"));
		String cmt_content	= request.getParameter("cmt_content").replaceAll("\n", "<br>");
		int    mem_idx		= Integer.parseInt(request.getParameter("mem_idx"));
		String mem_name 	= request.getParameter("mem_name");
		String mem_id		= request.getParameter("mem_id");
		
		//2.작성자 아이피구하기
		String cmt_ip 		= request.getRemoteAddr();
		
		//3.CommentVo 포장
		CommentVo vo 		= new CommentVo(cmt_content, cmt_ip, b_idx, mem_idx, mem_id, mem_name);
		
		//4.DB Insert : res <-처리된 행수
		int res 			= CommentDao.getInstance().insert(vo);
		
		//5.결과를 JSON객체로 생성
		JSONObject json 	= new JSONObject();
		json.put("result", res==1); // {"result" : true}
		
		return json.toString();
	}
	
	
	@RequestMapping(value = "/board/comment_delete.do", produces = "application/json; charset=utf-8;")
	@ResponseBody
	public String delete(HttpServletRequest request, HttpServletResponse response) {
		
		// /board/comment_delete.do?cmt_idx=2
		// 1.parameter 받기
		int cmt_idx = Integer.parseInt(request.getParameter("cmt_idx"));
		
		// 2.DB delete
		int res = CommentDao.getInstance().delete(cmt_idx);
		
		// 3.결과->JSON객체로 생성
		JSONObject json = new JSONObject();
		
		if(res==1) {
			json.put("result", true);
		}else {
			json.put("result", false);
		}
		
		
		return json.toString();
	}
	
	
	
	
	
}
