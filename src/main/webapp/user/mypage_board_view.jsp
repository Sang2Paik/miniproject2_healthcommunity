<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../header.jsp" %>

<!-- Bootstrap 3.x -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>


<style type="text/css">
	#box{
		width: 800px;
		margin: auto;
		margin-top: 20px;
	}
	.panel-heading{
		text-overflow: ellipsis;
    	overflow: hidden;
    	white-space: nowrap;
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
		width: 100%;
		resize: none;
	}
	
	#cmt_btn_register, #cmt_content{
		margin 0px;
		width: 100%;
		height: 80px;
	}
	/* 20230303 최시환 추가 */
	#my_img{
		width: 200px;
		height: 200px;
	}
	
</style>


<script type="text/javascript">

function send(f){
	  let b_idx		= f.b_idx.value;
	  let b_subject = f.b_subject.value.trim();
	  let b_content = f.b_content.value.trim();
	  let b_open	= f.b_open.value;
	  
	  if(confirm('위 상태로 변경하시겠습니까?') == false) return;
	  
	  
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
	  
	  f.action = "mypage_modify.do";
	  f.submit();
	  
}

// 이미지수정 버튼이 클릭되면 파일 찾기 창을 띄운다.
function ajaxFileUpload() {
    $("#ajaxFile").click();
}

function photo_upload() {
		
		//파일선택->취소시
		if( $("#ajaxFile")[0].files[0]==undefined) return;
		
		
		var form = $("ajaxForm")[0];
	    var formData = new FormData(form);
	    formData.append("b_idx", '${ vo.b_idx }');
	    formData.append("b_photo", $("#ajaxFile")[0].files[0]);
		
	    $.ajax({
	             url : "photo_upload.do",
	             type : "POST",
	             data : formData,
	             processData : false,
	             contentType : false,
	             dataType : 'json',
	             success:function(result_data) {
	            	 //result_data = {"p_filename":"aaa.jpb"}
	            	 $("#my_img").attr("src","../upload/" + result_data.p_filename);
	             },
	             error : function(err){
	            	 alert(err.responseText);
	             }
	       });
	 }


</script>
</head>

<body>

	<!-- 파일수정용폼  -->
	<!--화일업로드용 폼  -->
	<form enctype="multipart/form-data" id="ajaxForm" method="post">
	    <input id="ajaxFile" type="file" style="display:none;" onChange="photo_upload();" >
	</form>
	
	<!-- 내용수정용 폼 -->
	<form class="form-inline">
	    <input type="hidden"  name="b_idx"  value="${ vo.b_idx }">
	    <input type="hidden"  name="page"   value="${ param.page }">
	    <input type="hidden"  name="search"		 value="${ param.search }">
	    <input type="hidden"  name="search_text" value="${ param.search_text }">
	    
		<div id="box">
			<div class="panel panel-info">
				<div class="panel-heading"><h4><b>${ user.user_name } 님의 글 : ${ vo.b_subject }</b></h4></div>
				<div class="panel-body">
				   <table class="table">
				       <tr>
				          <th>제목</th>
				          <td>
				              <input class="form-control" name="b_subject"  style="width: 100%;" 
				                     value="${ vo.b_subject }">
				          </td>
				       </tr>
				       <tr>
				          <th>내용</th>
				          <td>
				              <textarea class="form-control" rows="5" name="b_content" style="width:100%; resize:none;">${ vo.b_content }</textarea>
				          </td>
				       </tr>
				       <tr>
				          <th>작성(수정)일</th>
				          <td>
				             ${ fn:substring(vo.b_regdate,0,16) } 작성 (${ fn:substring(vo.b_modify_date,0,16) } 수정)
				          </td>
				       </tr>
				       <tr>
				          <th>이미지</th>
				          <td>
				          	  <img id="my_img" src="../upload/${ vo.b_photo }">
				          	  <br>
				              <input class="btn btn-gradient yellow mini" type="button" name="b_photo" value="이미지수정" onclick="ajaxFileUpload();">
				          </td>
				       </tr>
				       <tr>
				       	  <th>공개여부</th>
				       	  
				       	  <!-- 공개여부 Y라면 체크된 상태로 보여주기 -->
				       	  <c:if test="${ vo.b_open eq 'Y' }">
					          <td>
						          <input type="radio" class="form-check-input"  name="b_open" 
				                 			value="Y" checked="checked">공개&nbsp;&nbsp;&nbsp;
				                  <input type="radio" class="form-check-input"  name="b_open" 
				                 			value="N">비공개
			                  </td>
		                   </c:if>
		                   <!-- 공개여부 Y라면 체크된 상태로 보여주기 -->
				       	  <c:if test="${ vo.b_open eq 'N' }">
					           <td>
						          <input type="radio" class="form-check-input"  name="b_open" 
				                 			value="Y" >공개&nbsp;&nbsp;&nbsp;
				                   <input type="radio" class="form-check-input"  name="b_open" 
				                 			value="N" checked="checked">비공개
			                 	</td>
			              </c:if>
				       </tr>
				       
				       <tr>
				          <td colspan="2" align="center">
				              <input type="button" class="btn btn-gradient cyan mini"  value="수정하기"
				                     onclick="send(this.form);">
				              <input type="button" class="btn btn-gradient cyan mini"  value="돌아가기"
				                     onclick="location.href='mypage_main.do'">
				          </td>
				       </tr>
				   </table> 
				</div>
			</div>
		</div>
	</form>
	
</body>
</html>
