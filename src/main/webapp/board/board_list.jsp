<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>

<!-- 20240302 백상희 추가 -->
<%@ include file="../header.jsp" %>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/css/board/board_list.css">
<!-- Bootstrap 3.x -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
#box {
	width: 100%;
	margin: auto;
	margin-top: 20px;
}

#title {
	text-align: center;
	font-size: 28px;
	font-weight: bold;
	color: #3366ff;
	text-shadow: 1px 1px 2px black;
}

#gird {
	padding 0;
	margin: 0;
}
#pageMenu{
	text-align: center;
}
.row{
	text-align: center;
}
</style>


<script type="text/javascript">
	function insert_form() {

		//로그인이 안된 경우
		if ("${ empty user }" == "true") {

			if (confirm("글쓰기는 로그인후에 가능합니다\n로그인 하시겠습니까?") == false)
				return;

			location.href = "../user/login_form.do";

			return;
		}

		//글쓰기 폼으로 이동
		location.href = "insert_form.do"; //  /board/insert_form.do

	}//end:insert_form()

	function find() {

		let search = $("#search").val();
		let search_text = $("#search_text").val().trim();

		//전체검색이 아닌데 검색어가 비어있으면
		if (search != 'all' && search_text == '') {
			alert('검색어를 입력하세요!!');
			$("#search_text").val("");
			$("#search_text").focus();
			return;
		}

		location.href = "list.do?search=" + search + "&search_text="
				+ encodeURIComponent(search_text, "utf-8");

	}
</script>


<!-- 초기화 -->
<script type="text/javascript">
	$(document).ready(function() {

		if ("${ not empty param.search }" == "true") {

			$("#search").val("${ param.search }");
		}

		//전체보기면 검색어 지워라
		if ("${ param.search eq 'all' }" == "true") {

			$("#search_text").val("");
		}

	});
</script>

<script>
	// 카테고리메뉴에 전체보기 클릭시
	function board_list(){
		location.href='board_home.do';
	}

	// 이미지 URL을 클릭한 경우, 해당 URL로 이동합니다.
	function image_view(b_idx) {
		location.href='board_view.do?b_idx=' + b_idx;
	}
	
	// 카테고리 클릭시 해당 카테고리만 포함한 리스트 가져오기
	function board_category_search(c_idx){
		location.href='board_category_search.do?c_idx=' + c_idx;
	}
	
</script>

</head>
<body>
	<div id="box">
		
		<div class="row" id="gird">
			<div class="col-sm-1" style="margin-bottom: 5px; width: 5%">
					<input class="btn btn-primary" type="button" value="글쓰기"
						onclick="insert_form();">
			</div>
			
			
			<!-- 검색 및  Page Menu  -->
			<form class="form-inline">
				
				<div class="col-sm-9" id="gird" style="width: 75%; min-width: 10%;">
					<select id="search" class="form-control">
						<option value="all">전체보기</option>
						<option value="name">이름</option>
						<option value="subject">제목</option>
						<option value="content">내용</option>
						<option value="subject_content">제목+내용</option>
					</select> 
					<input id="search_text" class="form-control" value="${ param.search_text }" style="width: 80%;">
					<input type="button" value="검색" class="btn btn-primary" class="search_btn" onclick="find();" style="width: auto;">
				</div>

			</form>
	
			<div class="col-sm-2" id="gird" style="width: 20%;">
				<div class="form-inline">
	
					<!-- 로그인 된경우 -->
					<!-- 20240303 최시환 로그아웃 경로 수정 -->
					<c:if test="${ not empty user }">
						<span class="user_name"><b>${ user.user_name }</b></span><span class="welcome_tag">님 환영합니다</span>
	         			<input class="btn btn-primary" type="button" value="로그아웃"
								onclick="location.href='${ pageContext.request.contextPath }/logout.do'">
					</c:if>
				</div>
			</div>
		</div> <!-- end : grid -->
		
		<br>
		
		<!-- 태그검색 -->
		<div align="center">
			<c:forEach var="category" items="${ category_list }">
				<span id="category_span">
					<input id="category_list" type="button" value="#${ category.c_name }" onclick="board_category_search(${category.c_idx});" >
				</span>
			</c:forEach>
			<span>
				<input id="category_all" type="button" value="#전체보기" onclick="board_list();">
			</span>
			<!-- category가 비어있는 경우 -->
				<c:if test="${ empty category_list }">
						<font color="red">등록된 카테고리가 없습니다</font>
				</c:if>
		</div>
		<br>
		
		<div>
			<!-- board_list가 존재할 때만 실행해라 -->
			<c:if test="${ not empty list }">
			<!-- 이미지 출력 -->
				<!-- for(BoardVo board_vo : list)  -->
				<c:forEach var="board_vo" items="${ list }">
					<c:if test="${ board_vo.b_open eq 'Y' }">
					
					   <img src="${ pageContext.request.contextPath }/upload/${ board_vo.b_photo }" onclick="image_view('${board_vo.b_idx}');" 
					   		class="image-hover" id="board_image">
					   		  
					</c:if>
				</c:forEach>
				
			</c:if>
			
			<!-- board_c_name_list가 존재할 때만 실행해라(카테고리 검색했을 시 실행) -->
			<c:if test="${ not empty board_c_name_list }">
				<!-- for(BoardVo board_vo : board_c_name_list)  -->
				<c:forEach var="board_vo" items="${ board_c_name_list }">
					<c:if test="${ board_vo.b_open eq 'Y' }">
					
						<img src="${ pageContext.request.contextPath }/upload/${ board_vo.b_photo }" onclick="image_view('${board_vo.b_idx}');" 
					   		class="image-hover" id="board_image">
						
					</c:if>
				</c:forEach>
			</c:if>
			
			<!-- 보드list에서 두 경우 모두 게시물이 없는 경우 -->
			<c:if test="${ empty list } and ${ empty board_c_name_list }">
					<font color="red">등록된 게시글이 없습니다</font>
			</c:if>

		</div>
				
	</div>

		
		<%-- <div id="pageMenu">1231
			<!-- Page Menu -->
			${ pageMenu }
		</div> --%>
</body>
</html>
