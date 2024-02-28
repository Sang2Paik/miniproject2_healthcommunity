<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"  %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    	<!-- Header -->

    
<!DOCTYPE html>
<html>

	<%@ include file="header.jsp" %>
	

<style type="text/css">
	

	
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

	
<body>
<div id="box" class="container w100">
    
    
	    <div id="reg_login" class="row w100 nav tt">
		    <div class="col-12 col-md-8"></div>
		    <div class="col-12 col-md-4">
				<c:if test="${empty user}">
					<input class="nav_btn" type="button" id="register" value="회원가입" onclick="location.href='user/insert_form.do'">
					<input class="nav_btn" type="button" id="login" value="로그인" onclick="location.href='user/login_form.do'">
				</c:if>
				<c:if test="${not empty user}">
					<input class="btn btn-primary" type="button" id="logout" value="로그아웃" onclick="location.href='user/logout.do'">
				</c:if>
			</div>
		</div>
		
		
		<div class="row w100">
			
			<div id="project_intro" class="col-8 bg-light border"><img src="./img/intro.png" class="img"></div>
			<div id="goto" class="col-4">
			
			<div id="weather">
				<p class="f12 m_title">Weather</p>
				<div id="weather_forecast"></div>
			</div>
				<p class="f12 m_title">Seviece Menu</p>
				<input type="image" src="./img/main_icon01.png" class="btn_img" value="운동 게시판" onclick="location.href='board/list.do'">
				<input type="image" src="./img/main_icon02.png" class="btn_img" value="나의 건강정보" onclick="move_health_page();">
			</div>
		</div>
	</div>
	
	
        <!-- Footer -->
    <%@ include file="footer.jsp" %>

</body>
</html>