<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>헬커 회원가입</title>


	<%@ include file="/header.jsp" %>

<!-- Daum 주소검색 API  -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style type="text/css">

  
</style>

<script type="text/javascript">

  $(document).ready(function(){
	  
	  //ID입력창에서 키가눌렸다 떼어지면
	  $("#user_id").keyup(function(event){
		  
		  //가입버튼기능 disabled
		  $("#btn_register").attr("disabled", true);
		  
		  let user_id = $(this).val();
		  //console.log(user_id);
		  if(user_id.length<3){
			  $("#id_msg").html("아이디는 3자리 이상입력하세요").css("color","red");
			  return;
		  }
		  
		  //Ajax이용해서 중복아이디 체크
		  $.ajax({
			  url		:	"check_id.do",      //userberCheckIdAction
			  data		:	{"user_id": user_id}, //parameter  -> check_id.do?user_id=one
			  dataType	:	"json",           //결과값의 Data Type
			  success	:	function(res_data){
				  // res_data = {"result": true}  or {"result": false}
				  if(res_data.result){
					  //사용가능한 아이디
					  $("#id_msg").html("사용가능한 아이디입니다").css("color","blue");
					  
					  //가입버튼 활성화
					  $("#btn_register").attr("disabled", false);
				  }else{
					  //이미사용중인 아이디
					  $("#id_msg").html("이미 사용중인 아이디입니다").css("color","red");
				  }
			  },
			  error		:	function(err){
				  
				  alert(err.responseText);
			  }
			  
		  });
		  
	  });//end: keyup
	  
  });//end: $(document).ready()
  

  
  
  const regular_email = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
  
  function send(f){
	  
	  //폼에서 입력된값 체크...
	  let user_name 		= f.user_name.value.trim();
	  let user_pwd  		= f.user_pwd.value.trim();
	  let user_age			= f.user_age.value.trim();
	  let user_email		= f.user_email.value.trim();
	  let user_height		= f.user_height.value.trim();
	  let user_kg 			= f.user_kg.value.trim();
	  let user_target		= f.user_target.value.trim();
	  
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
		  f.user_cellphone.value='';
		  f.user_cellphone.focus();
		  return;
	  }
	  
	  if(regular_email.test(user_email)==false){
		  
		  alert('이메일 형식이 틀립니다\n옳바른 형식으로 입력하세요!');
		  f.user_email.value='';
		  f.user_email.focus();
		  return;
	  }
	  
	  
	  f.action = "insert.do";//userberInsertAction
	  f.submit();//전송
	  
  }
  
  

</script>



</head>
<body>



<form class="form-inline">

<section class="vh-100 gradient-custom">
  <div class="container py-5 h-100">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-12 col-md-8 col-lg-6 col-xl-5">
        <div class="card main_bg text-white" style="border-radius: 1rem;">
          <div class="card-body p-5 text-center">

            <div class="mb-md-5 mt-md-4 pb-5">
			
              <h2 class="fw-bold mb-2 text-uppercase"><img src="${ pageContext.request.contextPath }/img/login_title.png"><br>회원가입</h2>

              <div class="form-outline form-white mb-4">
                <input class="form-control form-control-lg" name="user_name" value="${ param.user_name }" placeholder="이름"/>
              </div>
              
              <div class="form-outline form-white mb-4">
                <input class="form-control form-control-lg" name="user_id" value="${ param.user_id }" placeholder="ID"/><span id="id_msg"></span>
              </div>

              <div class="form-outline form-white mb-4">
                <input class="form-control form-control-lg"  type="password" name="user_pwd" placeholder="PASSWORD"/>
              </div>
              
              <div class="form-outline form-white mb-4">
                <input class="form-control form-control-lg"  name="user_age" placeholder="현재나이"/>
              </div>
              
              
              <div class="form-outline form-white mb-4">
                <input class="form-control form-control-lg"  name="user_email" placeholder="이메일"/>
              </div>
              
              
              <div class="form-outline form-white mb-4">
                <!-- <input type="radio" class="form-control form-control-lg"  name="user_gender" placeholder="성별"/> -->
                성별 : 
                <input type="radio" class="form-check-input"  name="user_gender" 
		                 				value="man" checked="checked">남자 | 
		                 	<input type="radio" class="form-check-input"  name="user_gender" 
		                 				value="woman">여자
              </div>
              
              <!-- 20240302 백상희 : placeholder에 단위 추가 -->
              <div class="form-outline form-white mb-4">
                <input class="form-control form-control-lg"  name="user_height" placeholder="키(cm)"/>
              </div>
              
              <!-- 20240302 백상희 : placeholder에 단위 추가 -->
              <div class="form-outline form-white mb-4">
                <input class="form-control form-control-lg"  name="user_kg" placeholder="체중(kg)"/>
              </div>
              
              <!-- 20240302 백상희 : placeholder에 단위 추가 -->
              <div class="form-outline form-white mb-4">
                <input class="form-control form-control-lg"  name="user_target" placeholder="목표체중(kg)"/>
              </div>

              
              <div class="form-outline form-white mb-4">
	                등급 : 
	                
	                <!-- 20240302 백상희 name="user_grade" 수정 -->
	                <input type="radio" class="form-check-input"  name="user_grade" 
			                 				value="user_user" checked="checked" onclick="return false;">일반
			        <input type="radio" class="form-check-input"  name="user_grade" 
			                 				value="user_admin" onclick="return false;">관리자
              </div>
              
              

				<input class="btn btn-outline-light btn-lg px-5" type="button"  value="회원가입" onclick="send(this.form);">
              


            </div>

            <div>
              <p class="mb-0">
              <!-- <a href="#!" class="text-white-50 fw-bold" onclick="send(this.form);">회원가입</a> | -->  
              <a href="#!" class="text-white-50 fw-bold" onclick="location.href='${ pageContext.request.contextPath }/main.do'">메인화면</a></p>
              
            </div>

          </div>
        </div>
      </div>
    </div>
  </div>
</section>


</form>







<%-- 

	<form class="form-inline">
		<div id="box">
			<div class="panel panel-primary">
				<div class="panel-heading"><h4>::::회원가입::::</h4></div>
				<div class="panel-body">
				   <table class="table">
		              <tr>
		                 <th><label><font color="red">*</font>이름</label></th>
		                 <td><input class="form-control"  name="user_name"></td>
		              </tr>		   
		              <tr>
		                 <th><label><font color="red">*</font>아이디</label></th>
		                 <td>
		                    <input class="form-control" name="user_id"  id="user_id">
		                    <span id="id_msg"></span>
		                 </td>
		              </tr>		
		              <tr>
		                 <th><label><font color="red">*</font>비밀번호</label></th>
		                 <td><input class="form-control"  type="password" name="user_pwd"></td>
		              </tr>
		              <tr>
		                 <th><label><font color="red">*</font>나이</label></th>
		                 <td><input class="form-control" name="user_age"></td>
		              </tr>
		              <tr>
		                 <th><label><font color="red">*</font>이메일</label></th>
		                 <td><input class="form-control"  name="user_email"></td>
		              </tr>		
		              <tr>
		                 <th><label><font color="red">*</font>성별</label></th>
		                 <td>
		                 	<input type="radio" class="form-control"  name="user_gender" 
		                 				value="man" checked="checked">남자&nbsp;&nbsp;&nbsp;
		                 	<input type="radio" class="form-control"  name="user_gender" 
		                 				value="woman">여자
		                 </td>
		              </tr>	
		              <tr>
		                 <th><label>키</label></th>
		                 <td><input class="form-control"  name="user_height"></td>
		              </tr>		
		              <tr>
		                 <th><label>몸무게</label></th>
		                 <td><input class="form-control"  name="user_kg"></td>
		              </tr>
		              <tr>
		                 <th><label>목표몸무게</label></th>
		                 <td><input class="form-control"  name="user_target"></td>
		              </tr>
		              <tr>
		                 <th><label>등급</label></th>
		                 <td>
		                 	<input type="radio" class="form-control"  name="user_grade" 
		                 				value="user_user" checked="checked">일반&nbsp;&nbsp;&nbsp;
		                 	<input type="radio" class="form-control"  name="user_grade" 
		                 								value="user_admin">관리자
		                 </td>
		              </tr>	
		              <tr>
		                  <td colspan="2" align="center">
		                          
		                        <input  id="btn_register" class="btn  btn-primary" type="button"  value="회원가입"  disabled="disabled"
		                                onclick="send(this.form);">  
		                        <input  class="btn  btn-success" type="button"  value="메인화면"
		                                onclick="location.href='${ pageContext.request.contextPath }/main.do'">  
		                  
		                  </td>
		              </tr>
		              
		              
				   </table>
				</div>
			</div>
		</div>
	</form>	 --%>
</body>
</html>
