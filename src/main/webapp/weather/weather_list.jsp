<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Bootstrap 3.x library -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script src="https://kit.fontawesome.com/4309bb14e1.js" crossorigin="anonymous"></script>

<style type="text/css">

	.weather_box {
	 	width: 400px;   /* width 400으로 조정 */
	 	height: 180px;
	 	background-color : rgb(22,180,180);   /* 색깔 수정 03-04 */
	 	margin: auto;
	 	padding : 10px;
	 	padding-top: 0px;
	 	color : #fff; 
 	}
 	.weather_des{
 		width: 65%;
 		float: left;
 		text-align: left;
 		margin: 0px;
 		padding: 0px;
 		margin-top: 0px;
 	}
 	#weather_icon{
 		margin: 0px;
 	}
 	
 	.weather_con {
 		width: 35%;
 		float: right;
 		text-align: left;
 		margin: 0px;
 		padding: 0px;
 		padding-left: 0px;
 	}
 	
 	#temp{
 		font-size: 15pt;
 	}
 	
 	#description{
 		font-size: 15pt;
 	}
 	
 	.weather_recommend{
 		clear: both;
 		width: 100%;
 		width: 300px;
 		padding-top: 10px;
 	}


</style>


</head>


<body>

	<div class="weather_box">
		<c:forEach var="vo"  items="${ weather_list }">
			 
				<div class="weather_des">
					<div id="weather_icon">
						<img class = "weather_icon" src="http://openweathermap.org/img/wn/${ vo.icon }@2x.png">
					</div>
					<div id="description">${ vo.description }</div>
				</div>
				<div class="weather_con">
					<br>
					<div id="name">${ vo.name }</div>
					<br>
					<div id="temp">현재 ${ vo.temp }°C</div>
					<div id="temp_min">최저 ${ vo.temp_min }°C</div>
					<div id="temp_max">최고 ${ vo.temp_max }°C</div>

				</div>
			<div class="weather_recommend">
				<c:if test="${ (vo.icon eq '01d') || (vo.icon eq '01n') || 
							   (vo.icon eq '02d') || (vo.icon eq '02n') || 
							   (vo.icon eq '03d') || (vo.icon eq '03n') || 
							   (vo.icon eq '04n') || (vo.icon eq '04d') }">
					
					<p style="display: inline-block;"> 운동하기 좋은 날씨입니다. 튀어 나가세요!</p>
					<i class="fa-solid fa-person-running"></i>
				</c:if>
				<c:if test="${ (vo.icon != '01d') && (vo.icon != '01n') && 
							   (vo.icon != '02d') && (vo.icon != '02n') && 
							   (vo.icon != '03d') && (vo.icon != '03n') && 
							   (vo.icon != '04n') && (vo.icon != '04d') }">
					
					<p style="display: inline-block;"> 집에서 홈트나 하세요!</p>
					<i class="fa-solid fa-dumbbell"></i>
				</c:if>

			</div>

		</c:forEach>
	</div>

</body>
</html>
