<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Bootstrap 3.x -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
  #box{
     width: 600px;
     margin: auto;
     margin-top: 50px;
  }
  
  textarea {
	 width: 100% !important;
	 resize: none;
  }

</style>

<script type="text/javascript">
  
  function send(f){
	  
	  let b_subject = f.b_subject.value.trim();
	  let b_content = f.b_content.value.trim();
	  
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
	  
	  f.action = "modify.do"; //  /board/modify.do  -> BoardController
	  f.submit();
	    
  }

</script>


</head>
<body>
<form class="form-inline">
    <input type="hidden"  name="b_idx"  value="${ vo.b_idx }">
    <input type="hidden"  name="page"   value="${ param.page }">
    <input type="hidden"  name="search"		 value="${ param.search }">
    <input type="hidden"  name="search_text" value="${ param.search_text }">
    
	<div id="box">
		<div class="panel panel-primary">
			<div class="panel-heading"><h4>수정하기</h4></div>
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
			              <textarea class="form-control" rows="5" name="b_content">${ vo.b_content }</textarea>
			          </td>
			       </tr>
			       
			       <tr>
			          <td colspan="2" align="center">
			              <input type="button" class="btn btn-primary"  value="수정하기" 
			                     onclick="send(this.form);">
			              <input type="button" class="btn btn-success"  value="목록보기" 
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