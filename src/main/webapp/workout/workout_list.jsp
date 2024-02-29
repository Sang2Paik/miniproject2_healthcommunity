<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- Bootstrap 3.x -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- date picker -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>


<style type="text/css">

	#workout_select_list{
		float: left;
		border: solid gray 1px;
		max-height: 440px;
		width: 410px;
		resize: none; 
		margin: 10px;
		margin-left: 0px;
		padding: 10px;
		overflow-y: scroll;
	}
	#workout_calculate{
		float: left;
		border: solid gray 1px;
		margin: 10px;
		padding: 10px;
	}
	
	#box{

		/* border: solid green 1px; */
		margin: auto;
		margin-top: 30px;
		padding: 10px;
	}

	#met_info{
		font-size: 10px;
	}
	td, th{
		text-align: center;
	}

</style>

<script type="text/javascript">


</script>


<script type="text/javascript">

	$(document).ready(function(){
		
		$("#kcal").hide();

	});
	
	
 	function workout_select(workout_name,cal_per_unit) {
		
		$("#workout_selected_name").val(workout_name);
		$("#workout_selected_met").val(cal_per_unit);
		//$("#w_regdate").val(w_regdate);
		
	} 


	function workout_cal_calulate() {

		$("#kcal").show();
		let workout_selected_name ;
		let user_kg       ;
		let workout_time  ;
		let cal_per_unit  ;
		let burned_calory ;
		
		workout_selected_name = $( "#workout_selected_name" ).val();
		cal_per_unit = $( "#workout_selected_met" ).val();
		
		user_kg	     = $( "#weight" ).val();
		workout_time = $( "#workout_time" ).val();
		
		if(workout_selected_name==''){
			alert('운동을 선택하세요!');
			$( "#workout_selected_name" ).val('');
			$( "#workout_selected_name" ).focus();
			return;
	  	}
		
		if(workout_time==''){
			alert('운동시간을 입력하세요!');
			$( "#workout_time" ).val('');
			$( "#workout_time" ).focus();
			return;
	  	}
		
		if(user_kg==''){
			alert('몸무게를 입력하세요!');
			$( "#weight" ).val('');
			$( "#weight" ).focus();
			return;
	  	}

		burned_calory = Math.round(3.5* cal_per_unit * user_kg * workout_time /1000 * 5);
		
		console.log(burned_calory);
		
		//결과값을 결과창에 출력
		$("#burned_calory").html(burned_calory);
		$("#kcal").show();
	}
	
	function workout_insert() {
		
		let w_regdate = $("#myDatePicker").val().trim();
		console.log(w_regdate);
		if(w_regdate==''){
			alert('날짜를 선택하세요!');
			$( "#myDatePicker" ).val('');
			$( "#myDatePicker" ).focus();
			return;
	  	}
		
		let w_name		= $("#workout_selected_name").val();
		let w_unit_kcal = $("#burned_calory").html();
		let w_time		= $("#workout_time").val();
		
		if(w_unit_kcal == ''){
			alert('칼로리를 계산하세요!');
			return;
		}

		location.href="workout_insert.do?w_name=" + encodeURIComponent(w_name,"utf-8") + "&w_unit_kcal=" + w_unit_kcal + "&w_time=" + w_time + "&w_regdate=" + w_regdate;
//		location.href = String.format("my_workout_list.do?w_name=%s&w_unit_kcal=%s&w_time=%d", w_name, w_unit_kcal, w_time);
		
	}

</script>


</head>
<body>
	
 	<div id="box">

		<form>
	
			<div id="workout_select_list">
				<table>
					<tr>
						<th>
							번호
						</th>
						<th>
							운동명
						</th>
						<th>
							MET
						</th>
						<th>
							선택
						</th>
					</tr>
					<c:forEach var="vo" items="${ list }" varStatus="i">
						<tr>
							<td>
								${ i.count }
							</td>
							<td id="workout_name">
								${ vo.workout_name }
							</td>
							<td id="workout_met">
								${ vo.cal_per_unit }
							</td>
							<td>
								<input class="" type="button" value="선택" onclick="workout_select('${ vo.workout_name }', '${ vo.cal_per_unit }');">
							</td>
						</tr>
					</c:forEach>
				</table>
			</div> 
		</form>

		
		<div id="workout_calculate">
			
			<div id="workout_selected">
				<div>
			 		<b>날짜</b> 
			 	</div>
			 		<span id=""></span>
			 	
			 	<div>
			 		<b>선택된 운동</b>
			 	</div>
			    <input id="workout_selected_name" type="text" placeholder="운동명을 선택하세요">
			    <br>
			    <input id="workout_selected_met" type="text" placeholder="MET">(MET) 
			</div>
			<br>
			<div>
				<b>운동 시간 입력</b>
				<br>
				<input id="workout_time" type="text" placeholder="분 단위로 입력하세요">(분)
			</div>
			<br>
			<div>
				<b>나의 몸무게 입력</b>
				<br>
				<input id="weight" type="text" placeholder="kg단위로 입력하세요">(kg)
				user.user_kg 기본값 설정 예정
			</div>
			<br>
			<input type="button" id="workout_cal_calulate" value="태운 칼로리 계산" onclick="workout_cal_calulate();">
			<br>	
			<div>
				<span id="burned_calory" style="font-size: 30px; font-weight: bold;"></span>
				<span id="kcal"style="font-size: 25px; color: red">Kcal</span>
			</div>
			<br>
			<div id="met_info" style="font-size: 10px;">
				<b>[칼로리 계산 방법]</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
				1MET	         = 1 * 3.5ml / kg /min<br>
				산소소비량(L)	     = MET * (3.5 * weight * min) / 1000<br>
				칼로리소모량(kcal)	 = 산소소비량 * 5
			</div>
			<br>
			
			
			<div>
				<input class="" type="button" value="내 운동으로 등록하기" onclick="workout_insert();">
			</div>
			
		</div> 
	</div>
		
</body>
</html>
