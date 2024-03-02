<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>핼커 로그인</title>


	<%@ include file="/header.jsp" %>


<style type="text/css">
 
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


<section class="vh-100 gradient-custom">
<form><!-- 20240302 백상희 form tag 추가 -->
  <div class="container py-5 h-100">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-12 col-md-8 col-lg-6 col-xl-5">
        <div class="card main_bg text-white" style="border-radius: 1rem;">
          <div class="card-body p-5 text-center">

            <div class="mb-md-5 mt-md-4 pb-5">
			<input type="hidden" name="url" value="${ param.url }">
              <h2 class="fw-bold mb-2 text-uppercase"><img src="${ pageContext.request.contextPath }/img/login_title.png"><br></h2>

              <div class="form-outline form-white mb-4">
                <input class="form-control form-control-lg" name="user_id" value="${ param.user_id }" placeholder="ID 입력하세요"/>
              </div>

              <div class="form-outline form-white mb-4">
                <input class="form-control form-control-lg"  type="password" name="user_pwd" placeholder="PASSWORD 입력하세요"/>
              </div>

				<input class="btn btn-outline-light btn-lg px-5" type="button"  value="로그인" onclick="send(this.form);">
              


            </div>

            <div>
              <p class="mb-0">
              <a href="#!" class="text-white-50 fw-bold"  onclick="location.href='insert_form.do'">회원가입</a> |  
              <a href="#!" class="text-white-50 fw-bold" onclick="location.href='${ pageContext.request.contextPath }/main.do'">메인화면</a></p>
              
            </div>

          </div>
        </div>
      </div>
    </div>
  </div>
</form>
</section>





</body>
</html>
