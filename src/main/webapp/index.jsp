<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    	<!-- Header -->

    
<!DOCTYPE html>
<html>

	<%@ include file="header.jsp" %>


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
	<div id="reg_login" class="nav">
		<div class="btn_box">
			<c:if test="${empty user}">
				<input class="nav_btn" type="button" id="register" value="회원가입" onclick="location.href='user/insert_form.do'">
				<input class="nav_btn" type="button" id="login" value="로그인" onclick="location.href='user/login_form.do'">
			</c:if>
				
			<c:if test="${ not empty user }">
				<c:if test="${ user.user_grade eq 'user_admin' }">
					<input type="button" class="nav_btn" value="시스템 관리" 
						onclick="location.href='admin/admin_page.do'">
				</c:if>
				<input type="button" class="nav_btn" id="logout" value="로그아웃" onclick="location.href='logout.do'">
			</c:if>
		</div>			
	</div>
		
<div class="w960 intro_bg">
    
    
	    
			
		<div class="news_box">
			<div id="goto">
				<div id="weather"><p class="f12 m_title">Weather</p>
					<div id="weather_forecast"></div>
				</div>
				<p class="f12 m_title">Service Menu</p>
				<div>
					<!-- 백상희 20240302 이미지 관련 수정 -->
					<div class="service_menu" onclick="location.href='board/list.do'">
						<p class="f12">운동 게시판</p>
						<input type="image" src="./img/main_icon01.png" class="btn_img" value="운동 게시판">
					</div>
					
					<div class="service_menu" onclick="move_health_page();">
						<p class="f12">나의 건강정보</p>
						<input type="image" src="./img/main_icon02.png" class="btn_img" value="나의 건강정보">
					</div>
					
				</div>
				
			</div>
		</div>
		
		


			
        <!-- Footer -->
    <%@ include file="footer.jsp" %>

</div>



</body>
</html>
