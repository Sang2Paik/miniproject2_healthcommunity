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
  
  
  function find_addr(){
	  
	  new daum.Postcode({
	        oncomplete: function(data) {
	            
	        	//data = {"zonecode":"13529", "address":"경기 성남시 분당구 판교역로 166","roadAddress":"",...}
	        	
	        	//주소창에서 선택된 주소값을 입력창에 넣어준다
	        	$("#user_zipcode").val(data.zonecode);
	        	$("#user_addr").val(data.roadAddress);
	        }
	  }).open();
	  
  }//end: find_addr()
  
  
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
	  
	  if(user_height==''){
		  alert('키를 입력하세요!');
		  f.user_height.value='';
		  f.user_height.focus();
		  return;
	  }
	  
	  if(user_kg==''){
		  alert('몸무게를 입력하세요!');
		  f.user_kg.value='';
		  f.user_kg.focus();
		  return;
	  }
	  if(user_target==''){
		  alert('목표 몸무게를 입력하세요!');
		  f.user_kg.value='';
		  f.user_kg.focus();
		  return;
	  }
	  
	  
	  f.action = "insert.do";//userberInsertAction
	  f.submit();//전송
	  
  }
  
  

</script>



</head>
<body>
	<form class="form-inline">
		<div id="box">
			<div class="panel panel-primary">
				<div class="panel-heading"><h4>::::회원가입::::</h4></div>
				<div class="panel-body">
				   <table class="table">
		              <tr>
		                 <th><label>이름</label></th>
		                 <td><input class="form-control"  name="user_name"></td>
		              </tr>		   
		              <tr>
		                 <th><label>아이디</label></th>
		                 <td>
		                    <input class="form-control" name="user_id"  id="user_id">
		                    <span id="id_msg"></span>
		                 </td>
		              </tr>		
		              <tr>
		                 <th><label>비밀번호</label></th>
		                 <td><input class="form-control"  type="password" name="user_pwd"></td>
		              </tr>
		              <tr>
		                 <th><label>나이</label></th>
		                 <td><input class="form-control" name="user_age"></td>
		              </tr>
		              <tr>
		                 <th><label>이메일</label></th>
		                 <td><input class="form-control"  name="user_email"></td>
		              </tr>		
		              <tr>
		                 <th><label>성별</label></th>
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
		                                onclick="location.href='${ pageContext.request.contextPath }/user/list.do'">  
		                  
		                  </td>
		              </tr>
		              
		              
				   </table>
				</div>
			</div>
		</div>
	</form>	
</body>
</html>