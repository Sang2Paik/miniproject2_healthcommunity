<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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

<!-- chart.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.0/chart.umd.min.js"></script>

<!-- sweet alert -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style type="text/css">

 	#box{
		margin: auto;
		padding: 0px; 
		width: 100%;
		color: black;
		text-align: center;
	} 
	
 	#box_modal{
		color: black;
	} 


	
/* 	#myDatePicker {
		color: black !important;
		width: 150px !important;
	} */
	
	th, td {
		text-align: center;
	}
	
	#my_workout_list {
		
		padding: 0px;
		border: solid #16b4ce 3px;
		width: 100% !important;
		max-height: 300px;
		overflow-y: scroll;
		text-align: center !important;
	}
	
	#my_workout_stat {
		width: 100% !important;
		resize: none;
		text-align: center !important;
	}
	
	#myChart{
		width: 100% !important;
		height: 300px !important;
	}
	#search_date{
		font-size: 17px;
	}
	
	#kcal_sum_list{
		width: 100px;
		font-size: 20px; 
		color: black
	}
	
/* 	.workout_btn{
		font-size: 15px;
		border: 0px;
		width: 100px;
		height: 30px;
		background: white;
		color: black;
	} */
	
	.list_table1{
		boder: solid white 1px;
		width: 100%;
	}
	.list_table2{
		width: 100%;
		resize: none;
		color: black;
	}
	
/* 	table{
		width: 370px important;
		resize: none;
		
	} */
	
   	.btn_wa, .btn_da {
		width: 120px !important;
		height: 30px !important;
		margin-left: 10px;
		padding: 0px;

	}   
	
	.del_btn{
		width: 40px !important;
		height: 20px;
		margin: 0px;
		padding: 0px;
		text-align: center;
	}

</style>

<script type="text/javascript">
	let regdate_list  = [];
	let w_name_list	  = [];
	let w_time_list   = [];
	let cal_list	  = [];
	let kcal_sum_list = [];
	
	$(document).ready(function(){	//상세보기로 모달처리??
			

		//$("#cal_sum").hide();
		
		//날짜 DatePicker
 		$("#myDatePicker").datepicker({
		  showButtonPanel: true,
		  currentText: '오늘날짜',
		  closeText:'닫기',
		  dateFormat:'yy-mm-dd'
 		 }).datepicker("setDate",'${ param.w_regdate }')

		let search_text = $("#myDatePicker").val().trim();
 		$.ajax({
			url : "my_workout_calculate.do",
			dataType : "json",
			success : function(res_data){
				//console.log(res_data.list[0].total_sum);
				
 	 			for(let i = 0; i<res_data.list.length; i++){
					regdate_list.push(res_data.list[i].regdate);
					kcal_sum_list.push(res_data.list[i].total_sum);
					//console.log(res_data.list[i].regdate);
				}  
				
  				let myCt = document.getElementById("myChart");
			
				let myChart = new Chart(myCt, {
					
					type : 'bar',
					data : {
						labels : regdate_list, //x축
						datasets : [
							{
							label : '일일 소모 kcal',
							data  : kcal_sum_list, //값
							backgroundColor: '#dd3355'
							}
							
						]
					},
			
				}); //chart   
							
				
			},
			error : function(error){
				alert(error.responseText);
			}
		}); //ajax
		
		$.ajax({
			url : "my_workout_calculate_search.do",
			data  : {
				"w_regdate" : search_text,
			},
			dataType : "json",
			success : function(res_data){
				//console.log(res_data.list);
 				
				try {
					$("#kcal_sum_list").html(res_data.list[0].total_sum);
				} catch (e) {
					// TODO: handle exception
					//e.printStackTrace(); //예외정보 출력
					$("#kcal_sum_list").html(0);
				}

			},
			error : function(error){
				alert(error.responseText);
			}
		}); //ajax

		
	});
	
	

	function search(){  
		
		$("#cal_sum").show();
		let search_text = $("#myDatePicker").val().trim();
		
		$("#search_date").html(search_text)
		
        if(search_text=="") {
        	alert('날짜를 선택하세요');
        	
        	$("#myDatePicker").val("");
    		$("#kcal_sum_list").val("");
    		
    		location.href="my_workout_list.do";
        	
    		return;
        }
        
 		$.ajax({
			url : "my_workout_calculate_search.do?w_regdate=" + search_text,
			data  : {
				"w_regdate" : search_text,
			},
			dataType : "json",
			success : function(res_data){
				//console.log(res_data.list);
 				
				try {
					$("#kcal_sum_list").html(res_data.list[0].total_sum);
				} catch (e) {
					// TODO: handle exception
					//e.printStackTrace(); //예외정보 출력
					$("#kcal_sum_list").html(0);
				}

			},
			error : function(error){
				alert(error.responseText);
			}
		}); //ajax
		
       
	} // end:search
	
	function show_list(){  //전체 보기  (모달로 구현 필요??)
		
		$("#myDatePicker").val("");
		$("#kcal_sum_list").val("");
		
		const today = new Date();
		const year = today.getFullYear();
		const month = today.getMonth() + 1;
		const day = today.getDate();

		const w_today = ${year} + "-" + ${month} + "-" ${day};
		
		location.href="my_workout_list.do?regdate=" + w_today;
		
	}
		
	function workout_detail() {  //세부 정보 모달로 보기
		
		let search_text = $("#myDatePicker").val().trim();
		
		if($("#kcal_sum_list").html() == 0){
			
			Swal.fire({
			  title: "운동을 하지 않으셨군요!",
			  text: "게을러지면 안돼요",
			  imageUrl: "../img/tongtong.jpeg",
			  imageWidth: 400,
			  imageHeight: 200,
			  imageAlt: "Custom image"
			  
			});//swal
			
			return;
			
		}else{

			$.ajax({
				url : "my_workout_list_search.do",
				data  : {"w_regdate" : search_text},
	  		 	dataType : "json",   
				success : function(res_data){
					  //팝업창(Modal)
					  //console.log(1);
					$("#btn_modal").click();
					//console.log(res_data.list[2].w_time);
					//console.log(res_data.list.length);
					let html_title = "<h4>일일 소모 칼로리 상세정보 (" + res_data.list[0].regdate + ")<h4>"
					
					$("#my_workout_info_title").html(html_title);
					
					let html_tr="<tr><th>날짜</th><th>운동명</th><th>운동시간(분)</th><th>소모칼로리(Kcal)</th>";
	  	 			for(let i = 0; i<res_data.list.length; i++){
						
	  	 				html_tr += "<tr>";
	  	 				html_tr += "<td>" + res_data.list[i].regdate   + "</td>";
	  	 				html_tr += "<td>" + res_data.list[i].w_name   + "</td>";
	  	 				html_tr += "<td>" + res_data.list[i].w_time   + "</td>";
	  	 				html_tr += "<td>" + res_data.list[i].w_unit_kcal_dot2  + "</td>";
	  	 				//html_tr += "<td><input id='my_w_modify' type='button' value='수정' onclick='modify(" + res_data.list[i].w_idx + "," + res_data.list[i].regdate + ");'></td>";
	  	 				html_tr += "<td><input class= 'btn btn_del btn-gradient red mini' id='my_w_delete' type='button' value='삭제' onclick='del(" + res_data.list[i].w_idx + "," + res_data.list[0].regdate + ");'></td>";
	  	 				html_tr += "</tr>";
						
	  	 				//console.log(res_data.list[i].regdate);
	 	 			} //for
	  	 			
	  	 			//console.log(html_tr);
	  	 			
	  	 			$("#disp1").html(html_tr);
	 	 			
				},
				error   : function(error){
					alert(error.responseText);
				}
	
			}); //ajax
		} //if-else
	}

</script>

</head>
<body>


<!-- Modal창(팝업창)  -->
<%@include file="my_workout_list_search_popup.jsp" %>
	<table class="table">
		<tr>
			<td><input type="button" class="nav_btn" value="나의 건강정보"
				onclick="show_health_info();"> <input type="button"
				class="nav_btn" value="나의 기본정보" onclick="show_basic_info();">
				<input type="button" class="nav_btn" value="나의 갤러리"
				onclick="my_board_info();"></td>
		</tr>
	</table>


 	<div id="box"> 
		<div>
			<h3><b><span id="myself">${ user.user_name }</span>님의 일별 운동 내역</b></h3>
		</div><br>
		<div class="form-outline form-white mb-4 row" style="width: 60%; margin: 0 auto;">
			<input class="form-control" style="width:40%; display:inline-block;" id="myDatePicker" name="search_text" value="${ param.search_text }">

	<!-- 	<div class="form-outline form-white mb-4 row" style="width: 80	%; margin: 0 auto;">
 -->
			<input class="btn btn_wa btn-gradient cyan mini"  type="button" value="날짜검색" onclick="search();">
			<input class="btn btn_wa btn-gradient cyan mini" type="button" value="전체보기" onclick="show_list();">
<!-- 			<input class="btn btn-gradient cyan block" style="display:inline-block" type="button" value="MyPage" onclick="location.href='../user/mypage_main.do'">
 -->
		</div>
		<div class="form-outline form-white mb-4 row" style="width: 80%; margin: 0 auto; text-align: center;">
			<div id="my_workout_stat">
				<br>
				일일 소모 칼로리
				<br>
				<canvas id="myChart"></canvas>
				<br>
				<div id="cal_sum">
					<span id="search_date"></span>
					<span> 소모 칼로리는 </span>
					<span id="kcal_sum_list"></span>
	<!-- 				<input type="text" id="kcal_sum_list" disabled="disabled"> -->
					<span style="font-size: 15px; color: red">kcal</span>
					
					<!-- 모달로 상세보기 -->
					&nbsp;
					<input type="button" class="btn btn_da btn-gradient cyan mini" value="상세보기" onclick="workout_detail();">
					<input type="button" class="btn btn_da btn-gradient cyan mini" value="운동추가" onclick="location.href='workout_insert_form.do?w_regdate= ${ param.search_text}'">
				</div>
			</div>
		</div>

		<br>
		<div class="form-outline form-white mb-4 row" style="width: 80%; margin: 0 auto; text-align: center;">
			<div style="text-align:left;">
				<b>전체 운동 상세정보</b>
			</div>
			<div id="my_workout_list">
				
				<table class="table form-class list_table1">
					<tr>
						<th>
							날짜
						</th>
						<th>
							운동명
						</th>
						<th>
							운동시간(분)
						</th>
						<th>
							소모칼로리 (Kcal)
						</th>
					<c:forEach var="vo" items="${ list }" varStatus="i">
						<tr>
							<td>
								<span id="regdate">${ fn:substring(vo.w_regdate, 0, 10) }</span>
							</td>
							<td>
								${ vo.w_name }
							</td>
							<td>
								${ vo.w_time }
							</td>
							<td>
								<span id="kcal">${ vo.w_unit_kcal_dot2 }</span>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
	
<!-- 	<div id="disp_res_data"> 
	
 	</div> -->
	
	
</body>
</html>
