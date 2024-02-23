<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Bootsrap 3.x -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
	#box{
		width: 800px;
		margin: auto;
		margin-top: 20px;
	}
	
	#subject,#regdate{
		border: 1px solid #cccccc;
		box-shadow: 1px 1px 1px gray;
		padding: 3px;
		margin-bottom: 7px; 
	}
	
	#content{
		min-height: 100px;
		border: 1px solid #cccccc;
		box-shadow: 1px 1px 1px gray;
		padding: 3px;
		margin-bottom: 7px; 
	}
	
	textarea {
		resize: none;
		width: 100%;
	}
	
	#cmt_btn_register, #cmt_content{
		margin 0px;
		width: 100%;
		height: 80px;
	}
	
</style>

<script type="text/javascript">
	function like_board(b_idx) {
		
		location.href='board_like.do?b_idx='+ b_idx + '&page=${param.page}&search=${ param.search }&search_text=${ param.search_text }';
	}
	
	function delete_board(b_idx) {
		if(confirm("위 글을 삭제하시겠습니까?")==false)return;
		
		location.href='delete.do?b_idx='+ b_idx + '&page=${param.page}&search=${ param.search }&search_text=${ param.search_text }';
	}
	
	function modify_board(b_idx) {
		
		location.href='modify_form.do?b_idx='+ b_idx + '&page=${param.page}&search=${ param.search }&search_text=${ param.search_text }';
	}
	
</script>

<script type="text/javascript">

	var g_cmt_page=1;

	/* $(document).ready(function(){
		comment_list(1);
	}); */
	
/* 	function comment_list(p) {
		//Ajax로 댓글목록 요청
		$.ajax({
			url		:	"comment_list.do",
			data	:	{ "b_idx" : "${ vo.b_idx }", "page" : p },
			success	:	function(res_data){
				
				$("#disp").html(res_data);
			},
			error	:	function(err) {
				
				alert(err.responseText);
			}
		}); */
		
		
//	} // end : comment_list()
	
	
	function comment_insert() {
		if("${ empty user }" == "true") {
			if(confirm("댓글은 로그인 후에 가능합니다\n로그인 하시겠습니까?")==false) return;
		
			location.href="../user/login_form.do?url=";
			return;
		}
	
		//내용입력 여부체크
		let cmt_content = $("#cmt_content").val().trim();
		if(cmt_content==''){
			alert('댓글 내용을 입력해주세요');
			$("#cmt_content").val('');
			$("#cmt_content").focus();
			return;
		}
	
		/* //Ajax로 전송
		$.ajax({
			url		:	"comment_insert.do",
			data	:	{
							"b_idx" 		: "${ vo.b_idx }",
				       		"cmt_content"	: cmt_content,
				       		"user_idx"		: "${ user.user_idx }",
				       		"user_id"		: "${ user.user_id }",
				       		"user_name"		: "${ user.user_name }"
			            },
			dataType :	"json",
			success	 :	function(res_data){
				// res_data = { "result" : true } or { "result" : false }
				if(res_data.result){
					//성공시
					comment_list(1);
				}else{
					//실패시
					alert("댓글쓰기에 실패했습니다")
				}
				
				// 이전댓글내용 지우기
				$("#cmt_content").val('');
			},
			error	 : function(err) {
				alert(err.responseText);
			}
		}); */
		
		
		
		
	}
	
</script>

</head>
<body>

	<div id="box">
		<div class="panel panel-primary">
			<div class="panel-heading"><b>${ vo.user_name }</b>님의 글:</div>
			<div class="panel-body">
			
				<div id="subject"><b>제목 : ${ vo.b_subject }</b></div>
				<div id="content">${ vo.b_content }</div>
				<div><img src="../upload/${ vo.b_photo }"></div>
				
				<div id="regdate"><b>작성일자 : ${ vo.b_regdate }</b></div>
				
				<div>
					
					<!-- 로그인 상태일때만 좋아요버튼을 누를 수 있도록 작성 -->
					<c:if test="${ not empty user }">
						<input class="btn btn-success"	type="button" value="좋아요" 
								onclick="like_board(${ vo.b_idx })">${ vo.b_like }				
					</c:if>
				
					
					<!-- 글 주인 또는 관리자만 사용 가능하도록 활성화 -->
					<c:if test="${ ( vo.user_idx eq user.user_idx ) or ( user.user_grade eq '관리자' ) }">
						<input class="btn btn-info" 	type="button" value="수정하기" onclick="modify_board(${ vo.b_idx })">
						<input class="btn btn-danger"	type="button" value="삭제하기" onclick="delete_board(${ vo.b_idx })">
					</c:if>
					<input class="btn btn-primary"	type="button" value="목록보기"
							onclick="location.href='list.do?page=${ param.page }&search=${ param.search }&search_text=${ param.search_text }'">
				</div>
				
			</div>
		</div>
		
		<hr>
		
		<!-- 댓글등록폼 -->
		<div class="row" style="margin: 0; padding: 0;">
			<form>
				<div class="col-sm-10"  style="margin: 0; padding: 0;" >
					<textarea class="form-control" id="cmt_content" style="margin: 0; padding: 0;" placeholder="로그인후에 댓글작성 가능합니다"></textarea>
				</div>
				<div class="col-sm-2" style="margin: 0px;">
					<input class="btn btn-info" id="cmt_btn_register" type="button" value="댓글쓰기" style="margin: 0; padding: 0;"
							onclick="comment_insert();">
				</div>
			</form>
		</div>
		<!-- 댓글목록 출력 -->
		<div id="disp"></div>
		
		
		
	</div>
	
</body>
</html>