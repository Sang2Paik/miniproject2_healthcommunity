<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
	cmt_1, cmt_2{
		font-size: 10px;
		color: #999999;
	}
</style>

<script type="text/javascript">
	
	
	
	function delete_comment(cmt_idx) {
		// alert(cmt_idx);
		// board_view.jsp에 ajax로 응답된 페이지이기 때문에 view.do와 한페이지로 인식된다
		//comment_list(g_cmt_page)
		
		if(confirm("댓글을 삭제하시겠습니까?")==false) return;
		
		//Ajax 통해서 삭제
		$.ajax({
			url		 :	"comment_delete.do",
			data	 :	{ "cmt_idx" : cmt_idx },
			dataType :	"json",
			success	 :	function(res_data){
				// res_data = { "result" : true } or {"result" : false }
				if(res_data.result){
					//성공
					comment_list(g_cmt_page); // 댓글목록 갱신해라
				}else{
					//실패
					alert('삭제를 실패했습니다');
				}
			},
			error	 :	function(err){
				alert(err.responseText);
			}
			
		});
		
	}

</script>


</head>
<body>

	<!-- pageMenu -->
	<!-- CommentController에서 아래와 같이 생성해서 와야 된다 : Pageing.getCommentPaging -->
	<c:if test="${ not empty cmt_list }">
		${ pageMenu }
	</c:if>

	
	
	<c:forEach var="cmt" items="${ cmt_list }">
		
		<!-- 1번째줄 -->
		<div class="row" class="cmt_1">
			<div class="col-sm-9">
				<b>${ cmt.no }. ${ cmt.user_name }(${ cmt.user_mask_id })</b>
			</div>
			<div class="col-sm-3">
				<!-- 본인글인 경우만 보여준다 -->
				<c:if test="${ user.user_idx eq cmt.user_idx }">
					<input class="btn btn-warning" type="button" value="x" 
							onclick="delete_comment(${ cmt.cmt_idx });">
				</c:if>
			</div>
		</div>
		
		<!-- 2번째줄 -->
		<div class="cmt_2">
			<b>${ cmt.cmt_regdate }</b>
		</div>
		
		<!-- 3번째줄 -->
		<div class="cmt_3">
			${ cmt.cmt_content }
		</div>
		<hr>
	</c:forEach>
</body>
</html>