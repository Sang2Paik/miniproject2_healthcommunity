<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<%@ include file="../header.jsp" %>

<!-- Bootstrap 3.x -->

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- date picker -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>


<style type="text/css">
/* 	#box{

		margin: auto;
		margin-top: 30px;
		padding: 10px;
	}
	 */
	#myDatePicker {
		color: black !important;
		width: 200px !important;
		
	}
	.btn {
		margin: 0px;
		padding: 0px;
		font-size: 10px;
	}
	.row {
		padding: 0px;
	}

</style>



<script type="text/javascript">

	
	
	$(document).ready(function(){
		
		let w_regdate = encodeURIComponent("${param.w_regdate}","utf-8");
		//console.log(w_regdate);
		
		//날짜 DatePicker
 		$("#myDatePicker").datepicker({
		  showButtonPanel: true,
		  currentText: '오늘날짜',
		  closeText:'닫기',
		  dateFormat:'yy-mm-dd',
		}).datepicker("setDate",'now')
		
		if( w_regdate != null || w_regdate !=""){
			$("#myDatePicker").val(w_regdate);
			
			return;
		}
	}); 
	
	
	function workout_search(){
		
		let search_text = $("#search_text").val().trim();
		
		//검색어가 비어있으면
		if(search_text==''){
			alert('검색어를 입력하세요!');
			$("#search_text").val("");
			$("#search_text").focus();
			return;
		}
		
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
		
		$("#search-text").val('');
		
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
			
	
</script>




</head>
<body>
<section class="vh-100 gradient-custom">
<div class="container py-5 h-100">
<div class="row d-flex justify-content-center align-items-center h-100">
<div class="col-12 col-md-8 col-lg-6 col-xl-5">
<div class="card main_bg text-white" style="border-radius: 1rem;">
<div class="card-body p-5 text-center">
<div class="mb-md-5 mt-md-4 pb-5">

			<h2 class="fw-bold mb-2 text-uppercase">
				<img src="${ pageContext.request.contextPath }/img/login_title.png">
				<br>${ user.user_name }님의 운동 입력
			</h2>
			<div class="form-outline form-white mb-4" style="width: 80%; margin: 0 auto;">	
	 		<div style="text-align: center !important;">
				날짜<br>
				<input class="form-control" id="myDatePicker" name="w_regdate" value="${ param.search_text }">
			</div>
			</div>
			운동 검색
			<div class="form-outline form-white mb-4 row" style="width: 80%; margin: 0 auto;">
				<div class="col-sm-6">
					<input class="form-control btn" id="search_text" type="text">
				</div>
				<div class="btn col-sm-2">
					<input class="form-control btn" id="search" type="button" value="검색" onclick="workout_search();">
				</div>
				<div class="btn col-sm-2">
					<input class="form-control btn" id="search_all" type="button" value="전체보기" onclick="workout_search_all();">
				</div>
				<div class="btn col-sm-2">
					<input class="form-control btn" id="goto_mypage" type="button" value="MyPage" onclick="location.href='../user/mypage_main.do'">
				</div>
			</div>
		
		
		<div id="workout_info"></div>
		
</div>
</div>
</div>
</div>
</div>
</div>
</section>	
</body>
</html>
