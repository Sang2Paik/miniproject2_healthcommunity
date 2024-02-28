<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"  %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<style type="text/css">
	
	#box{
		width: 1000px;
		height: 800px;
		
	}
	
	#reg_login{
		text-align: right;
	}

	
	#goto{
		clear: both;
		text-align: center;
	}

</style>


<script type="text/javascript">

	//전역변수
	let latitude;
	let longitude;
	
	$(document).ready(function(){
		
//--------------------현재 위치 구하기---------------------
		
		//geolocation
		navigator.geolocation.getCurrentPosition((position) => {
			//console.log(position)
			latitude  = position.coords.latitude;
			longitude = position.coords.longitude;
			//console.log("----- [geolocation] -----");
			//console.log(latitude,longitude);
			
		},(error) => {
			//geolocation 미지원 시, https://api.ip.pe.kr/ 통해서 구하기 (정확도 떨어짐)
			
			$.ajax({
				url      : "https://api.ip.pe.kr/json/",
				dataType : "JSON",
				success  : function(res_data){

					alert(res_data.ip)
					
					$.ajax({
						url      : "http://ip-api.com/json/" + res_data.ip,
						dataType : "JSON",
						success  : function(data){
							latitude = data.lat;
							longitude= data.lon;
						},
						error    : function(err){
							alert(err.responseText);
						}
					});
				},
				error    : function(err){
					alert(err.responseText);
				}
			});
		});
		
		weather_show();

		
		/* ajax weather-forecast */
		function weather_show(){			
			//Ajax
			$.ajax({
				url		:	"weather/list.do",        //WeatherController
				data	:	{"lat":latitude,"lon":longitude},
				success	:	function(res_data){					
					$("#weather_forecast").html(res_data);
				},
				error	:	function(err){
					alert(err.responseText);
				}				
			});			
		}
	});
		
</script>
<script type="text/javascript">
	
	function move_health_page(){
		
		if(${empty user} == true){
			
			if(confirm("로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?")==true){
				location.href="user/login_form.do";
			}
			
			return;
		}
		
		location.href="user/mypage_main.do";
	}
</script>


</head>
<body>
	<div id="box">
	
		<div id="reg_login">
			<c:if test="${empty user}">
				<input type="button" id="register" value="회원가입" onclick="location.href='user/insert_form.do'">
				<input type="button" id="login" value="로그인" onclick="location.href='user/login_form.do'">
			</c:if>
			<c:if test="${not empty user}">
				<input type="button" id="logout" value="로그아웃" onclick="location.href='user/logout.do'">
			</c:if>
		</div>
		
		<div id="project_intro">
			<p>
				<h3>
					우리 프로그램 설명 <br>
					Blah Blah Blah <br>
					Blah Blah Blah <br>
				</h3>
			</p>
		</div>
		
		
		
		<div id="weather">
			<div id="weather_forecast"></div>
		</div>
		<div id="goto">

			<input type="button" value="운동 게시판" onclick="location.href='board/list.do'">
			<input type="button" value="나의 건강정보" onclick="move_health_page();">

		</div>
		
	</div>
</body>
</html>