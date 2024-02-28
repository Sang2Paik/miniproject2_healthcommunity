<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"  %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- Bootstrap 3.x -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript">

	$(document).ready(function(){
		
		let BMI = '${user.user_BMI}';
		
		if(BMI < 18.5){
			$("#my_status").text("저체중");
			$("#my_status_img").attr("src", "../img/Lenny.png");
		}else if (BMI > 18.5 && BMI <= 23){
			$("#my_status").text("정상");
			$("#my_status_img").attr("src", "../img/thumbs.png");
		}else if (BMI > 23 && BMI <= 25){
			$("#my_status").text("과체중");
			$("#my_status_img").attr("src", "../img/tongtong.jpeg");
		}else if (BMI > 25){
			$("#my_status").text("비만");
			$("#my_status_img").attr("src", "../img/pig.jpeg");
		}
		
	});

</script>
<script type="text/javascript">
	
	function show_health_info(){
		
		$("#my_health_info").show();
		
	}
	
	function show_basic_info(){
		
		$("#my_health_info").hide();
		
	}

</script>
</head>
<body>

	<table>
		<tr>
			<td>
				<input type="button" value="나의 건강정보" onclick="show_health_info();">
				<input type="button" value="나의 기본정보" onclick="show_basic_info();">
			</td>
		</tr>
	</table>
	
	<div id="my_health_info">
		<table>
			<tr>
				<th>나의 BMI 지수</th>
				<td>${user.user_BMI}</td>
				<td id="my_status" style="font-size: 20px;"></td>
				<td><img id="my_status_img" alt="비만" src=""></td>
			</tr>
			<tr>
				<th>키</th>
				<td>${user.user_height}&nbsp;cm</td>
			</tr>
			<tr>
				<th>몸무게</th>
				<td>${user.user_kg}&nbsp;kgs</td>
			</tr>
			<tr>
				<th>나의 목표</th>
				<td>${user.user_target}&nbsp;kgs</td>
			</tr>
			<tr>
				<th>일일 활동 칼로리</th>
				<td>
					<input type="button" value="입력" onclick="location.href='../workout/workout_insert_form.do'">
					<input type="button" value="보기" onclick="location.href='../workout/my_workout_list.do'">
				</td>
			</tr>
			<tr>
				<th>음식 칼로리</th>
				<td>
					<input type="button" value="입력" onclick="location.href='../food/insert_basic.do'">
					<input type="button" value="보기" onclick="location.href='../food/food_cal_list.do'">
				</td>
			</tr>
			<tr>
				<td>오늘 먹은 칼로리<span id="today_cal">${today_food_kcal}</span>&nbsp;kcals</td>
			</tr>
			<tr>
				<td>오늘 태운 칼로리<span id="today_cal">${today_workout_kal}</span>&nbsp;kcals</td>
			</tr>
		
		</table>
	</div>
	
	
	<div id="my_basic_info"></div>

</body>
</html>
