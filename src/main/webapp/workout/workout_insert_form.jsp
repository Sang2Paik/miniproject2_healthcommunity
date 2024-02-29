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
	#box{

		/* border: solid green 1px; */
		margin: auto;
		margin-top: 30px;
		padding: 10px;
	}

</style>



<script type="text/javascript">

	$(document).ready(function(){
		
		//날짜 DatePicker
 		$("#myDatePicker").datepicker({
		  showButtonPanel: true,
		  currentText: '오늘날짜',
		  closeText:'닫기',
		  dateFormat:'yy-mm-dd',
		}).datepicker("setDate",'now')
	}); 
		
/* 		let page = 1;
		let perPage = 360;
		
		$.ajax({
			
			url       : "workout_cal_list.do",        //WorkoutController
			data      : {"page" : page, "perPage" : perPage},
			success   : function(res_data){
				$("#workout_info").html(res_data);
			},
			error     : function(err){
				alert(err.responseText);
			}
			
		}); */
		

	
	
	
	function workout_search(){
		
		let search_text = $("#search_text").val().trim();
		let page = 1;
		let perPage = 360;
		
		$.ajax({
			
			url : "search.do",
			data : {
				"search_text" : search_text,
				"page"        : page,
				"perPage"     : perPage
			},
			//dataTaype : "json",
			success   : function(res_data) {
				$("#workout_info").html(res_data);
			},
			error     : function(error){
				alert(err.responseText);
			}
			
		});
	}
		
	function workout_search_all(){

		let page = 1;
		let perPage = 360;
		
		$.ajax({
			
			url       : "workout_cal_list.do",        //WorkoutController
			data      : {"page" : page, "perPage" : perPage},
			success   : function(res_data){
				$("#workout_info").html(res_data);
			},
			error     : function(err){
				alert(err.responseText);
			}
			
		});
	}
		
/* //s----		
		let search_text = $("#search_text").val().trim();
		let page = 1;
		let perPage = 360;
		
		//검색어가 비어있으면
		if(search_text==''){
			alert('검색어를 입력하세요!');
			$("#search_text").val("");
			$("#search_text").focus();
			return;
		}
		
		location.href="search.do?page="+page+"&perPage="+perPage+"&search_text="+encodeURIComponent(search_text,"utf-8");   //한글넘길때는 인코딩 필요
//e-----		 */
		
	
	
	
</script>




</head>
<body>
	<div id="box">
		<div id="workout_select">
			<h3>나의 운동 입력</h3>
	 		<div>
				날짜<br>
				<input id="myDatePicker" name="w_regdate" value="${ param.search_text }">
			</div>
			운동 검색
			<div>
				<input id="search_text" type="text">
				<input id="" type="button" value="검색" onclick="workout_search();">
				<input id="" type="button" value="전체보기" onclick="workout_search_all();">
				<input id="" type="button" value="MyPage" onclick="location.href='../user/mypage_main.do'">
			</div>
		</div>
		
		
		<div id="workout_info"></div>
		
	</div>

	
</body>
</html>
