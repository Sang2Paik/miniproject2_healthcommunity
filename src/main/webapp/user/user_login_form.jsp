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
     width: 500px;
     margin: auto;
     margin-top: 100px;
  }
  
  input[value='로그인']{
     width: 220px;
  }
</style>

<script type="text/javascript">
   
   function send(f){
	     
	   //ID/PWD체크
	   let user_id  = f.user_id.value.trim();
	   let user_pwd = f.user_pwd.value.trim();
	   
	   if(user_id==''){
		   alert("아이디를 입력하세요!");
		   f.user_id.value='';
		   f.user_id.focus();
		   return;
	   }
	   
	   if(user_pwd==''){
		   alert("비밀번호를 입력하세요!");
		   f.user_pwd.value='';
		   f.user_pwd.focus();
		   return;
	   }
	  
	   
	   f.action="login.do"; // UserLoginAction
	   f.submit();
   }

</script>



<script type="text/javascript">
  
  //$(document).ready(function(){});
  
  window.onload=function(){
	  
	 //show_message();
	 
	 setTimeout(show_message,100);
	 
  };

  function show_message(){
	  // login_form.do?reason=fail_id	  
	  if("${ param.reason eq 'fail_id'}"=="true"){
		  alert("아이디가 틀렸습니다");
	  }
	  
	  // login_form.do?reason=fail_pwd  
	  if("${ param.reason eq 'fail_pwd'}"=="true"){
		  alert("비밀번호가 틀렸습니다");
	  }
	  
	  // login_form.do?reason=session_timeout
	  if("${ param.reason eq 'session_timeout'}"=="true"){
		  alert("로그아웃 상태입니다\n다시 로그인하세요");
	  }
  }
  
</script>



</head>
<body>
<form class="form-inline">
	<input type="hidden" name="url" value="${ param.url }">
	<div id="box">
		<div class="panel panel-primary">
			<div class="panel-heading"><h4>로그인</h4></div>
			<div class="panel-body">
			   <table class="table">
			      <tr>
			          <th>아이디</th>
			          <td>
			               <input style="width:65%;" class="form-control"  name="user_id" 
			                      value="${ param.user_id }">
			          </td>
			      </tr>
			      <tr>
			          <th>비밀번호</th>
			          <td><input style="width:65%;" class="form-control"  type="password" name="user_pwd"></td>
			      </tr>
			      
			      <tr>
			          <td colspan="2" align="center">
			              <input class="btn btn-primary" type="button"  value="로그인"
			                     onclick="send(this.form);">
			          </td>
			      </tr>
			      
			      <tr>
			          <td colspan="2" align="center">
			              <input class="btn btn-success" type="button"  value="메인화면"
			                     onclick="location.href='${ pageContext.request.contextPath }/user/list.do'">
			                     
			              <input class="btn btn-info"    type="button"  value="회원가입"
			                     onclick="location.href='insert_form.do'">
			          </td>
			      </tr>
			      
			   </table>
			</div>
		</div>
	</div>
</form>
	
</body>
</html>