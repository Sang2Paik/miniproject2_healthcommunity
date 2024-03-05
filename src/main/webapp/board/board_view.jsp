<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<!-- 20240303 최시환 추가 -->
<%@ include file="../header.jsp" %>
<meta charset="UTF-8">
<title>게시글 상세보기</title>

<style type="text/css">

	#box{	
		margin-top: 20px;
	}
	
	table {
		margin: 20px;
		width: 80%;
		height: auto;
	}
	
	td {
		width: 50%;
	}
	

	#subject{
		padding: 3px;
		margin-bottom: 7px; 
		font-size: 30px;
	}
	
	#content{
		min-height: 100px;
		padding: 3px;
		margin-bottom: 7px; 
	}

	
	#disp {
	    text-align: left; /* 내용을 왼쪽 정렬합니다. */
	    margin: 0 auto; /* 좌우 여백을 자동으로 설정하여 가운데 정렬을 해제합니다. */
	}
	/* 2020304 최시환 추가 */
	#user_name,#subject,#content,#regdate{
		text-align: left;
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
	
	
	$(document).ready(function(){
		comment_list(1);
	});
	
 	function comment_list(p) {
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
		}); 
 	}//	} // end : comment_list()
	
	
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
		
		//Ajax로 전송
		$.ajax({
			url		:	"comment_insert.do",
			data	:	{
							"b_idx" 		: "${ vo.b_idx }",
				       		"cmt_content"	: cmt_content
			            },
			dataType :	"json",
			success	 :	function(res_data){
				// res_data = { "result" : true } or { "result" : false }
				if(res_data.result){
					//성공시
					comment_list(1); //1페이지를 보여준다
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
		});
		
		
		
		
	} // comment_insert();
	
</script>

</head>
<body>

	<div id="box">
		<div class="row">		
			
			<!-- 글 주인 또는 관리자만 사용 가능하도록 활성화 -->
			<div class="col-md-6" style="text-align: left;">
			<c:if
				test="${ ( vo.user_idx eq user.user_idx ) or ( user.user_grade eq '관리자' ) }">
				<input class="nav_btn" type="button" value="수정"
					onclick="modify_board(${ vo.b_idx })">
				<input class="nav_btn" type="button" value="삭제"
					onclick="delete_board(${ vo.b_idx })">
			</c:if>
			<input class="nav_btn" type="button" value="목록보기"
				onclick="location.href='list.do?page=${ param.page }&search=${ param.search }&search_text=${ param.search_text }&c_idx=${ c_idx }'">
			</div>
			
			<div class="col-md-6" style="text-align: right;">
		        <!-- 로그인된 경우에만 표시되도록 조건문을 적용합니다. -->
		        <c:if test="${not empty user}">
		            <div class="f12 user_name">
		                <b>&nbsp;${user.user_name}&nbsp;님</b> 환영합니다.&nbsp;
		                <input class="nav_btn" type="button" value="로그아웃" onclick="location.href='${pageContext.request.contextPath}/logout.do'">
		            </div>
		        </c:if>
		    </div>
		</div>

		<table class="table">
			<tr>
				<td style="vertical-align: top;">
					<div id="b_photo"><img src="../upload/${ vo.b_photo }" style="width: 100%;"></div>
				</td>
				<td>
					<div class="panel panel-info">
						<div id="user_name" class="panel-heading">
							<b>${ vo.user_id }</b>
						</div>
						<div class="panel-body">

							<div id="subject">
								<b>${ vo.b_subject }</b>
							</div>
							<div id="content">${ vo.b_content }</div>
					
							<div align="right">
								<!-- 로그인 상태일때만 좋아요버튼을 누를 수 있도록 작성 -->
								<c:if test="${ not empty user }">
									<img alt="Like" src="${pageContext.request.contextPath}/img/thumbs-up.png" style="width: 30px;"><span class="f12">${ vo.b_like }</span>
									<img alt="Like_button" src="${pageContext.request.contextPath}/img/like_button.png" onclick="like_board(${ vo.b_idx })" style="width: 40px;">		
								</c:if>
								
							</div>

						</div>
					</div>
					
					<!-- 댓글등록폼 -->
					<h4 align="left">댓글</h4>

					<div class="row" style="margin-bottom: 5px;">
						<form class="form-inline">
							<input class="form-control" id="cmt_content"
								placeholder="로그인 후에 댓글 작성 가능합니다"
								style="display: inline-block; width: 75%; height: 60px;">
							<input class="form-control btn btn-gradient cyan mini" id="cmt_btn_register" type="button"
								value="댓글추가" onclick="comment_insert();"
								style="display: inline-block; width: 20%; height: 60px;">
						</form>
					</div>
					<div id="disp"></div>
				</td>
			</tr>
		</table>
		
		
	</div>
	
</body>
</html>