<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<%@ include file="../header.jsp" %>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- Bootsrap 3.x -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<style type="text/css">
	#box{
		width: 600px;
		margin: auto;
		margin-top: 50px;
	}
	
	textarea{
		width: 100% !important;
		resize: none;
	}
</style>

<script type="text/javascript">
	function send(f) {
		let b_subject = f.b_subject.value.trim();
		let b_content = f.b_content.value.trim();
		let b_photo	  = f.b_photo.value;
		let c_name	  = f.c_name.value;
		let b_open	  = f.b_open.value;
		
		//비어있으면
		if(b_subject==''){
			alert('제목을 입력하세요!');
			f.b_subject.value='';
			f.b_subject.focus();
			return;
		}
		
		if(b_content==''){
			alert('내용을 입력하세요!');
			f.b_content.value='';
			f.b_content.focus();
			return;
		}
		
		f.action="insert.do";
		f.submit();
	}
</script>

</head>
<body>
	<form class="form-inline"  method="POST" enctype="multipart/form-data">
		<div id="box">
			<div class="panel panel-success">
				<div class="panel-heading"><h4 class="f20">새글쓰기</h4></div>
				<div class="panel-body">
					<table class="table">
						<tr>
							<th>제목</th>
							<td><input class="form-control" name="b_subject" style="width: 100%;"></td>
						</tr>
						<tr>
							<th>카테고리</th>
							<td>
								<select name="c_name" class="form-control">
									<c:forEach var="c_list" items="${ c_list }">
										<option value="${ c_list.c_name }">${ c_list.c_name }</option>
									</c:forEach>
								</select>
							 </td>
						</tr>
						<tr>
							<th>내용</th>
							<td><textarea class="form-control" rows="5" name="b_content"></textarea></td>
						</tr>
						<tr>
			            	<th>사진</th>
			         		<td><input type="file" class="form-control" name="b_photo"></td>
			       		</tr>
						<tr>
			            	<th>공개여부</th>
			         		<td>
			         			<input type="radio" name="b_open" value="Y">공개
			         			<input type="radio" name="b_open" checked="checked" value="N">비공개
			         		</td>
			       		</tr>
						<tr>
							<td colspan="2" align="center">
								<input type="button" class="btn btn-gradient blue" value="새글쓰기" 
										onclick="send(this.form);">
								<input type="button" class="btn btn-gradient green" value="목록보기" 
										onclick="location.href='list.do?page=${ param.page }&search=${ param.search }&search_text=${ param.search_text }'">
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</form>
</body>
</html>
