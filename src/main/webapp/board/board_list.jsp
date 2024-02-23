<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Bootstrap 3.x -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
#box {
	width: 1000px;
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
</style>


<script type="text/javascript">
	function insert_form() {

		//로그인이 안된 경우
		if ("${ empty user }" == "true") {

			if (confirm("글쓰기는 로그인후에 가능합니다\n로그인 하시겠습니까?") == false)
				return;

			location.href = "../member/login_form.do";

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


</head>
<body>

	<div id="box">
		<h1 id="title">:::: 게시판 ::::</h1>

		<div class="row" style="margin-bottom: 5px;">
			<div class="col-sm-3">
				<input class="btn btn-primary" type="button" value="글쓰기"
					onclick="insert_form();">

			</div>
			<div class="col-sm-9" style="text-align: right;">
				<!-- 로그인 안된경우 -->
				<c:if test="${ empty user }">
					<input class="btn btn-primary" type="button" value="로그인"
						onclick="location.href='../member/login_form.do'">
				</c:if>

				<!-- 로그인 된경우 -->
				<c:if test="${ not empty user }">
					<b>${ user.mem_name }</b>님 환영합니다
         	<input class="btn btn-primary" type="button" value="로그아웃"
						onclick="location.href='../member/logout.do'">
				</c:if>

			</div>
		</div>

		<table class="table">
			<tr class="info">
				<th width="100">번호</th>
				<th width="400">제목</th>
				<th>작성자</th>
				<th>작성일자</th>
				<th>조회수</th>
			</tr>

			<!-- for(BoardVo vo : list)  -->
			<c:forEach var="vo" items="${ list }">
				<tr>
					<td>${ vo.no }</td>

					<!-- 제목 -->
					<td>
						<!-- 답글이면 들여쓰기 --> 
						<c:forEach begin="1" end="${ vo.b_depth }">
                  			&nbsp;&nbsp;&nbsp;
              			</c:forEach> 
              			<!-- 메인글이 아니면 ㄴ 붙이기 --> 
              			<c:if test="${ vo.b_step ne 0 }">┖</c:if>

						<!-- 사용중  --> 
						<c:if test="${ vo.b_use eq 'Y' }">
							<a href="view.do?b_idx=${ vo.b_idx }&page=${ empty param.page ? 1 : param.page }&search=${ param.search }&search_text=${ param.search_text }">${ vo.b_subject }</a>
							<c:if test="${ vo.cmt_count gt 0 }">
								<span class="badge" style="background: #ff3366;">${ vo.cmt_count }</span>
							</c:if>
							
						</c:if> <!-- 삭제게시물  --> <c:if test="${ vo.b_use eq 'N' }">
							<font color="red">삭제된 게시물(${ vo.b_subject })</font>
						</c:if>

					</td>

					<td>${ vo.mem_name }</td>
					<td>${ fn:substring(vo.b_regdate,0,16) }</td>
					<td>${ vo.b_readhit }</td>
				</tr>
			</c:forEach>


			<!-- 게시물이 없는 경우 -->
			<c:if test="${ empty list }">
				<tr>
					<td colspan="5" align="center"><font color="red">등록된게시글이 없습니다</font></td>
				</tr>
			</c:if>




			<!-- 검색 및  Page Menu  -->
			<tr>
				<td colspan="5" align="center"><br> <!-- 검색메뉴 -->
					<form class="form-inline">
						<select id="search" class="form-control">
							<option value="all">전체보기</option>
							<option value="name">이름</option>
							<option value="subject">제목</option>
							<option value="content">내용</option>
							<option value="subject_content">제목+내용</option>
						</select> <input id="search_text" class="form-control"
							value="${ param.search_text }"> <input type="button"
							value="검색" class="btn btn-primary" onclick="find();">

					</form> <!-- Page Menu --> ${ pageMenu } <!-- <ul class='pagination'>
				<li><a href='#'>◀</a></li>
				<li class='active'><a href='#'>1</a></li>
				<li><a href='list.do?page=2'>2</a></li>
				<li><a href='list.do?page=3'>3</a></li>
				<li><a href='list.do?page=4'>▶</a></li>
			</ul> --></td>
			</tr>

		</table>
	</div>

</body>
</html>