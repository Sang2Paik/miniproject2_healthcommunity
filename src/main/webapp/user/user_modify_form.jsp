<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<!-- 20240304 최시환 추가 -->
<%@ include file="../header.jsp" %>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- Bootstrap 3.x -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- Daum 주소검색 API  -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style type="text/css">
  #box{
     width:600px;
     margin: auto;
     margin-top: 20px;
  }
  
</style>

<script type="text/javascript">

  
  
  const regular_email = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
  
  function send(f){
	  
	  //폼에서 입력된값 체크...
	  let user_name 		= f.user_name.value.trim();
	  let user_pwd  		= f.user_pwd.value.trim();
	  let user_age			= f.user_age.value.trim();
	  let user_email		= f.user_email.value.trim();
	  let user_height		= f.user_height.value.trim();
	  let user_kg 			= f.user_kg.value.trim();
	  let user_target 		= f.user_target.value.trim();
	  
	  if(user_name==''){
		  alert('이름을 입력하세요!');
		  f.user_name.value='';
		  f.user_name.focus();
		  return;
	  }
	  
	  if(user_pwd==''){
		  alert('비밀번호를 입력하세요!');
		  f.user_pwd.value='';
		  f.user_pwd.focus();
		  return;
	  }
	  
	  if(user_age==''){
		  alert('나이를 입력하세요!');
		  f.user_age.value='';
		  f.user_age.focus();
		  return;
	  }
	  
	  if(regular_email.test(user_email)==false){
		  
		  alert('이메일 형식이 틀립니다\n옳바른 형식으로 입력하세요!');
		  f.user_email.value='';
		  f.user_email.focus();
		  return;
	  }
	  
	  f.action = "modify.do";//UserberModifyAction
	  f.submit();//전송
  }
  
  //jQuery초기화 
  $(document).ready(function(){
	  
	  //document.getElementById("user_grade").value="${vo.user_grade}";
	  $("#user_grade").val("${vo.user_grade}");
	  
	  
  });
  
  

</script>



</head>
<body>
	<form class="form-inline">
	    <input type="hidden"  name="user_idx"  value="${ vo.user_idx }">
		<div id="box">
			<div class="panel panel-default">
				<div class="f20 text-center" style="margin-top: 15px;">회원수정</div>
				<div class="panel-body">
				   <table class="table">
		              <tr>
		                 <th class="f16 text-left"><font color="red">*</font>이름</th>
		                 <td><input class="form-control" name="user_name" value="${ vo.user_name }"></td>
		              </tr>		   
		              <tr>
		                 <th class="f16 text-left"><font color="red">*</font>아이디</th>
		                 <td>
		                    <input class="form-control" name="user_id"  readonly="readonly" value="${ vo.user_id }">
		                 </td>
		              </tr>		
		              <tr>
		                 <th class="f16 text-left"><font color="red">*</font>비밀번호</th>
		                 <td><input class="form-control" name="user_pwd" value="${ vo.user_pwd }"></td>
		              </tr>
		               <tr>
		                 <th class="f16 text-left"><font color="red">*</font>나이</th>
		                 <td><input class="form-control" name="user_age"  value="${ vo.user_age }"></td>
		              </tr>
		              <tr>
		                 <th class="f16 text-left"><font color="red">*</font>이메일</th>
		                 <td><input class="form-control"  name="user_email" value="${ vo.user_email }"></td>
		              </tr>
		              <tr>
		                 <th class="f16 text-left"><font color="red">*</font>성별</th>
		                 <td>
		                 	<c:if test="${ vo.user_gender eq 'man'}">
			                 	<input type="radio" name="user_gender" 
			                 				value="man" checked="checked">남자&nbsp;&nbsp;&nbsp;
			                 	<input type="radio" name="user_gender" 
			                 				value="woman">여자
		                 	</c:if>
		                 	<c:if test="${ vo.user_gender eq 'woman'}">
			                 	<input type="radio" name="user_gender" 
			                 				value="man">남자&nbsp;&nbsp;&nbsp;
			                 	<input type="radio" name="user_gender" 
			                 				value="woman" checked="checked">여자
		                 	</c:if>
		                 </td>
		              </tr>	   
		              <tr>
		                 <th class="f16 text-left">키</th>
		                 <td><input class="form-control"  name="user_height" value="${ vo.user_height }"></td>
		              </tr>		
		              <tr>
		                 <th class="f16 text-left">몸무게</th>
		                 <td><input class="form-control"  name="user_kg" value="${ vo.user_kg }"></td>
		              </tr>
		              <tr>
		                 <th class="f16 text-left">목표몸무게</th>
		                 <td><input class="form-control"  name="user_target" value="${ vo.user_target }"></td>
		              </tr>
		              
		              <tr>
		                 <th class="f16 text-left">등급</th>
		                 <td>
		                     <input class="form-control" type="text" name="user_grade" value="${ fn:substring(vo.user_grade, 5, fn:length(vo.user_grade)) }" readonly="readonly">
		                 </td>
		              </tr>		
		              
		              <tr>
		                  <td colspan="2" align="center">
		                        <input class="btn btn-gradient blue" type="button"  value="회원수정"
		                                onclick="send(this.form);">
		                        <input class="btn btn-gradient green" type="button"  value="목록보기"
		                                onclick="location.href='${ pageContext.request.contextPath }/user/mypage_main.do'">  
		                  </td>
		              </tr>
		              
		              
				   </table>
				</div>
			</div>
		</div>
	</form>	
</body>
</html>